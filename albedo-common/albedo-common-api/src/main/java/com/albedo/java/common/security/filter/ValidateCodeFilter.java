package com.albedo.java.common.security.filter;

import cn.hutool.core.thread.ThreadUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.modules.sys.domain.vo.account.LoginVo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@AllArgsConstructor
@Slf4j
@Component
public class ValidateCodeFilter extends OncePerRequestFilter {

	private final AuthenticationFailureHandler authenticationFailureHandler;
	private final ApplicationProperties applicationProperties;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
		if(StringUtil.equals(applicationProperties.getAdminPath("/authenticate"), request.getRequestURI())
		&& StringUtil.equalsIgnoreCase(request.getMethod(), "post")
		){
//			if (!SpringContextHolder.isDevelopment()) {
				LoginVo loginVo = new LoginVo();
				loginVo.setCode(request.getParameter("code"));
				loginVo.setRandomStr(request.getParameter("randomStr"));
				try {
					LoginUtil.checkCode(loginVo);
				}catch (AuthenticationException e){
					authenticationFailureHandler.onAuthenticationFailure(request, response, e);
					return;
				}
//			}
		}
		filterChain.doFilter(request, response);
	}
}
