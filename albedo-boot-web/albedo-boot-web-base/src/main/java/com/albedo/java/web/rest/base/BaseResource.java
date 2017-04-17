package com.albedo.java.web.rest.base;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.BeanValidators;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.base.Encodes;
import com.albedo.java.util.domain.CustomMessage;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.exception.RuntimeMsgException;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.List;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
public class BaseResource extends  GeneralResource {

	@Resource
	protected AlbedoProperties albedoProperties;
	/**
	 * 参数绑定异常
	 */
	@ExceptionHandler({ Exception.class })
	public String bindException(Exception e, HttpServletRequest request, HttpServletResponse response) {
		setReqAndRes(response);
		log.warn("请求链接:{} 操作异常:{}", request.getRequestURI(), e.getMessage());
		CustomMessage message = new CustomMessage();
		message.setStatus(Globals.MSG_TYPE_WARNING);
		if (e instanceof RuntimeMsgException) {
			RuntimeMsgException msg = (RuntimeMsgException) e;
			message.setData(msg.getData());
			message.addMessage(msg.getMessage());
		} else if (e instanceof BindException) {
			message.addMessage("您提交的参数，服务器无法处理");
		} else if (e instanceof AccessDeniedException) {
			message.addMessage("权限不足");
		} else if (e instanceof ConstraintViolationException) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList((ConstraintViolationException) e, ": ");
			list.add(0, "数据验证失败：");
			message.addMessage(Collections3.convertToString(list, StringUtil.SPLIT_DEFAULT));
		} else if (e.getCause()!=null && e.getCause().getCause()!= null && e.getCause().getCause() instanceof ConstraintViolationException) {
			List<String> list = BeanValidators.extractPropertyAndMessageAsList((ConstraintViolationException) e.getCause().getCause(), ": ");
			list.add(0, "数据验证失败：");
			message.addMessage(Collections3.convertToString(list, StringUtil.SPLIT_DEFAULT));
		}
		else {
			e.printStackTrace();
			message.setStatus(Globals.MSG_TYPE_WARNING);
			message.addMessage("操作异常！请联系管理员");
		}

		String requestType = request.getHeader("X-Requested-With");
		if (albedoProperties.getHttp().getRestful() || "XMLHttpRequest".equals(requestType)) {
			writeJsonHttpResponse(message, response);
		} else {
			if (e instanceof BindException) {
				return "tip/400";
			} else if (e instanceof AccessDeniedException) {
				request.setAttribute(MSG, e.getMessage());
				return "tip/401";
			} else {
				if (e instanceof RuntimeMsgException) {
					RuntimeMsgException msg = (RuntimeMsgException) e;
					if (msg.isRedirect()) {
						request.getSession().setAttribute(MSG, e.getMessage());
						request.getSession().setAttribute(MSG_TYPE, Globals.MSG_TYPE_WARNING);
					} else {
						request.setAttribute(MSG, e.getMessage());
						request.setAttribute(MSG_TYPE, Globals.MSG_TYPE_WARNING);
					}
					return PublicUtil.isNotEmpty(msg.getUrl()) ? msg.getUrl() : "tip/200";
				}
				request.setAttribute(MSG, message.readMessages());
				request.setAttribute(MSG_TYPE, message.getStatus());
			}
			return "tip/500";
		}
		return null;
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
				model.addAttribute(CustomMessage.createError(msg));
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
			redirectAttributes.addAttribute(CustomMessage.createError(list.toArray(new String[] {})));
			return false;
		}
		return true;
	}



}
