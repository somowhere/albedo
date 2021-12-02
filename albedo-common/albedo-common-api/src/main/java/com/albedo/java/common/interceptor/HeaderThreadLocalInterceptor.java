package com.albedo.java.common.interceptor;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.WebUtil;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.MDC;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 拦截器：
 * 将请求头数据，封装到BaseContextHandler(ThreadLocal)
 * <p>
 * 该拦截器要优先于系统中其他的业务拦截器
 * <p>
 *
 * @author somewhere
 * @date 2020/10/31 9:49 下午
 */
@Slf4j
public class HeaderThreadLocalInterceptor implements AsyncHandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (!(handler instanceof HandlerMethod)) {
			return true;
		}
		ContextUtil.setTenant(WebUtil.getHeader(request, ContextConstants.JWT_KEY_TENANT));
		ContextUtil.setSubTenant(WebUtil.getHeader(request, ContextConstants.JWT_KEY_SUB_TENANT));

		String traceId = request.getHeader(ContextConstants.TRACE_ID_HEADER);
		MDC.put(ContextConstants.LOG_TRACE_ID, StrUtil.isEmpty(traceId) ? StrUtil.EMPTY : traceId);
		MDC.put(ContextConstants.JWT_KEY_TENANT, WebUtil.getHeader(request, ContextConstants.JWT_KEY_TENANT));
		MDC.put(ContextConstants.JWT_KEY_SUB_TENANT, WebUtil.getHeader(request, ContextConstants.JWT_KEY_SUB_TENANT));

		return true;
	}


	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		ContextUtil.remove();
	}
}
