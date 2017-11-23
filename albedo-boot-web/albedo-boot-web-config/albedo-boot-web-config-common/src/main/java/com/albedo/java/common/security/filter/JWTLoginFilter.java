package com.albedo.java.common.security.filter;//package com.albedo.java.common.security.filter;
//
//import com.albedo.java.common.security.jwt.TokenProvider;
//import com.albedo.java.util.domain.CustomMessage;
//import com.albedo.java.vo.base.LoginVo;
//import com.albedo.java.web.rest.base.GeneralResource;
//import com.albedo.java.web.rest.util.RequestUtil;
//import org.springframework.security.authentication.AuthenticationManager;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
//import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
//
//import javax.servlet.FilterChain;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//public class JWTLoginFilter extends AbstractAuthenticationProcessingFilter {
//
//
//    private final TokenProvider tokenProvider;
//
//    public JWTLoginFilter(String url, AuthenticationManager authManager, TokenProvider tokenProvider) {
//        super(new AntPathRequestMatcher(url));
//        setAuthenticationManager(authManager);
//        this.tokenProvider = tokenProvider;
//    }
//
//    @Override
//    public Authentication attemptAuthentication(
//            HttpServletRequest req, HttpServletResponse res)
//            throws AuthenticationException, IOException, ServletException {
//        LoginVo loginVo = RequestUtil.parseObject(LoginVo.class, req);
//
//        UsernamePasswordAuthenticationToken authenticationToken =
//                new UsernamePasswordAuthenticationToken(loginVo.getUsername(), loginVo.getPassword());
//
//        Authentication authentication = this.getAuthenticationManager().authenticate(authenticationToken);
//        return authentication;
//    }
//
//    @Override
//    protected void successfulAuthentication(
//            HttpServletRequest request,
//            HttpServletResponse response, FilterChain chain,
//            Authentication authentication) throws IOException, ServletException {
//        LoginVo loginVo = RequestUtil.parseObject(LoginVo.class, request);
//        boolean rememberMe = (loginVo.isRememberMe() == null) ? false : loginVo.isRememberMe();
//
//        String jwt = tokenProvider.createToken(authentication, rememberMe);
//
////        response.addHeader(SecurityConstants.AUTHORIZATION_HEADER, );
//        // 将 JWT 写入 body
//
//        response.setContentType("application/json");
//        response.setStatus(HttpServletResponse.SC_OK);
//        GeneralResource.writeJsonHttpResponse(CustomMessage.createSuccess("Bearer " + jwt), response);
//
//
//    }
//
//
//    @Override
//    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException, ServletException {
//        response.setContentType("application/json");
//        response.setStatus(HttpServletResponse.SC_OK);
//        GeneralResource.writeJsonHttpResponse(CustomMessage.createError("用户名或密码错误"), response);
//
//    }
//}
