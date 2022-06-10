/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.security.component;

import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.util.RandomUtil;
import com.albedo.java.modules.sys.domain.PersistentTokenDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.feign.RemotePersistentTokenService;
import com.albedo.java.modules.sys.feign.RemoteUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.rememberme.AbstractRememberMeServices;
import org.springframework.security.web.authentication.rememberme.CookieTheftException;
import org.springframework.security.web.authentication.rememberme.InvalidCookieException;
import org.springframework.security.web.authentication.rememberme.RememberMeAuthenticationException;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Optional;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 10:01 下午
 */
@Component
@Slf4j
public class PersistentTokenRememberMeService extends AbstractRememberMeServices {

	/**
	 * Token is valid for one month
	 */
	private static final int TOKEN_VALIDITY_DAYS = 31;

	private static final int TOKEN_LENGTH = 2;

	private static final int TOKEN_VALIDITY_SECONDS = 60 * 60 * 24 * TOKEN_VALIDITY_DAYS;

	private static final long UPGRADED_TOKEN_VALIDITY_MILLIS = 5000L;

	private final PersistentTokenCache<UpgradedRememberMeToken> upgradedTokenCache;

	private final RemoteUserService userService;

	private final RemotePersistentTokenService persistentTokenService;

	protected PersistentTokenRememberMeService(ApplicationProperties applicationProperties,
											   UserDetailsService userDetailsService, RemotePersistentTokenService persistentTokenService,
											   RemoteUserService userService) {
		super(applicationProperties.getSecurity().getRememberMe().getKey(), userDetailsService);
		setCookieName("rememberMe");
		setParameter("rememberMe");
		this.persistentTokenService = persistentTokenService;
		this.userService = userService;
		upgradedTokenCache = new PersistentTokenCache<>(UPGRADED_TOKEN_VALIDITY_MILLIS);
	}

	@Override
	protected UserDetails processAutoLoginCookie(String[] cookieTokens, HttpServletRequest request,
												 HttpServletResponse response) {
		// prevent 2 authentication requests from the same user in parallel
		synchronized (this) {
			if (cookieTokens == null) {
				return null;
			}
			String login = null;
			UpgradedRememberMeToken upgradedToken = upgradedTokenCache.get(cookieTokens[0]);
			if (upgradedToken != null) {
				login = upgradedToken.getUserLoginIfValid(cookieTokens);
				log.debug("Detected previously upgraded login token for user '{}'", login);
			}

			if (login == null) {
				PersistentTokenDo persistentTokenDo = getToken(cookieTokens);
				UserDo userDo = userService.selectById(persistentTokenDo.getUserId());
				login = userDo.getUsername();

				// Token also matches, so login is valid. Update the token value, keeping
				// the *same* series number.
				log.debug("Refreshing persistent login token for user '{}', series '{}'", login,
					persistentTokenDo.getSeries());
				persistentTokenDo.setTokenDate(LocalDateTime.now());
				persistentTokenDo.setTokenValue(RandomUtil.generateTokenData());
				persistentTokenDo.setIpAddress(WebUtil.getIp(request));
				persistentTokenDo.setUserAgent(request.getHeader(HttpHeaders.USER_AGENT));
				try {
					persistentTokenService.updateById(persistentTokenDo);
				} catch (DataAccessException e) {
					log.error("Failed to update token: ", e);
					throw new RememberMeAuthenticationException("Autologin failed due to data access problem", e);
				}
				addCookie(persistentTokenDo, request, response);
				upgradedTokenCache.put(cookieTokens[0], new UpgradedRememberMeToken(cookieTokens, login));
			}
			return getUserDetailsService().loadUserByUsername(login);
		}
	}

	@Override
	protected String[] decodeCookie(String cookieValue) throws InvalidCookieException {
		try {
			return super.decodeCookie(cookieValue);
		} catch (Exception e) {
			throw new InvalidCookieException("invalid Cookie token");
		}
	}

