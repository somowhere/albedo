package com.albedo.java.common.core.resource;

import cn.hutool.core.date.DateUtil;
import org.apache.commons.lang.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Validator;
import java.beans.PropertyEditorSupport;
import java.util.Date;

/**
 * Created by somewhere on 2017/3/23.
 */
public class GeneralResource {

	/*** 返回消息状态头 type */
	public static final String CODE = "code";
	/*** 返回消息内容头 msg */
	public static final String MSG = "msg";
	/*** 返回消息内容头 msg */
	public static final String DATA = "data";
	protected static Logger logger = LoggerFactory.getLogger(GeneralResource.class);
	/**
	 * ThreadLocal确保高并发下每个请求的request，response都是独立的
	 */
	private static ThreadLocal<ServletRequest> currentRequest = new ThreadLocal<ServletRequest>();
	private static ThreadLocal<ServletResponse> currentResponse = new ThreadLocal<ServletResponse>();
	/**
	 * 日志对象
	 */
	protected Logger log = LoggerFactory.getLogger(getClass());
	/**
	 * 验证Bean实例对象
	 */
	@Resource
	protected Validator validator;

	/**
	 * 线程安全初始化reque，respose对象
	 *
	 * @param request
	 * @param response
	 */
	@ModelAttribute
	public void initReqAndRep(HttpServletRequest request, HttpServletResponse response) {
		currentRequest.set(request);
		currentResponse.set(response);
	}

	/**
	 * 线程安全
	 *
	 * @return
	 */
	public HttpServletRequest request() {
		return (HttpServletRequest) currentRequest.get();
	}

	/**
	 * 线程安全
	 *
	 * @return
	 */
	public HttpServletResponse response() {
		return (HttpServletResponse) currentResponse.get();
	}

	/**
	 * 初始化数据绑定 1. 将所有传递进来的String进行HTML编码，防止XSS攻击 2. 将字段中Date类型转换为String类型
	 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {

			@Override
			public String getAsText() {
				Object value = getValue();
				return value != null ? value.toString() : "";
			}

			@Override
			public void setAsText(String text) {
				setValue(text == null ? null : StringEscapeUtils.escapeHtml(text.trim()));
			}
		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			public void setAsText(String text) {
				setValue(DateUtil.parse(text).toJdkDate());
			}
		});
	}
}
