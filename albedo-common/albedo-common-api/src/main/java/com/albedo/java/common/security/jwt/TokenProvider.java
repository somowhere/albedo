/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
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

package com.albedo.java.common.security.jwt;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.service.UserDetail;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

import javax.annotation.PostConstruct;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 16:19
 */
@Component
public class TokenProvider {

	private static final String EXPIRATION = "expiration";

	private static final String PRINCIPAL = "principal";

	private final Logger log = LoggerFactory.getLogger(TokenProvider.class);

	private final ApplicationProperties applicationProperties;

	private final UserDetailsService userDetailsService;

	private Key secretKey;

	private long tokenValidityInMilliseconds;

	private long tokenValidityInMillisecondsForRememberMe;

	public TokenProvider(ApplicationProperties applicationProperties, UserDetailsService userDetailsService) {
		this.applicationProperties = applicationProperties;
		this.userDetailsService = userDetailsService;
	}

	@PostConstruct
	public void init() {
		String secret = applicationProperties.getSecurity().getAuthentication().getJwt().getBase64Secret();
		Assert.isTrue(StringUtil.isNotEmpty(secret), "jwt secret can not be empty");
		byte[] keyBytes = Decoders.BASE64.decode(secret);
		this.secretKey = Keys.hmacShaKeyFor(keyBytes);

		this.tokenValidityInMilliseconds = 1000
			* applicationProperties.getSecurity().getAuthentication().getJwt().getTokenValidityInSeconds();
		this.tokenValidityInMillisecondsForRememberMe = 1000 * applicationProperties.getSecurity().getAuthentication()
			.getJwt().getTokenValidityInSecondsForRememberMe();
	}

	private Claims getClaimsFromToken(String token) {
		Claims claims;
		try {
			claims = Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(token).getBody();
		} catch (Exception e) {
			claims = null;
		}
		return claims;
	}

	private String generateToken(String subject, Map<String, Object> claims, long expiration) {
		return Jwts.builder().setClaims(claims).setSubject(subject).setId(UUID.randomUUID().toString())
			.setIssuedAt(new Date()).setExpiration(generateExpirationDate(expiration))
			.compressWith(CompressionCodecs.DEFLATE).signWith(secretKey, SignatureAlgorithm.HS512).compact();
	}

	private Date generateExpirationDate(long expiration) {
		return new Date(System.currentTimeMillis() + expiration * 1000);
	}

	public String createToken(Authentication authentication, Boolean rememberMe) {
		long expiration = rememberMe ? this.tokenValidityInMillisecondsForRememberMe : this.tokenValidityInMilliseconds;
		return generateToken(authentication.getName(), new HashMap<String, Object>(4) {
			{
				put(PRINCIPAL, authentication.getName());
			}
		}, expiration);
	}

	public Authentication getAuthentication(String token) {
		Claims claims = getClaimsFromToken(token);
		UserDetail userDetail = (UserDetail) userDetailsService.loadUserByUsername((String) claims.get(PRINCIPAL));
		return new UsernamePasswordAuthenticationToken(userDetail, token, userDetail.getAuthorities());
	}

	public Date getExpirationDateFromToken(String token) {
		Date expiration;
		try {
			final Claims claims = getClaimsFromToken(token);
			expiration = claims.getExpiration();
		} catch (Exception e) {
			expiration = null;
		}
		return expiration;
	}

	public long getExpirationDateSecondsFromToken(String token) {
		return (getExpirationDateFromToken(token).getTime() - System.currentTimeMillis()) / 1000;
	}

	public String refreshToken(String token) {
		String refreshedToken;
		try {
			final Claims claims = getClaimsFromToken(token);
			refreshedToken = generateToken(claims.getSubject(), claims, (Long) claims.get(EXPIRATION));
		} catch (Exception e) {
			refreshedToken = null;
		}
		return refreshedToken;
	}

	public Boolean isTokenExpired(String token) {
		final Date expiration = getExpirationDateFromToken(token);
		return expiration.before(new Date());
	}

	public boolean validateToken(String authToken) {
		try {
			Jwts.parserBuilder().setSigningKey(secretKey).build().parseClaimsJws(authToken);
			return true;
		} catch (JwtException | IllegalArgumentException e) {
			log.info("Invalid JWT token.");
			log.trace("Invalid JWT token trace.", e);
		}
		return false;
	}

}
