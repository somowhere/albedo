package com.albedo.java.common.core.resource;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.URLUtil;
import com.albedo.java.common.core.util.EscapeUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.beans.PropertyEditorSupport;
import java.util.Date;

/**
 * @author somewhere
 * @date 2017/3/23
 */
public class GeneralResource {

	protected static Logger logger = LoggerFactory.getLogger(GeneralResource.class);

	/**
	 * 日志对象
	 */
	protected Logger log = LoggerFactory.getLogger(getClass());

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
				setValue(text == null ? null : EscapeUtil.escapeHtml4(text.trim()));
			}
		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			@Override
			public void setAsText(String text) {
				String decode = URLUtil.decode(text);
				try {
					setValue(DateUtil.parse(decode).toJdkDate());
				} catch (Exception e) {
					setValue(DateUtil.calendar(Long.parseLong(decode)).getTime());
				}
			}
		});
	}

}
