package com.albedo.java.common.security.filter;

import com.albedo.java.common.core.config.ApplicationProperties;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

/**
 * 前端静态资源缓存过滤器
 * This filter is used in production, to put HTTP cache headers with a long (1 month) expiration time.
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
