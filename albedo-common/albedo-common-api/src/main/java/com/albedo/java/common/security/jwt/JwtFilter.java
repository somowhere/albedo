package com.albedo.java.common.security.jwt;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.WebUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filters incoming requests and installs a Spring Security principal if a header
 * corresponding to a valid user is found.
 *
 * @author somewhere
 */
@Slf4j
public class JwtFilter extends GenericFilterBean {

	private final String PREFIX_TOKEN = "Bearer ";

	private TokenProvider tokenProvider;

	private ApplicationProperties applicationProperties;

	public JwtFilter(TokenProvider tokenProvider, ApplicationProperties applicationProperties) {
		this.tokenProvider = tokenProvider;
		this.applicationProperties = applicationProperties;
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
		throws IOException, ServletException {
		HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
		String jwt = resolveToken(httpServletRequest);
		if (StringUtils.hasText(jwt)) {
			if (this.tokenProvider.validateToken(jwt)) {
				Authentication authentication = this.tokenProvider.getAuthentication(jwt);
				SecurityContextHolder.getContext().setAuthentication(authentication);
			} else {
				WebUtil.removeCookie((HttpServletResponse) servletResponse, HttpHeaders.AUTHORIZATION);
			}
		}
		filterChain.doFilter(servletRequest, servletResponse);
	}

	private String resolveToken(HttpServletRequest request) {
		String bearerToken = request.getHeader(HttpHeaders.AUTHORIZATION);
		if (StringUtils.hasText(bearerToken) && bearerToken.startsWith(PREFIX_TOKEN)) {
			return bearerToken.substring(7);
		}
		return bearerToken;
	}

}
