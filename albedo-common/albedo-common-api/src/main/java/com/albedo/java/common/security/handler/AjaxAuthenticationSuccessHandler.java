package com.albedo.java.common.security.handler;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.log.event.SysUserOnlineEvent;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.util.AsyncUtil;
import com.albedo.java.modules.sys.domain.UserOnline;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Spring Security success handler, specialized for Ajax requests.
 */
public class AjaxAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
										Authentication authentication) {
		response.setStatus(HttpServletResponse.SC_OK);
		String useruame = request.getParameter("username");
		LoginUtil.isValidateCodeLogin(useruame, false, true);
		UserOnline userOnline = LoginUtil.getUserOnline(authentication);
		SpringContextHolder.publishEvent(new SysUserOnlineEvent(userOnline));
		String message = "登录成功";
		AsyncUtil.recordLogLogin(useruame, CommonConstants.STR_SUCCESS, message);
		WebUtil.renderJson(response, R.buildOk(message));
	}
}
