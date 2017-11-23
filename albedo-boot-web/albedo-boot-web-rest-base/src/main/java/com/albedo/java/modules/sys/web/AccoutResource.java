package com.albedo.java.modules.sys.web;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.security.SecurityConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.util.LoginUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.vo.base.LoginVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.BaseResource;
import com.albedo.java.web.rest.util.CookieUtil;
import com.albedo.java.web.rest.util.RequestUtil;
import com.codahale.metrics.annotation.Timed;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collections;

/**
 * REST controller for managing the current user's account.
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${albedo.adminPath}/")
public class AccoutResource extends BaseResource {

    public final static String LOGIN_FAIL_MAP = "loginFailMap";
    @Resource
    private AlbedoProperties albedoProperties;
    @Resource
    private UserService userService;
    private final TokenProvider tokenProvider;

    private final AuthenticationManager authenticationManager;

    public AccoutResource(TokenProvider tokenProvider, AuthenticationManager authenticationManager) {
        this.tokenProvider = tokenProvider;
        this.authenticationManager = authenticationManager;
    }

    /**
     * GET  /account : get the current user.
     *
     * @return the ResponseEntity with status 200 (OK) and the current user in body, or status 500 (Internal Server Error) if the user couldn't be returned
     */
    @GetMapping("/account")
    @Timed
    public ResponseEntity getAccount() {
        return ResultBuilder.buildOk(userService.getUserWithAuthorities(SecurityUtil.getCurrentUserId()));
    }

    /**
     * 登录成功，进入管理首页
     */
    @GetMapping(value = Globals.INDEX_URL)
    public String index(HttpServletRequest request, Model modele) {
        User user = SecurityUtil.getCurrentUser();
        if (PublicUtil.isEmpty(user.getId())) {
            return PublicUtil.toAppendStr("redirect:", adminPath, "/login");
        }
        // 登录成功后，验证码计算器清零
        LoginUtil.isValidateCodeLogin(request.getSession().getId(), false, true);
        request.getSession().setAttribute("moduleList", SecurityUtil.getModuleList());
        modele.addAttribute("loginId", user.getLoginId());
        return "index";
    }

    /**
     * 管理登录
     */
    @GetMapping(value = "login")
    public String login(HttpServletRequest request, Model model) {
        model.addAttribute("isValidateCodeLogin", LoginUtil.isValidateCodeLogin(request.getSession().getId(), false, false));
        return "loginPage";
    }


    @PostMapping("authenticate")
    @Timed
    public ResponseEntity authorize(@RequestBody  LoginVo loginVo, HttpServletResponse response) {

        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(loginVo.getUsername(), loginVo.getPassword());

        try {
            Authentication authentication = this.authenticationManager.authenticate(authenticationToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            boolean rememberMe = (loginVo.isRememberMe() == null) ? false : loginVo.isRememberMe();
            String jwt = "Bearer" + tokenProvider.createToken(authentication, rememberMe);
            CookieUtil.setCookie(response, SecurityConstants.AUTHORIZATION_HEADER, jwt);
            log.info("{}", jwt);
            return ResultBuilder.buildDataOk(jwt);
        } catch (AuthenticationException ae) {
            log.trace("Authentication exception trace: {}", ae);
            return new ResponseEntity<>(Collections.singletonMap("AuthenticationException",
                    ae.getLocalizedMessage()), HttpStatus.UNAUTHORIZED);
        }
    }

    @GetMapping(value = "logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        CookieUtil.removeCookie(request, response, SecurityConstants.AUTHORIZATION_HEADER);
        request.getSession().invalidate();
        if (albedoProperties.getHttp().getRestful() || RequestUtil.isRestfulRequest(request)) {
            writeJsonHttpResponse(ResultBuilder.buildFailed("退出登录成功"), response);
            return null;
        } else {
            return PublicUtil.toAppendStr("redirect:", adminPath, "/login");
        }
    }
}
