/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.security.handler;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.http.HttpUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.util.AsyncUtil;
import com.albedo.java.modules.sys.domain.LogOperate;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author somewhere
 * @description Returns a 401 error code (Unauthorized) to the client, when Ajax
 * authentication fails.
 * @date 2020/5/30 11:23 下午
 */
@AllArgsConstructor
public class AjaxAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	private final UserDetailsService userDetailsService;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
										AuthenticationException exception) {
		String useruame = request.getParameter("username");
		LoginUtil.isValidateCodeLogin(useruame, true, false);
		String message = exception instanceof BadCredentialsException
			&& "Bad credentials".equals(exception.getMessage()) ? "密码填写错误！" : exception.getMessage();
		LogOperate logOperate = SysLogUtils.getSysLog();
		logOperate.setParams(HttpUtil.toParams(request.getParameterMap()));
		logOperate.setUsername(useruame);
		try {
			UserDetail userDetails = (UserDetail) userDetailsService.loadUserByUsername(useruame);
			if (userDetails != null) {
				logOperate.setCreatedBy(userDetails.getId());
			}
		} catch (Exception e) {
		}
		logOperate.setLogType(LogType.WARN.name());
		logOperate.setTitle("用户登录失败");
		logOperate.setDescription(message);
		logOperate.setException(ExceptionUtil.stacktraceToString(exception));
		AsyncUtil.recordLogLogin(logOperate);
		response.setStatus(HttpServletResponse.SC_OK);
		WebUtil.renderJson(response, Result.buildFail(message));
	}

}
