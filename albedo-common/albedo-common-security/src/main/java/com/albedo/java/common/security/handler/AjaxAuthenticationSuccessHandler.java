/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.security.event.SysUserOnlineEvent;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.modules.sys.domain.LogLoginDo;
import com.albedo.java.modules.sys.domain.UserOnlineDo;
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
		UserOnlineDo userOnlineDo = LoginUtil.getUserOnline(authentication);
		SpringContextHolder.publishEvent(new SysUserOnlineEvent(userOnlineDo));
		LogLoginDo logLoginDo = SysLogUtils.getSysLogLogin();
		logLoginDo.setParams(HttpUtil.toParams(request.getParameterMap()));
		logLoginDo.setUsername(useruame);
		logLoginDo.setTitle("用户登录");
		SpringContextHolder.publishEvent(new SysLogLoginEvent(logLoginDo));
		WebUtil.renderJson(response, Result.buildOk("登录成功"));
	}

}
