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

import cn.hutool.core.codec.Base64;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.WebUtil;
import lombok.SneakyThrows;
import org.slf4j.MDC;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author somewhere
 */

public class ThreadLocalContextFilter extends OncePerRequestFilter {

	@SneakyThrows
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) {
		ContextUtil.setTenant(Base64.decodeStr(WebUtil.getHeader(request, ContextConstants.KEY_TENANT)));
		String traceId = request.getHeader(ContextConstants.TRACE_ID_HEADER);
		MDC.put(ContextConstants.LOG_TRACE_ID, StrUtil.isEmpty(traceId) ? StrUtil.EMPTY : traceId);
		MDC.put(ContextConstants.KEY_TENANT, ContextUtil.getTenant());

		filterChain.doFilter(request, response);
	}

}
