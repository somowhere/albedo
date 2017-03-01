package com.albedo.java.web.rest.base;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;

import com.albedo.java.util.domain.Message;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.domain.util.BeanValidators;
import com.albedo.java.util.DateUtil;
import com.albedo.java.util.Json;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.base.Encodes;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Maps;
import com.zaxxer.hikari.HikariConfig;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
public class BaseResource {

	protected final String RESPONSE_JSON = "text/json; charset=UTF-8";
	protected final String ENCODING_UTF8 = "UTF-8";
	/*** 返回消息状态头 type */
	public static final String MSG_TYPE = "status";
	/*** 返回消息内容头 msg */
	public static final String MSG = "message";
	/*** 返回消息内容头 msg */
	public static final String DATA = "data";
	/*** 返回消息类型 info */
	public static final String MSG_TYPE_INFO = "0";
	/*** 返回消息类型 success */
	public static final String MSG_TYPE_SUCCESS = "1";
	/*** 返回消息类型 warning */
	public static final String MSG_TYPE_WARNING = "2";
	/*** 返回消息类型 error */
	public static final String MSG_TYPE_ERROR = "-1";
	/*** 返回消息类型 error */
	public static final String MSG_TYPE_LOGIN = "-99";
	/** 日志对象 */
	protected Logger log = LoggerFactory.getLogger(getClass());
	protected static Logger logger = LoggerFactory.getLogger(BaseResource.class);
	/**
	 * 1 管理基础路径
	 */
	@Value("${albedo.adminPath}")
	protected String adminPath;

	/**
	 * 前端基础路径
	 */
	@Value("${albedo.frontPath}")
	protected String frontPath;
	@Resource
	protected AlbedoProperties albedoProperties;
	/**
	 * 前端URL后缀
	 */
	@Value("${albedo.urlSuffix}")
	protected String urlSuffix;
	/** 验证Bean实例对象 */
	@Resource
	protected Validator validator;
	@Resource
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;

	@ModelAttribute
	public void setReqAndRes(HttpServletResponse response) {
		this.response = response;
		this.session = request.getSession();
	}

