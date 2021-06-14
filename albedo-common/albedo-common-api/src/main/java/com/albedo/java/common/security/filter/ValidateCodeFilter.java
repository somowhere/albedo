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

package com.albedo.java.common.security.filter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.modules.sys.domain.vo.account.LoginVo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:26 下午
 */
@AllArgsConstructor
@Slf4j
public class ValidateCodeFilter extends OncePerRequestFilter {

	private final AuthenticationFailureHandler authenticationFailureHandler;

	private final ApplicationProperties applicationProperties;

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
		throws ServletException, IOException {
		if (StringUtil.equals(applicationProperties.getAdminPath(SecurityConstants.AUTHENTICATE_URL),
			request.getRequestURI()) && StringUtil.equalsIgnoreCase(request.getMethod(), "post")) {
			if (!SpringContextHolder.isDevelopment()) {
				LoginVo loginVo = new LoginVo();
				loginVo.setCode(request.getParameter("code"));
				loginVo.setRandomStr(request.getParameter("randomStr"));
				try {
					LoginUtil.checkCode(loginVo);
				} catch (AuthenticationException e) {
					WebUtil.renderJson(response, Result.buildFail(e.getMessage()));
					return;
				}
			}
		}
		filterChain.doFilter(request, response);
	}

}
