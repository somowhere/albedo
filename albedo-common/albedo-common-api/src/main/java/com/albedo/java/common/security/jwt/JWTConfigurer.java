package com.albedo.java.common.security.jwt;

import com.albedo.java.common.core.config.ApplicationProperties;
import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.DefaultSecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class JWTConfigurer extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity> {

	private final TokenProvider tokenProvider;
	private final ApplicationProperties applicationProperties;

	public JWTConfigurer(TokenProvider tokenProvider, ApplicationProperties applicationProperties) {
		this.tokenProvider = tokenProvider;
		this.applicationProperties = applicationProperties;
	}

	@Override
	public void configure(HttpSecurity http) throws Exception {
		JWTFilter customFilter = new JWTFilter(tokenProvider, applicationProperties);
		http.addFilterBefore(customFilter, UsernamePasswordAuthenticationFilter.class);
	}
}