	/**
	 * 参数绑定异常
	 */
	@ExceptionHandler({ Exception.class })
	public String bindException(Exception e, HttpServletRequest request, HttpServletResponse response) {
		setReqAndRes(response);
		log.warn("请求链接:{} 操作异常:{}", request.getRequestURI(), e.getMessage());
		Message message = new Message();
		message.setStatus(MSG_TYPE_WARNING);
		if (e instanceof RuntimeMsgException) {
			RuntimeMsgException msg = (RuntimeMsgException) e;
			message.setData(msg.getData());
			message.setMessage(msg.getMessage());
		} else if (e instanceof BindException) {
			message.setMessage("您提交的参数，服务器无法处理");
		} else if (e instanceof AccessDeniedException) {
			message.setMessage("权限不足");
		} else if (e instanceof ConstraintViolationException) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList((ConstraintViolationException) e, ": ");
			list.add(0, "数据验证失败：");
			message.setMessage(Collections3.convertToString(list, StringUtil.SPLIT_DEFAULT));
		} else if (e.getCause()!=null && e.getCause().getCause()!= null && e.getCause().getCause() instanceof ConstraintViolationException) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList((ConstraintViolationException) e.getCause().getCause(), ": ");
			list.add(0, "数据验证失败：");
			message.setMessage(Collections3.convertToString(list, StringUtil.SPLIT_DEFAULT));
		}
		else {
			e.printStackTrace();
			message.setStatus(MSG_TYPE_WARNING);
			message.setMessage("操作异常！请联系管理员");
		}

		String requestType = request.getHeader("X-Requested-With");
		if (albedoProperties.getHttp().getRestful() || "XMLHttpRequest".equals(requestType)) {
			writeJsonHttpResponse(message, response);
		} else {
			if (e instanceof BindException) {
				return "400";
			} else if (e instanceof AccessDeniedException) {
				request.setAttribute(MSG, e.getMessage());
				return "401";
			} else {
				if (e instanceof RuntimeMsgException) {
					RuntimeMsgException msg = (RuntimeMsgException) e;
					if (msg.isRedirect()) {
						request.getSession().setAttribute(MSG, e.getMessage());
						request.getSession().setAttribute(MSG_TYPE, MSG_TYPE_WARNING);
					} else {
						request.setAttribute(MSG, e.getMessage());
						request.setAttribute(MSG_TYPE, MSG_TYPE_WARNING);
					}
					return PublicUtil.isNotEmpty(msg.getUrl()) ? msg.getUrl() : "error";
				}
				request.setAttribute(MSG, message.getMessage());
				request.setAttribute(MSG_TYPE, message.getStatus());
			}
			return "error";
		}
		return null;
	}

	public static final void writeStringHttpResponse(String str, HttpServletResponse response) {
		if (str == null)
			throw new RuntimeMsgException("WRITE_STRING_RESPONSE_NULL");
		response.reset();
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(str);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public static final void writeJsonHttpResponse(Object object, HttpServletResponse response) {
		if (object == null)
			throw new RuntimeMsgException("WRITE_JSON_RESPONSE_NULL");
		try {
			response.reset();
			response.setContentType("text/json; charset=UTF-8");
			response.setCharacterEncoding("UTF-8");
			String str = object instanceof String ? (String) object : Json.toJsonString(object);
			logger.info("write {}", str);
			response.getWriter().write(str);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	/**
	 * 输出到客户端
	 * 
	 * @param fileName 输出文件名
	 */
	public void write(HttpServletResponse response, SXSSFWorkbook wb, String fileName) {
		try {
		response.reset();
		response.setContentType("application/octet-stream; charset=utf-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + Encodes.urlEncode(fileName));
		wb.write(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 添加Model消息
	 * 
	 * @param messages
	 *            消息
	 */
	protected void addMessage(Model model, String type, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages) {
			sb.append(message).append(messages.length > 1 ? "<br/>" : "");
		}
		model.addAttribute(MSG, sb.toString());
		model.addAttribute(MSG_TYPE, type);
	}

	/**
	 * 添加Model消息
	 * @param model
	 * @param message
	 */
	protected void addMessage(Model model, String message) {
		boolean falg = PublicUtil.isEmpty(message);
		model.addAttribute(MSG, message);
		model.addAttribute(MSG_TYPE, falg ? MSG_TYPE_SUCCESS : MSG_TYPE_WARNING);
	}

	/**
	 * 添加警告Model消息
	 * @param model
	 * @param message
	 */
	protected void addWarnMessage(Model model, String message) {
		model.addAttribute(MSG, message);
		model.addAttribute(MSG_TYPE, MSG_TYPE_WARNING);
	}

	/**
	 * 添加ajaxModel消息
	 * @param map
	 * @param type
	 * @param message
	 */
	protected void addAjaxMessage(Map<String, String> map, String type, String message) {
		map.put(MSG_TYPE, type);
		map.put(MSG, message);
	}

	/**
	 * 添加ajaxModel消息
	 * @param map
	 * @param type
	 * @param message
	 */
	protected void addAjaxObjectMessage(Map<String, Object> map, String type, String message) {
		map.put(MSG_TYPE, type);
		map.put(MSG, message);
	}

	/**
	 * 添加ajaxModel消息
	 * @param map
	 * @param message
	 */
	protected void addAjaxMessage(Map<String, String> map, String message) {
		boolean flag = PublicUtil.isEmpty(message);
		map.put(MSG_TYPE, flag ? MSG_TYPE_SUCCESS : MSG_TYPE_WARNING);
		map.put(MSG, flag ? "操作成功" : message);
		map.put("tip", "true");
	}

	/**
	 * 添加ajaxModel消息
	 * @param map
	 * @param message
	 */
	protected void addAjaxObjectMessage(Map<String, Object> map, String message) {
		boolean flag = PublicUtil.isEmpty(message);
		map.put(MSG_TYPE, flag ? MSG_TYPE_SUCCESS : MSG_TYPE_WARNING);
		map.put(MSG, flag ? "操作成功" : message);
		map.put("tip", "true");
	}
	public static void addStaticAjaxMsg(String status, String message, HttpServletResponse response) {
		Map<String, String> map = Maps.newHashMap();
		map.put(MSG_TYPE, status);
		map.put(MSG, message);
		writeJsonHttpResponse(map, response);
	}
	protected void addAjaxMsg(String status, String message) {
		addAjaxMsg(status, message, response);
	}
	protected void addAjaxMsg(String status, String message, HttpServletResponse response) {
		Map<String, String> map = Maps.newHashMap();
		map.put(MSG_TYPE, status);
		map.put(MSG, message);
		writeJsonHttpResponse(map, response);
	}
	
	
	protected void addAjaxSuccessMsg(Object data, String message, HttpServletResponse response) {
		addAjaxMsg(MSG_TYPE_SUCCESS, message, data, response);
	}
	
	protected void addAjaxSuccessMsg(Object data, HttpServletResponse response) {
		addAjaxSuccessMsg(data, "操作成功", response);
	}
	
	
	protected void addAjaxWarnMsg(Object data, String message, HttpServletResponse response) {
		addAjaxMsg(MSG_TYPE_WARNING, message, data, response);
	}
	protected void addAjaxWarnMsg(String message, HttpServletResponse response) {
		addAjaxMsg(MSG_TYPE_WARNING, message, response);
	}

	protected void addAjaxMsg(String status, String message, Object data, HttpServletResponse response) {
		Map<String, Object> map = Maps.newHashMap();
		map.put(MSG_TYPE, status);
		map.put(MSG, message);
		map.put(DATA, data);
		writeJsonHttpResponse(map, response);
	}
	
	/**
	 * 添加Flash消息
	 * 
	 * @param type
	 *            消息类型：info、success、warning、error、loading
	 * @param messages
	 *            消息
	 */
	protected void addMessage(RedirectAttributes redirectAttributes, String type, String... messages) {
		StringBuilder sb = new StringBuilder();
		for (String message : messages) {
			sb.append(message).append(messages.length > 1 ? "<br/>" : "");
		}
		redirectAttributes.addFlashAttribute(MSG, sb.toString());
		redirectAttributes.addFlashAttribute(MSG_TYPE, type);
	}

	/**
	 * 
	 * @param redirectAttributes
	 * @param message
	 */
	protected void addWarnMessage(RedirectAttributes redirectAttributes, String message) {
		redirectAttributes.addFlashAttribute(MSG, message);
		redirectAttributes.addFlashAttribute(MSG_TYPE, MSG_TYPE_WARNING);
	}

	/**
	 * 
	 * @param redirectAttributes
	 * @param message
	 */
	protected void addMessage(RedirectAttributes redirectAttributes, String message) {
		boolean falg = PublicUtil.isEmpty(message);
		redirectAttributes.addFlashAttribute(MSG, falg ? "操作成功" : message);
		redirectAttributes.addFlashAttribute(MSG_TYPE, falg ? MSG_TYPE_SUCCESS : MSG_TYPE_WARNING);
	}

	protected boolean beanValidatorAjax(Object object, Class<?>... groups) {
		return beanValidator(null, object, groups);
	}

	/**
	 * 服务端参数有效性验证
	 * 
	 * @param object
	 *            验证的实体对象
	 * @param groups
	 *            验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 message 中
	 */
	protected boolean beanValidator(Model model, Object object, Class<?>... groups) {
		try {
			BeanValidators.validateWithException(validator, object, groups);
		} catch (ConstraintViolationException ex) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
			list.add(0, "数据验证失败：");
			String[] msg = list.toArray(new String[] {});
			if (model == null) {
				throw new RuntimeMsgException(PublicUtil.toAppendStr(msg));
			} else {
				addMessage(model, MSG_TYPE_ERROR, msg);
			}
			return false;
		}
		return true;
	}

	/**
	 * 服务端参数有效性验证
	 * 
	 * @param object
	 *            验证的实体对象
	 * @param groups
	 *            验证组
	 * @return 验证成功：返回true；严重失败：将错误信息添加到 flash message 中
	 */
	protected boolean beanValidatorRe(RedirectAttributes redirectAttributes, Object object, Class<?>... groups) {
		try {
			BeanValidators.validateWithException(validator, object, groups);
		} catch (ConstraintViolationException ex) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
			list.add(0, "数据验证失败：");
			addMessage(redirectAttributes, MSG_TYPE_ERROR, list.toArray(new String[] {}));
			return false;
		}
		return true;
	}

	/** 初始化数据绑定 1. 将所有传递进来的String进行HTML编码，防止XSS攻击 2. 将字段中Date类型转换为String类型 */
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		// String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
		binder.registerCustomEditor(String.class, new PropertyEditorSupport() {

			public void setAsText(String text) {
				setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
			}

			public String getAsText() {
				Object value = getValue();
				return value != null ? value.toString() : "";
			}
		});
		// Date 类型转换
		binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
			public void setAsText(String text) {
				setValue(DateUtil.parseDate(text));
			}
		});
	}

}
