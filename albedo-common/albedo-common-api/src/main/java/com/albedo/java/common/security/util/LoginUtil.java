package com.albedo.java.common.security.util;

import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import com.albedo.java.common.core.util.AddressUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.util.RedisUtil;
import com.google.common.collect.Maps;
import org.springframework.security.core.Authentication;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;
import java.util.Objects;

public class LoginUtil {
	public final static String LOGIN_FAIL_MAP = "loginFailMap";

	/**
	 * 是否是验证码登录
	 *
	 * @param useruame 用户名
	 * @param isFail   计数加1
	 * @param clean    计数清零
	 * @return
	 */
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
		@SuppressWarnings("unchecked")
		Map<String, Integer> loginFailMap = RedisUtil.getCacheMap(LOGIN_FAIL_MAP);
		if (loginFailMap == null) {
			loginFailMap = Maps.newHashMap();
			RedisUtil.setCacheMap(LOGIN_FAIL_MAP, loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum == null) {
			loginFailNum = 0;
		}
		if (isFail) {
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean) {
			loginFailMap.remove(useruame);
		}
		return !SpringContextHolder.isDevelopment() && loginFailNum >= 3;
	}


	public static UserOnline getUserOnline(Authentication authentication) {
		UserOnline online = new UserOnline();
		HttpServletRequest request = ((ServletRequestAttributes) Objects
			.requireNonNull(RequestContextHolder.getRequestAttributes())).getRequest();
		HttpSession session = request.getSession(false);
		UserDetail user = SecurityUtil.getUser(authentication);
		online.setSessionId(String.valueOf(session.getId()));
		online.setDeptId(user.getDeptId());
		online.setDeptName(user.getDeptName());
		online.setUserId(user.getId());
		online.setUsername(user.getUsername());
		online.setStartTimestamp(new Date(session.getCreationTime()));
		online.setLastAccessTime(new Date(session.getLastAccessedTime()));
		online.setExpireTime((long) session.getMaxInactiveInterval());
		online.setIpAddress(WebUtil.getIP(request));
		online.setIpLocation(AddressUtil.getRealAddressByIP(online.getIpAddress()));
		online.setUserAgent(request.getHeader("User-Agent"));
		UserAgent userAgent = UserAgentUtil.parse(online.getUserAgent());
		online.setBrowser(userAgent.getBrowser().getName());
		online.setOs(userAgent.getOs().getName());
		return online;
	}
}
