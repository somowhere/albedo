package com.albedo.java.common.config;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.security.component.Http401UnauthorizedEntryPoint;
import com.albedo.java.common.security.jwt.JWTConfigurer;
import com.albedo.java.common.security.jwt.TokenProvider;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.filter.CorsFilter;

import javax.annotation.PostConstruct;


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
@AllArgsConstructor
@ComponentScan("com.albedo.java.common.security")
@Profile(CommonConstants.SPRING_PROFILE_JWT)
public class SecurityJwtConfiguration extends WebSecurityConfigurerAdapter {

	private final AuthenticationManagerBuilder authenticationManagerBuilder;
	private final ApplicationProperties applicationProperties;
	private final UserDetailsService userDetailsService;
	private final TokenProvider tokenProvider;
	private final CorsFilter corsFilter;


	/**
	 * https://spring.io/blog/2017/11/01/spring-security-5-0-0-rc1-released#password-storage-updated
	 * Encoded password does not look like BCrypt
	 *
	 * @return PasswordEncoder
	 */
	@Bean
	public PasswordEncoder passwordEncoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

	@PostConstruct
	public void init() {
		try {
			authenticationManagerBuilder
				.userDetailsService(userDetailsService)
				.passwordEncoder(passwordEncoder());
		} catch (Exception e) {
			throw new BeanInitializationException("Security configuration failed", e);
		}
	}

	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring()
			.antMatchers(HttpMethod.OPTIONS, "/**")
			.antMatchers("/i18n/**")
			.antMatchers("/content/**")
			.antMatchers("/statics/**")
			.antMatchers("/assets/**/*.{js,html}")
			.antMatchers("/test/**");
	}

	@Bean
	@ConditionalOnMissingBean
	public AuthenticationEntryPoint authenticationEntryPoint() {
		return new Http401UnauthorizedEntryPoint(applicationProperties);
	}


	@Override
	protected void configure(HttpSecurity http) throws Exception {


		http.addFilterBefore(corsFilter, UsernamePasswordAuthenticationFilter.class)
			.exceptionHandling().authenticationEntryPoint(authenticationEntryPoint())
			.and()
			.csrf()
			.disable()
			.headers()
			.frameOptions()
			.disable()
			.and()
			.sessionManagement()
			.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
			.and()
			.authorizeRequests()
			.antMatchers(applicationProperties.getAdminPath("/login")).permitAll()
			.antMatchers(applicationProperties.getAdminPath("/logout")).permitAll()
			.antMatchers(applicationProperties.getAdminPath("/authenticate")).permitAll()
			.antMatchers(ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorizePermitAll(), String.class)).permitAll()
			.antMatchers(ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorize(), String.class)).authenticated()
			.and()
			.apply(securityConfigurerAdapter());

	}

	private JWTConfigurer securityConfigurerAdapter() {
		return new JWTConfigurer(tokenProvider, applicationProperties);
	}

}
