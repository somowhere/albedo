package com.albedo.java.common.config;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.security.component.Http401UnauthorizedEntryPoint;
import com.albedo.java.common.security.component.session.RedisSessionRegistry;
import com.albedo.java.common.security.filter.PasswordDecoderFilter;
import com.albedo.java.common.security.handler.AjaxAuthenticationFailureHandler;
import com.albedo.java.common.security.handler.AjaxAuthenticationSuccessHandler;
import com.albedo.java.common.security.handler.AjaxLogoutSuccessHandler;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.filter.CorsFilter;

import javax.annotation.PostConstruct;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
@AllArgsConstructor
@ComponentScan("com.albedo.java.common.security")
@Profile("!" + CommonConstants.SPRING_PROFILE_JWT)
public class SecurityAutoConfiguration extends WebSecurityConfigurerAdapter {

	private final AuthenticationManagerBuilder authenticationManagerBuilder;
	private final ApplicationProperties applicationProperties;
	private final UserDetailsService userDetailsService;
	private final UserOnlineService userOnlineService;
	private final RedisTemplate redisTemplate;
	private final RememberMeServices rememberMeServices;
	private final CorsFilter corsFilter;
	private final PasswordDecoderFilter passwordDecoderFilter;


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

	@Bean
	public AjaxAuthenticationSuccessHandler ajaxAuthenticationSuccessHandler() {
		return new AjaxAuthenticationSuccessHandler();
	}

	@Bean
	public AjaxAuthenticationFailureHandler ajaxAuthenticationFailureHandler() {
		return new AjaxAuthenticationFailureHandler();
	}

	@Bean
	public AjaxLogoutSuccessHandler ajaxLogoutSuccessHandler() {
		return new AjaxLogoutSuccessHandler(userOnlineService);
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
			.antMatchers("/webjars/**")
			.antMatchers("/**/*.{js,html}");
	}

	@Bean
	@ConditionalOnMissingBean
	public AuthenticationEntryPoint authenticationEntryPoint() {
		return new Http401UnauthorizedEntryPoint(applicationProperties);
	}

	@Bean
	public SessionRegistry sessionRegistry() {
		SessionRegistry sessionRegistry = new RedisSessionRegistry(applicationProperties, redisTemplate, userOnlineService);
		return sessionRegistry;
	}

	@Bean
	@ConditionalOnMissingBean
	public HttpSessionEventPublisher httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}


	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http
			.csrf()
			.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
			.and()
			.addFilterBefore(passwordDecoderFilter, CsrfFilter.class)
			.addFilterBefore(corsFilter, CsrfFilter.class)
			.exceptionHandling()
			.authenticationEntryPoint(authenticationEntryPoint())
			.and()
			.rememberMe()
			.rememberMeServices(rememberMeServices)
			.key(applicationProperties.getSecurity().getRememberMe().getKey())
			.and()
			.formLogin()
			.loginProcessingUrl(applicationProperties.getAdminPath("/authenticate"))
			.successHandler(ajaxAuthenticationSuccessHandler())
			.failureHandler(ajaxAuthenticationFailureHandler())
			.permitAll()
			.and()
			.logout()
			.logoutUrl(applicationProperties.getAdminPath("/logout"))
			.logoutSuccessHandler(ajaxLogoutSuccessHandler())
			.permitAll()
			.and()
			.headers()
//			.contentSecurityPolicy("default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; img-src 'self' data:")
//			.and()
//			.referrerPolicy(ReferrerPolicyHeaderWriter.ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN)
//			.and()
//			.featurePolicy("geolocation 'none'; midi 'none'; sync-xhr 'none'; microphone 'none'; camera 'none'; magnetometer 'none'; gyroscope 'none'; speaker 'none'; fullscreen 'self'; payment 'none'")
//			.and()
			.frameOptions().disable()
			.and()
			.authorizeRequests()
			.antMatchers(applicationProperties.getAdminPath("/authenticate")).permitAll()
			.antMatchers(ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorizePermitAll(), String.class)).permitAll()
			.antMatchers(ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorize(), String.class)).authenticated()
			.and()
			.sessionManagement()
			.maximumSessions(1).sessionRegistry(sessionRegistry())

		;


	}

}
