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

package com.albedo.java.common.security.filter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.security.filter.warpper.BodyRequestWrapper;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:24 下午
 */
public class BodyFilter extends OncePerRequestFilter {

	private final ApplicationProperties applicationProperties;

	public BodyFilter(ApplicationProperties applicationProperties) {
		this.applicationProperties = applicationProperties;
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
		throws ServletException, IOException {
		boolean isUpload = request.getRequestURI().contains("/file/upload");
		if (isUpload) {
			filterChain.doFilter(request, response);
		} else {
			filterChain.doFilter(new BodyRequestWrapper(request), response);
		}
	}

}
