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

package com.albedo.java.common.security.component;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.WebUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Returns a 401 error code (Unauthorized) to the client.
 *
 * @author somewhere
 */
public class Http401UnauthorizedEntryPoint implements AuthenticationEntryPoint {

	private final Logger log = LoggerFactory.getLogger(Http401UnauthorizedEntryPoint.class);

	private final ApplicationProperties applicationProperties;

	public Http401UnauthorizedEntryPoint(ApplicationProperties applicationProperties) {
		this.applicationProperties = applicationProperties;
	}

	/**
	 * Always returns a 401 error code to the client.
	 */
	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException arg2) {

		log.debug("Pre-authenticated entry point called. Rejecting access");

		response.setStatus(HttpStatus.UNAUTHORIZED.value());
		WebUtil.renderJson(response, Result.buildFail("权限不足或登录超时"));
	}

}
