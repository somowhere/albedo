package com.albedo.java.common.security.jwt;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.security.SecurityConstants;
import com.albedo.java.web.rest.util.CookieUtil;
import com.albedo.java.web.rest.util.RequestUtil;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Filters incoming requests and installs a Spring Security principal if a header corresponding to a valid user is
 * found.
 */
public class JWTFilter extends GenericFilterBean {

    private TokenProvider tokenProvider;

    private AlbedoProperties albedoProperties;

    public JWTFilter(TokenProvider tokenProvider, AlbedoProperties albedoProperties) {
        this.tokenProvider = tokenProvider;
        this.albedoProperties = albedoProperties;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
        throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        String jwt = resolveToken(httpServletRequest);
        if (StringUtils.hasText(jwt)) {
            if(this.tokenProvider.validateToken(jwt)){
                Authentication authentication = this.tokenProvider.getAuthentication(jwt);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }else{
                CookieUtil.deleteCookie(httpServletRequest, (HttpServletResponse) servletResponse, SecurityConstants.AUTHORIZATION_HEADER);
            }
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    private String resolveToken(HttpServletRequest request){
        String bearerToken = albedoProperties.getHttp().getRestful() || RequestUtil.isRestfulRequest(request)
        ? request.getHeader(SecurityConstants.AUTHORIZATION_HEADER) : CookieUtil.getCookie(request, SecurityConstants.AUTHORIZATION_HEADER);
        if (StringUtils.hasText(bearerToken) && bearerToken.startsWith("Bearer")) {
            return bearerToken.substring(6, bearerToken.length());
        }
        return null;
    }
}
