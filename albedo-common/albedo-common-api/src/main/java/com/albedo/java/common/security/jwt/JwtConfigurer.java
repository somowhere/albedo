package com.albedo.java.common.security.jwt;

import com.albedo.java.common.core.config.ApplicationProperties;
import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.DefaultSecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:08
 */
public class JwtConfigurer extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity> {

	private final TokenProvider tokenProvider;

	private final ApplicationProperties applicationProperties;

	public JwtConfigurer(TokenProvider tokenProvider, ApplicationProperties applicationProperties) {
		this.tokenProvider = tokenProvider;
		this.applicationProperties = applicationProperties;
	}

	@Override
	public void configure(HttpSecurity http) throws Exception {
		JwtFilter customFilter = new JwtFilter(tokenProvider, applicationProperties);
		http.addFilterBefore(customFilter, UsernamePasswordAuthenticationFilter.class);
	}

}
