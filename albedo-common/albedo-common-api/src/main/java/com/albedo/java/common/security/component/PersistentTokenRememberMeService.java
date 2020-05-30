package com.albedo.java.common.security.component;

import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.util.RandomUtil;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
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

@Component
@Slf4j
public class PersistentTokenRememberMeService extends AbstractRememberMeServices {
	// Token is valid for one month
	private static final int TOKEN_VALIDITY_DAYS = 31;
	private static final int TOKEN_LENGTH = 2;

	private static final int TOKEN_VALIDITY_SECONDS = 60 * 60 * 24 * TOKEN_VALIDITY_DAYS;

	private static final long UPGRADED_TOKEN_VALIDITY_MILLIS = 5000L;

	private final PersistentTokenCache<UpgradedRememberMeToken> upgradedTokenCache;

	private final UserRepository userRepository;
	private final PersistentTokenRepository persistentTokenRepository;
	private HttpServletRequest request;
	private HttpServletResponse response;

	protected PersistentTokenRememberMeService(ApplicationProperties applicationProperties
		, UserDetailsService userDetailsService, PersistentTokenRepository persistentTokenRepository
		, UserRepository userRepository) {
		super(applicationProperties.getSecurity().getRememberMe().getKey(), userDetailsService);
		setCookieName("rememberMe");
		setParameter("rememberMe");
		this.persistentTokenRepository = persistentTokenRepository;
		this.userRepository = userRepository;
		upgradedTokenCache = new PersistentTokenCache<>(UPGRADED_TOKEN_VALIDITY_MILLIS);
	}


	@Override
	protected UserDetails processAutoLoginCookie(String[] cookieTokens, HttpServletRequest request,
												 HttpServletResponse response) {

		synchronized (this) { // prevent 2 authentication requests from the same user in parallel
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
				PersistentToken persistentToken = getToken(cookieTokens);
				User user = userRepository.selectById(persistentToken.getUserId());
				login = user.getUsername();

				// Token also matches, so login is valid. Update the token value, keeping the *same* series number.
				log.debug("Refreshing persistent login token for user '{}', series '{}'", login, persistentToken.getSeries());
				persistentToken.setTokenDate(LocalDateTime.now());
				persistentToken.setTokenValue(RandomUtil.generateTokenData());
				persistentToken.setIpAddress(WebUtil.getIP(request));
				persistentToken.setUserAgent(request.getHeader("User-Agent"));
				try {
					persistentTokenRepository.updateById(persistentToken);
				} catch (DataAccessException e) {
					log.error("Failed to update token: ", e);
					throw new RememberMeAuthenticationException("Autologin failed due to data access problem", e);
				}
				addCookie(persistentToken, request, response);
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
	protected void onLoginSuccess(HttpServletRequest request, HttpServletResponse response, Authentication
		successfulAuthentication) {

		String login = successfulAuthentication.getName();

		log.debug("Creating new persistent login for user {}", login);
		PersistentToken persistentToken = Optional.of(userRepository.findVoByUsername(login)).map(u -> {
			PersistentToken t = new PersistentToken();
			t.setSeries(RandomUtil.generateSeriesData());
			t.setUserAgent(u.getId());
			t.setUserId(u.getId());
			t.setUsername(u.getUsername());
			t.setTokenValue(RandomUtil.generateTokenData());
			t.setTokenDate(LocalDateTime.now());
			t.setIpAddress(WebUtil.getIP(request));
			t.setLoginLocation(AddressUtil.getRealAddressByIp(t.getIpAddress()));
			t.setUserAgent(request.getHeader("User-Agent"));
			UserAgent userAgent = UserAgentUtil.parse(t.getUserAgent());
			t.setBrowser(userAgent.getBrowser().getName());
			t.setOs(userAgent.getOs().getName());
			return t;
		}).orElseThrow(() -> new UsernameNotFoundException("User " + login + " was not found in the database"));
		try {
			persistentTokenRepository.insert(persistentToken);
			addCookie(persistentToken, request, response);
		} catch (DataAccessException e) {
			log.error("Failed to save persistent token ", e);
		}
	}

	/**
	 * When logout occurs, only invalidate the current token, and not all user sessions.
	 * <p>
	 * The standard Spring Security implementations are too basic: they invalidate all tokens for the
	 * current user, so when he logs out from one browser, all his other sessions are destroyed.
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
				PersistentToken persistentToken = getToken(cookieTokens);
				persistentTokenRepository.deleteById(persistentToken.getSeries());
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
	private PersistentToken getToken(String[] cookieTokens) {
		if (cookieTokens.length != TOKEN_LENGTH) {
			throw new InvalidCookieException("Cookie token did not contain " + TOKEN_LENGTH +
				" tokens, but contained '" + Arrays.asList(cookieTokens) + "'");
		}
		String presentedSeries = cookieTokens[0];
		String presentedToken = cookieTokens[1];
		PersistentToken persistentToken = persistentTokenRepository.selectById(presentedSeries);
		if (persistentToken == null) {
			// No series match, so we can't authenticate using this cookie
			throw new RememberMeAuthenticationException("No persistent token found for series id: " + presentedSeries);
		}
		// We have a match for this user/series combination
		log.info("presentedToken={} / tokenValue={}", presentedToken, persistentToken.getTokenValue());
		if (!presentedToken.equals(persistentToken.getTokenValue())) {
			// Token doesn't match series value. Delete this session and throw an exception.
			persistentTokenRepository.deleteById(persistentToken.getSeries());
			throw new CookieTheftException("Invalid remember-me token (Series/token) mismatch. Implies previous " +
				"cookie theft attack.");
		}
		if (persistentToken.getTokenDate().plusDays(TOKEN_VALIDITY_DAYS).isBefore(LocalDateTime.now())) {
			persistentTokenRepository.deleteById(persistentToken.getSeries());
			throw new RememberMeAuthenticationException("Remember-me login has expired");
		}
		return persistentToken;
	}

	private void addCookie(PersistentToken persistentToken, HttpServletRequest request, HttpServletResponse response) {
		setCookie(
			new String[]{persistentToken.getSeries(), persistentToken.getTokenValue()},
			TOKEN_VALIDITY_SECONDS, request, response);
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
			if (currentToken[0].equals(this.upgradedToken[0]) &&
				currentToken[1].equals(this.upgradedToken[1])) {
				return this.userLogin;
			}
			return null;
		}
	}
}
