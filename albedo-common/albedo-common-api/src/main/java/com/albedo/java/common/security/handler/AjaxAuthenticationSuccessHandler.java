package com.albedo.java.common.security.handler;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.http.HttpUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.event.SysUserOnlineEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.util.AsyncUtil;
import com.albedo.java.modules.sys.domain.LogOperate;
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
		String message = "用户";
		LogOperate logOperate = SysLogUtils.getSysLog();
		logOperate.setParams(HttpUtil.toParams(request.getParameterMap()));
		logOperate.setUsername(useruame);
		logOperate.setBusinessType(BusinessType.LOGIN.name());
		logOperate.setLogType(LogType.INFO.name());
		logOperate.setTitle(message);
		AsyncUtil.recordLogLogin(logOperate);
		WebUtil.renderJson(response, R.buildOk(message));
	}
}

