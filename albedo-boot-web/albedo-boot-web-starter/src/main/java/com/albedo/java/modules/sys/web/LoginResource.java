package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.CacheUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.web.rest.base.BaseResource;
import com.google.common.collect.Maps;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * REST controller for managing the current user's account.
 */
@Controller
@RequestMapping("${albedo.adminPath}/")
public class LoginResource extends BaseResource {

    public final static String LOGIN_FAIL_MAP = "loginFailMap";

    /**
	 * 登录成功，进入管理首页
	 */
	@RequestMapping(value = Globals.INDEX_URL)
	public String index(HttpServletRequest request, HttpServletResponse respons, Model modele) {
		User user = SecurityUtil.getCurrentUser();
		if(PublicUtil.isEmpty(user.getId())){
			return PublicUtil.toAppendStr("redirect:", adminPath, "/login");
		}
		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(request.getSession().getId(), false, true);
		session.setAttribute("moduleList", SecurityUtil.getModuleList());
		modele.addAttribute("loginId", user.getLoginId());
		return "index";
	}
	
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, Model model) {
//		String login = SecurityUtils.getCurrentUserLoginId();
//		if(StringUtils.isNotEmpty(login)&& !CustomAuditEventRepository.ANONYMOUS_USER.equalsIgnoreCase(login)){// 如果已经登录，则跳转到管理首页
//			return PublicUtil.toAppendStr("redirect:", adminPath, "/index");
//		}
		model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(request.getSession().getId(), false, false));
		return "login";
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null){    
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		request.getSession().invalidate();
		return PublicUtil.toAppendStr("redirect:", adminPath, "/login");
	}
	
	
	/**
	 * 是否是验证码登录
	 * 
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 * @return
	 */
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean) {
		@SuppressWarnings("unchecked")
		Map<String, Integer> loginFailMap = (Map<String, Integer>) CacheUtil.get(LOGIN_FAIL_MAP);
		if (loginFailMap == null) {
			loginFailMap = Maps.newHashMap();
			CacheUtil.put(LOGIN_FAIL_MAP, loginFailMap);
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
		return SystemConfig.isDevelopMode() ? false : loginFailNum >= 3;
	}
	
}
