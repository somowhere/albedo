package com.albedo.java.common.security.jwt;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.security.service.UserDetail;
import io.jsonwebtoken.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Component
public class TokenProvider {

	private final Logger log = LoggerFactory.getLogger(TokenProvider.class);

	private static final String EXPIRATION = "expiration";
	private static final String PRINCIPAL = "principal";

	private String secretKey;

	private long tokenValidityInMilliseconds;

	private long tokenValidityInMillisecondsForRememberMe;

	private final ApplicationProperties applicationProperties;
	private final UserDetailsService userDetailsService;

	public TokenProvider(ApplicationProperties applicationProperties, UserDetailsService userDetailsService) {
		this.applicationProperties = applicationProperties;
		this.userDetailsService = userDetailsService;
	}

	@PostConstruct
	public void init() {
		this.secretKey =
			applicationProperties.getSecurity().getAuthentication().getJwt().getSecret();

		this.tokenValidityInMilliseconds =
			1000 * applicationProperties.getSecurity().getAuthentication().getJwt().getTokenValidityInSeconds();
		this.tokenValidityInMillisecondsForRememberMe =
			1000 * applicationProperties.getSecurity().getAuthentication().getJwt().getTokenValidityInSecondsForRememberMe();
	}

	private Claims getClaimsFromToken(String token) {
		Claims claims;
		try {
			claims = Jwts.parser()
				.setSigningKey(secretKey)
				.parseClaimsJws(token)
				.getBody();
		} catch (Exception e) {
			claims = null;
		}
		return claims;
	}

	private String generateToken(String subject, Map<String, Object> claims, long expiration) {
		return Jwts.builder()
			.setClaims(claims)
			.setSubject(subject)
			.setId(UUID.randomUUID().toString())
			.setIssuedAt(new Date())
			.setExpiration(generateExpirationDate(expiration))
			.compressWith(CompressionCodecs.DEFLATE)
			.signWith(SignatureAlgorithm.HS512, secretKey)
			.compact();
	}


	private Date generateExpirationDate(long expiration) {
		return new Date(System.currentTimeMillis() + expiration * 1000);
	}

	public String createToken(Authentication authentication, Boolean rememberMe) {
		long expiration = rememberMe ? this.tokenValidityInMillisecondsForRememberMe : this.tokenValidityInMilliseconds;
		return generateToken(authentication.getName(), new HashMap<String, Object>() {{
			put(PRINCIPAL, authentication.getName());
		}}, expiration);
	}

	public Authentication getAuthentication(String token) {
		Claims claims = getClaimsFromToken(token);
		UserDetail userDetail = (UserDetail) userDetailsService.loadUserByUsername((String) claims.get(PRINCIPAL));
		return new UsernamePasswordAuthenticationToken(userDetail, token,
			userDetail.getAuthorities());
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
		return (getExpirationDateFromToken(token).getTime() - new Date().getTime()) / 1000;
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
			Jwts.parser().setSigningKey(secretKey).parseClaimsJws(authToken);
			return true;
		} catch (SignatureException e) {
			log.info("Invalid JWT signature.");
			log.trace("Invalid JWT signature trace: {}", e);
		} catch (MalformedJwtException e) {
			log.info("Invalid JWT token.");
			log.trace("Invalid JWT token trace: {}", e);
		} catch (ExpiredJwtException e) {
			log.info("Expired JWT token.");
			log.trace("Expired JWT token trace: {}", e);
		} catch (UnsupportedJwtException e) {
			log.info("Unsupported JWT token.");
			log.trace("Unsupported JWT token trace: {}", e);
		} catch (IllegalArgumentException e) {
			log.info("JWT token compact of handler are invalid.");
			log.trace("JWT token compact of handler are invalid trace: {}", e);
		}
		return false;
	}


}