	@Override
	protected void onLoginSuccess(HttpServletRequest request, HttpServletResponse response,
								  Authentication successfulAuthentication) {

		String login = successfulAuthentication.getName();

		log.debug("Creating new persistent login for user {}", login);
		PersistentTokenDo persistentTokenDo = Optional.of(userService.findVoByUsername(login)).map(u -> {
			PersistentTokenDo t = new PersistentTokenDo();
			t.setSeries(RandomUtil.generateSeriesData());
			t.setUserId(u.getId());
			t.setUsername(u.getUsername());
			t.setTokenValue(RandomUtil.generateTokenData());
			t.setTokenDate(LocalDateTime.now());
			t.setIpAddress(WebUtil.getIp(request));
			t.setLoginLocation(AddressUtil.getRegion(t.getIpAddress()));
			t.setUserAgent(request.getHeader(HttpHeaders.USER_AGENT));
			UserAgent userAgent = UserAgentUtil.parse(t.getUserAgent());
			t.setBrowser(userAgent.getBrowser().getName());
			t.setOs(userAgent.getOs().getName());
			return t;
		}).orElseThrow(() -> new UsernameNotFoundException("User " + login + " was not found in the database"));
		try {
			persistentTokenService.insert(persistentTokenDo);
			addCookie(persistentTokenDo, request, response);
		} catch (DataAccessException e) {
			log.error("Failed to save persistent token ", e);
		}
	}

	/**
	 * When logout occurs, only invalidate the current token, and not all user sessions.
	 * <p>
	 * The standard Spring Security implementations are too basic: they invalidate all
	 * tokens for the current user, so when he logs out from one browser, all his other
	 * sessions are destroyed.
	 *
	 * @param request        the request.
	 * @param response       the response.
	 * @param authentication the authentication.
	 */
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
		String rememberMeCookie = extractRememberMeCookie(request);
		if (rememberMeCookie != null && rememberMeCookie.length() != 0) {
			try {
				String[] cookieTokens = decodeCookie(rememberMeCookie);
				PersistentTokenDo persistentTokenDo = getToken(cookieTokens);
				persistentTokenService.deleteById(persistentTokenDo.getSeries());
			} catch (InvalidCookieException ice) {
				log.info("Invalid cookie, no persistent token could be deleted", ice);
			} catch (RememberMeAuthenticationException rmae) {
				log.debug("No persistent token found, so no token could be deleted", rmae);
			}
		}
		super.logout(request, response, authentication);
	}

	/**
	 * Validate the token and return it.
	 */
	private PersistentTokenDo getToken(String[] cookieTokens) {
		if (cookieTokens.length != TOKEN_LENGTH) {
			throw new InvalidCookieException("Cookie token did not contain " + TOKEN_LENGTH + " tokens, but contained '"
				+ Arrays.asList(cookieTokens) + "'");
		}
		String presentedSeries = cookieTokens[0];
		String presentedToken = cookieTokens[1];
		PersistentTokenDo persistentTokenDo = persistentTokenService.selectById(presentedSeries);
		if (persistentTokenDo == null) {
			// No series match, so we can't authenticate using this cookie
			throw new RememberMeAuthenticationException("No persistent token found for series id: " + presentedSeries);
		}
		// We have a match for this user/series combination
		log.info("presentedToken={} / tokenValue={}", presentedToken, persistentTokenDo.getTokenValue());
		if (!presentedToken.equals(persistentTokenDo.getTokenValue())) {
			// Token doesn't match series value. Delete this session and throw an
			// exception.
			persistentTokenService.deleteById(persistentTokenDo.getSeries());
			throw new CookieTheftException(
				"Invalid remember-me token (Series/token) mismatch. Implies previous " + "cookie theft attack.");
		}
		if (persistentTokenDo.getTokenDate().plusDays(TOKEN_VALIDITY_DAYS).isBefore(LocalDateTime.now())) {
			persistentTokenService.deleteById(persistentTokenDo.getSeries());
			throw new RememberMeAuthenticationException("Remember-me login has expired");
		}
		return persistentTokenDo;
	}

	private void addCookie(PersistentTokenDo persistentTokenDo, HttpServletRequest request, HttpServletResponse response) {
		setCookie(new String[]{persistentTokenDo.getSeries(), persistentTokenDo.getTokenValue()}, TOKEN_VALIDITY_SECONDS,
			request, response);
	}

	private static class UpgradedRememberMeToken implements Serializable {

		private static final long serialVersionUID = 1L;

		private final String[] upgradedToken;

		private final String userLogin;

		UpgradedRememberMeToken(String[] upgradedToken, String userLogin) {
			this.upgradedToken = upgradedToken;
			this.userLogin = userLogin;
		}

		String getUserLoginIfValid(String[] currentToken) {
			if (currentToken[0].equals(this.upgradedToken[0]) && currentToken[1].equals(this.upgradedToken[1])) {
				return this.userLogin;
			}
			return null;
		}

	}

}
