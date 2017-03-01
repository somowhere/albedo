package com.albedo.java.common.config;

import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.CustomizeAccessDecisionManager;
import com.albedo.java.common.security.Http401UnauthorizedEntryPoint;
import com.albedo.java.common.security.handler.AjaxAuthenticationFailureHandler;
import com.albedo.java.common.security.handler.AjaxAuthenticationSuccessHandler;
import com.albedo.java.common.security.handler.AjaxLogoutSuccessHandler;
import com.albedo.java.common.security.handler.CustomAccessDeniedHandler;
import com.albedo.java.common.security.service.InvocationSecurityMetadataSourceService;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.web.filter.CsrfCookieGeneratorFilter;
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
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.data.repository.query.SecurityEvaluationContextExtension;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.csrf.CsrfFilter;

import javax.inject.Inject;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Inject
    private AlbedoProperties albedoProperties;

    @Inject
    private AjaxAuthenticationSuccessHandler ajaxAuthenticationSuccessHandler;

    @Inject
    private AjaxAuthenticationFailureHandler ajaxAuthenticationFailureHandler;

    @Inject
    private AjaxLogoutSuccessHandler ajaxLogoutSuccessHandler;

    @Inject
    private Http401UnauthorizedEntryPoint authenticationEntryPoint;

    @Inject
    private UserDetailsService userDetailsService;

    @Inject
    private RememberMeServices rememberMeServices;
    @Inject
    CustomizeAccessDecisionManager customizeAccessDecisionManager;
    @Inject
    InvocationSecurityMetadataSourceService invocationSecurityMetadataSourceService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Inject
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

        String[] permissAll = new String[InvocationSecurityMetadataSourceService.authorizePermitAll.length];

        for (int i = 0; i < permissAll.length; i++) {
            permissAll[i] = PublicUtil.toAppendStr(adminPath, InvocationSecurityMetadataSourceService.authorizePermitAll[i]);
        }

        http
                .csrf()
                .and()
                .addFilterAfter(new CsrfCookieGeneratorFilter(), CsrfFilter.class)
                .exceptionHandling()
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .authenticationEntryPoint(authenticationEntryPoint)
                .and()
                .rememberMe()
                .rememberMeServices(rememberMeServices)
                .rememberMeParameter("remember-me")
                .key(albedoProperties.getSecurity().getRememberMe().getKey())
                .and()
                .formLogin()
                .loginProcessingUrl(adminPath+"/api/authentication")
                .successHandler(ajaxAuthenticationSuccessHandler)
                .failureHandler(ajaxAuthenticationFailureHandler)
                .usernameParameter("a_username")
                .passwordParameter("a_password")
                .permitAll()
                .and()
                .logout()
                .logoutUrl(adminPath+InvocationSecurityMetadataSourceService.logoutUrl)
                .logoutSuccessHandler(ajaxLogoutSuccessHandler)
                .deleteCookies("JSESSIONID", "CSRF-TOKEN")
                .permitAll()
                .and()
                .headers()
                .frameOptions()
                .disable()
                .and()
                .authorizeRequests()
                .antMatchers(adminPath+InvocationSecurityMetadataSourceService.loginUrl).permitAll()
                .antMatchers(permissAll).permitAll()
                .antMatchers(adminPath+"/**").authenticated().withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
            public <O extends FilterSecurityInterceptor> O postProcess(O fsi) {
                fsi.setSecurityMetadataSource(securityMetadataSource());
                return fsi;
            }
        }).accessDecisionManager(customizeAccessDecisionManager)
                .antMatchers("/management/**").hasAuthority(AuthoritiesConstants.ADMIN)
                .antMatchers("/statics/swagger-ui/index.html").hasAuthority(AuthoritiesConstants.ADMIN);

    }

    @Bean
    public FilterInvocationSecurityMetadataSource securityMetadataSource() {
        return invocationSecurityMetadataSourceService;
    }

//    @Bean
//    public AccessDecisionManager unanimous(){
//
//    	List<AccessDecisionVoter<? extends Object>> decisionVoters = Lists.newArrayList( new RoleVoter(), new AuthenticatedVoter(), new DatabaseRoleVoter(), new WebExpressionVoter());
//
//    	return new UnanimousBased(decisionVoters);
//
//    }
//    private class DatabaseRoleVoter implements AccessDecisionVoter<Object> {
//
//    	@Override
//        public boolean supports(ConfigAttribute arg0) {
//            return true;
//        }
//
//        @Override
//        public boolean supports(Class<?> arg0) {
//            return true;
//        }
//
//        @Override
//        public int vote(Authentication authentication, Object object, Collection<ConfigAttribute> attributes) {
//        	if (attributes == null) {
//    			return ACCESS_GRANTED;
//    		}
//        	for (ConfigAttribute attribute : attributes) {
//				// Attempt to find a matching granted authority
//				for (GrantedAuthority authority : authentication.getAuthorities()) {
//					System.out.println(attribute.getAttribute());
//					if(attribute.getAttribute() == null) return ACCESS_GRANTED;
//					if (attribute.getAttribute().equals(authority.getAuthority())) {
//						return ACCESS_GRANTED;
//					}
//				}
//    		}
//        	return ACCESS_DENIED;
//        }
//    }

    @Bean
    public SecurityEvaluationContextExtension securityEvaluationContextExtension() {
        return new SecurityEvaluationContextExtension();
    }
}
