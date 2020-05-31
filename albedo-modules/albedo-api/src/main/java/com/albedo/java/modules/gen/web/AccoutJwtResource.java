package com.albedo.java.modules.gen.web;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.security.filter.PasswordDecoderFilter;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.vo.account.LoginVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.Date;
import java.util.LinkedHashMap;

/**
 * 账户相关数据接口
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}")
@Api(tags = "账户相关数据接口")
@Slf4j
@AllArgsConstructor
@Profile(CommonConstants.SPRING_PROFILE_JWT)
public class AccoutJwtResource extends BaseResource {

	private final RedisTemplate redisTemplate;
	private final TokenProvider tokenProvider;
	private final ApplicationProperties applicationProperties;
	private final AuthenticationManager authenticationManager;

	/**
	 * 刷新登录Token
	 *
	 * @param jwt the HTTP request
	 */
	@GetMapping("/refresh-token")
	@ApiOperation("刷新登录Token")
	public R refreshToken(@RequestHeader(value = HttpHeaders.AUTHORIZATION) String jwt) {
		String refreshToken = tokenProvider.refreshToken(jwt);
		if (StringUtil.isEmpty(refreshToken)) {
			return R.buildFail("无效jwt");
		}
		return R.buildOkData(new LinkedHashMap<String, Object>() {{
			put("access_token", refreshToken);
			put("expires_in", tokenProvider.getExpirationDateSecondsFromToken(refreshToken));
		}});
	}


	/**
	 * 功能描述: 认证授权
	 */
	@PostMapping("/authenticate")
	@ApiOperation("认证授权")
	public ResponseEntity authorize(@Valid @RequestBody LoginVo loginVo) {

		Date canLoginDate = RedisUtil.getCacheObject(SecurityConstants.DEFAULT_LOGIN_AFTER_24_KEY + loginVo.getUsername());
		if (canLoginDate != null) {
			return ResultBuilder.buildFail(HttpStatus.UNAUTHORIZED, "您的账号在" + DateUtil.format(canLoginDate) + "后才可登录");
		}

		if (!SpringContextHolder.isDevelopment()) {
			LoginUtil.checkCode(loginVo);
		}
		try {
			String s = PasswordDecoderFilter.decryptAES(loginVo.getPassword(), applicationProperties.getSecurity().getEncodeKey());
			loginVo.setPassword(s.trim());
		} catch (Exception e) {
		}
		UsernamePasswordAuthenticationToken authenticationToken =
			new UsernamePasswordAuthenticationToken(loginVo.getUsername(), loginVo.getPassword());

		String keyLoginCount = SecurityConstants.DEFAULT_LOGIN_KEY + loginVo.getUsername();
		try {
			Authentication authentication = this.authenticationManager.authenticate(authenticationToken);
			SecurityContextHolder.getContext().setAuthentication(authentication);
			boolean rememberMe = (loginVo.getRememberMe() == null) ? false : loginVo.getRememberMe();
			String jwt = tokenProvider.createToken(authentication, rememberMe);
			log.info("jwt:{}", jwt);
			RedisUtil.delete(keyLoginCount);
			return ResultBuilder.buildOkData(new LinkedHashMap<String, Object>() {{
				put("access_token", jwt);
				put("expires_in", tokenProvider.getExpirationDateSecondsFromToken(jwt));
			}});
		} catch (AuthenticationException ae) {
			log.warn("Authentication exception trace: {}", ae);
			String msg = ae.getMessage();
			if (ae instanceof BadCredentialsException) {
				Integer cacheObject = RedisUtil.getCacheObject(keyLoginCount);
				if (cacheObject == null) {
					cacheObject = 1;
				}
				msg = "密码错误，请重试";
				if (cacheObject >= 5 && cacheObject < 9) {
					msg = "您还剩" + (10 - cacheObject) + "次密码输入机会，建议点击‘忘记密码’";
				} else if (cacheObject == 9) {
					msg = "您还剩1次密码输入机会，再次错误，您的账号将被暂时锁定24小时，24小时内禁止登录";
				} else if (cacheObject > 9) {
					msg = "您密码错误次数已超过10次，您的账号将被暂时锁定24小时，建议点击‘忘记密码’，凭手机号码重置密码，24小时后再尝试登录";
					cacheObject = 0;
//                    RedisUtil.setCacheObject(SecurityConstants.DEFAULT_LOGIN_AFTER_24_KEY +loginVo.getUsername(), DateUtil.addDays(PublicUtil.getCurrentDate(), 1), 1, TimeUnit.DAYS);
				}
				RedisUtil.setCacheObject(keyLoginCount, 1 + cacheObject);
			}
			return ResultBuilder.buildFail(HttpStatus.UNAUTHORIZED, msg);
		}
	}

	/**
	* @Description: 登出
	* @Param: [authHeader, request, response]
	* @return: org.springframework.http.ResponseEntity
	* @Author: somewhere
	* @Date: 2020/5/30
	*/
	@GetMapping(value = "/logout")
	@ApiOperation("登出")
	public ResponseEntity logout(@RequestHeader(value = HttpHeaders.AUTHORIZATION, required = false) String authHeader,
								 HttpServletRequest request, HttpServletResponse response) {
		String tokenValue = authHeader.replace("Bearer ", StrUtil.EMPTY).trim();
		RedisUtil.delete(tokenValue);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		WebUtil.removeCookie(response, HttpHeaders.AUTHORIZATION);
		request.getSession().invalidate();
		return ResultBuilder.buildOk("退出登录成功");

	}
}
