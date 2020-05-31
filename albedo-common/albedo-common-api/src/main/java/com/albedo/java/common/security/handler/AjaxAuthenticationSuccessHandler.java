package com.albedo.java.common.security.handler;

import cn.hutool.http.HttpUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
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
 *
 * @author somewhere
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
		LogOperate logOperate = SysLogUtils.getSysLog();
		logOperate.setParams(HttpUtil.toParams(request.getParameterMap()));
		logOperate.setUsername(useruame);
		logOperate.setLogType(LogType.INFO.name());
		logOperate.setTitle("用户登录");
		AsyncUtil.recordLogLogin(logOperate);
		WebUtil.renderJson(response, Result.buildOk("登录成功"));
	}
}

