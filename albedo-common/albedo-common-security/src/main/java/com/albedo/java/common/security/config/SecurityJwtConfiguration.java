/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.security.config;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.security.component.Http401UnauthorizedEntryPoint;
import com.albedo.java.common.security.enums.RequestMethodEnum;
import com.albedo.java.common.security.jwt.JwtConfigurer;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.common.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.ApplicationContext;
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
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.util.Map;
import java.util.Set;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:11
 */
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

	private final ApplicationContext applicationContext;

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


	@Override
	protected void configure(AuthenticationManagerBuilder authenticationManagerBuilder) throws Exception {
		authenticationManagerBuilder.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}

	@Override
	@Bean
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(HttpMethod.OPTIONS, "/**").antMatchers("/i18n/**").antMatchers("/content/**")
			.antMatchers("/statics/**").antMatchers("/assets/**/*.{js,html}").antMatchers("/test/**");
	}

	@Bean
	@ConditionalOnMissingBean
	public AuthenticationEntryPoint authenticationEntryPoint() {
		return new Http401UnauthorizedEntryPoint(applicationProperties);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		// 搜寻匿名标记 url： @AnonymousAccess
		Map<RequestMappingInfo, HandlerMethod> handlerMethodMap = applicationContext
			.getBean("requestMappingHandlerMapping", RequestMappingHandlerMapping.class).getHandlerMethods();
		// 获取匿名标记
		Map<String, Set<String>> anonymousUrls = SecurityUtil.getAnonymousUrl(handlerMethodMap);

		http.addFilterBefore(corsFilter, UsernamePasswordAuthenticationFilter.class).exceptionHandling()
			.authenticationEntryPoint(authenticationEntryPoint()).and().csrf().disable().headers().frameOptions()
			.disable().and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
			.authorizeRequests()
			// 自定义匿名访问所有url放行：允许匿名和带Token访问，细腻化到每个 Request 类型
			// GET
			.antMatchers(HttpMethod.GET, anonymousUrls.get(RequestMethodEnum.GET.getType()).toArray(new String[0]))
			.permitAll()
			// POST
			.antMatchers(HttpMethod.POST,
				anonymousUrls.get(RequestMethodEnum.POST.getType()).toArray(new String[0]))
			.permitAll()
			// PUT
			.antMatchers(HttpMethod.PUT, anonymousUrls.get(RequestMethodEnum.PUT.getType()).toArray(new String[0]))
			.permitAll()
			// PATCH
			.antMatchers(HttpMethod.PATCH,
				anonymousUrls.get(RequestMethodEnum.PATCH.getType()).toArray(new String[0]))
			.permitAll()
			// DELETE
			.antMatchers(HttpMethod.DELETE,
				anonymousUrls.get(RequestMethodEnum.DELETE.getType()).toArray(new String[0]))
			.permitAll()
			// 所有类型的接口都放行
			.antMatchers(anonymousUrls.get(RequestMethodEnum.ALL.getType()).toArray(new String[0])).permitAll()
			.antMatchers(
				ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorizePermitAll(), String.class))
			.permitAll()
			.antMatchers(ArrayUtil.toArray(applicationProperties.getSecurity().getAuthorize(), String.class))
			.authenticated().and().apply(securityConfigurerAdapter());

	}

	private JwtConfigurer securityConfigurerAdapter() {
		return new JwtConfigurer(tokenProvider, applicationProperties);
	}

}
