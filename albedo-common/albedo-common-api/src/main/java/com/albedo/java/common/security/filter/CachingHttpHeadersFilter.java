/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * 前端静态资源缓存过滤器 This filter is used in production, to put HTTP cache headers with a long (1
 * month) expiration time.
 *
 * @author somewhere
 */
public class CachingHttpHeadersFilter implements Filter {

	/**
	 * We consider the last modified date is the start up time of the server
	 */
	private final static long LAST_MODIFIED = System.currentTimeMillis();

	private long cacheTimeToLive = TimeUnit.DAYS.toMillis(1461L);

	private ApplicationProperties applicationProperties;

	public CachingHttpHeadersFilter(ApplicationProperties applicationProperties) {
		this.applicationProperties = applicationProperties;
	}

	@Override
	public void init(FilterConfig filterConfig) {
		cacheTimeToLive = TimeUnit.DAYS.toMillis(applicationProperties.getHttp().getCache().getTimeToLiveInDays());
	}

	@Override
	public void destroy() {
		// Nothing to destroy
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws IOException, ServletException {

		HttpServletResponse httpResponse = (HttpServletResponse) response;

		httpResponse.setHeader("Cache-Control", "max-age=" + cacheTimeToLive + ", public");
		httpResponse.setHeader("Pragma", "cache");

		// Setting Expires header, for proxy caching
		httpResponse.setDateHeader("Expires", cacheTimeToLive + System.currentTimeMillis());

		// Setting the Last-Modified header, for browser caching
		httpResponse.setDateHeader("Last-Modified", LAST_MODIFIED);

		chain.doFilter(request, response);
	}

}
