/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

import cn.hutool.http.HttpUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.log.event.SysLogLoginEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.modules.sys.domain.LogLoginDo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
@AllArgsConstructor
public class AjaxAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	private final UserDetailsService userDetailsService;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
										AuthenticationException exception) {
		String username = request.getParameter("username");
		LoginUtil.isValidateCodeLogin(username, true, false);
		String message = exception instanceof BadCredentialsException
			&& "Bad credentials".equals(exception.getMessage()) ? "密码填写错误！" : exception.getMessage();
		LogLoginDo logLoginDo = SysLogUtils.getSysLogLogin();
		logLoginDo.setParams(HttpUtil.toParams(request.getParameterMap()));
		logLoginDo.setUsername(username);
		try {
			UserDetail userDetails = (UserDetail) userDetailsService.loadUserByUsername(username);
			if (userDetails != null) {
				logLoginDo.setCreatedBy(userDetails.getId());
			}
		} catch (Exception e) {
			log.debug("can not find createId by username[{}]", username);
		}
		logLoginDo.setTitle("用户登录失败");
		logLoginDo.setDescription(message);

		// 发送异步日志事件
		SpringContextHolder.publishEvent(new SysLogLoginEvent(logLoginDo));
		response.setStatus(HttpServletResponse.SC_OK);
		WebUtil.renderJson(response, Result.buildFail(message));
	}

}
