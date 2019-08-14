package com.albedo.java.common.security.filter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.security.filter.warpper.BodyRequestWrapper;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BodyFilter extends OncePerRequestFilter {
	private final ApplicationProperties applicationProperties;

	public BodyFilter(ApplicationProperties applicationProperties) {
		this.applicationProperties = applicationProperties;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		if (request.getRequestURI().contains("/file/upload")) {
			filterChain.doFilter(request, response);
		} else {
			filterChain.doFilter(new BodyRequestWrapper(request), response);
		}
	}
}
