package com.albedo.java.common.security.handler;

import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.util.LoginUtil;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Returns a 401 error code (Unauthorized) to the client, when Ajax authentication fails.
 */
public class AjaxAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
										AuthenticationException exception) {
		String useruame = request.getParameter("username");
		LoginUtil.isValidateCodeLogin(useruame, true, false);
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		WebUtil.renderJson(response, R.buildFail("用户名或密码错误"));
	}
}
