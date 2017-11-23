package com.albedo.java.common.config;

import com.albedo.java.common.base.BaseInit;
import com.albedo.java.common.security.*;
import com.albedo.java.common.security.jwt.JWTConfigurer;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.common.security.service.InvocationSecurityMetadataSourceService;
import com.albedo.java.util.JedisUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.GlobalJedis;
import org.springframework.beans.factory.BeanInitializationException;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.data.repository.query.SecurityEvaluationContextExtension;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.context.request.RequestContextListener;
import org.springframework.web.filter.CorsFilter;

import javax.annotation.Resource;


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
@BaseInit
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Resource
    CustomizeAccessDecisionManager customizeAccessDecisionManager;
    @Resource
    InvocationSecurityMetadataSourceService invocationSecurityMetadataSourceService;
    @Resource
    private AlbedoProperties albedoProperties;
    @Resource
    private Http401UnauthorizedEntryPoint http401UnauthorizedEntryPoint;
    @Resource
    private UserDetailsService userDetailsService;
    @Resource
    private TokenProvider tokenProvider;
    @Resource
    private CorsFilter corsFilter;
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Resource
    public void configureGlobal(AuthenticationManagerBuilder auth) {
        try {
            auth
                    .userDetailsService(userDetailsService)
                    .passwordEncoder(passwordEncoder());
        } catch (Exception e) {
            throw new BeanInitializationException("Security configuration failed", e);
        }
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring()
                .antMatchers(HttpMethod.OPTIONS, "/**")
                .antMatchers("/content/**")
                .antMatchers("/statics/**")
                .antMatchers("/test/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        String adminPath = albedoProperties.getAdminPath();

        String[] permissAll = new String[SecurityConstants.authorizePermitAll.length];

        for (int i = 0; i < permissAll.length; i++) {
            permissAll[i] = PublicUtil.toAppendStr(adminPath, SecurityConstants.authorizePermitAll[i]);
        }

        http.addFilterBefore(corsFilter, UsernamePasswordAuthenticationFilter.class)
                .exceptionHandling().authenticationEntryPoint(http401UnauthorizedEntryPoint)
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
                .antMatchers(albedoProperties.getAdminPath(SecurityConstants.loginUrl)).permitAll()
                .antMatchers(albedoProperties.getAdminPath(SecurityConstants.authLogin)).permitAll()
                .antMatchers(albedoProperties.getAdminPath(SecurityConstants.logoutUrl)).permitAll()
                .antMatchers(permissAll).permitAll()
                .antMatchers(albedoProperties.getAdminPath("/**")).authenticated()
                .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
                    @Override
                    public <O extends FilterSecurityInterceptor> O postProcess(O fsi) {
                        fsi.setSecurityMetadataSource(securityMetadataSource());
                        return fsi;
                    }
                }).accessDecisionManager(customizeAccessDecisionManager)
                .antMatchers("/management/**").hasAuthority(AuthoritiesConstants.ADMIN)
                .and()
                .apply(securityConfigurerAdapter());

    }

    @Bean
    public FilterInvocationSecurityMetadataSource securityMetadataSource() {
        return invocationSecurityMetadataSourceService;
    }

    private JWTConfigurer securityConfigurerAdapter() {
        return new JWTConfigurer(tokenProvider, albedoProperties);
    }

    @Bean
    public SecurityEvaluationContextExtension securityEvaluationContextExtension() {
        return new SecurityEvaluationContextExtension();
    }


    public void afterPropertiesSet() {
        SecurityUtil.clearUserJedisCache();
        JedisUtil.removeSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP);
        invocationSecurityMetadataSourceService.getResourceMap();
    }

}
