package com.albedo.java.common.security.jwt;

import com.albedo.java.common.config.AlbedoProperties;
import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.DefaultSecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class JWTConfigurer extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity> {

    private final TokenProvider tokenProvider;
    private final AlbedoProperties albedoProperties;

    public JWTConfigurer(TokenProvider tokenProvider, AlbedoProperties albedoProperties) {
        this.tokenProvider = tokenProvider;
        this.albedoProperties = albedoProperties;
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        JWTFilter customFilter = new JWTFilter(tokenProvider, albedoProperties);
        http.addFilterBefore(customFilter, UsernamePasswordAuthenticationFilter.class);
    }
}
