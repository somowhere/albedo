package com.albedo.java.web.rest;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.BeanValidators;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.domain.CustomMessage;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.base.GeneralResource;
import com.albedo.java.web.rest.errors.CustomParameterizedException;
import com.albedo.java.web.rest.util.RequestUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.support.MissingServletRequestPartException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.List;
import java.util.Set;

@ControllerAdvice
public class ExceptionTranslator {
    @Resource
    protected AlbedoProperties albedoProperties;
    /**
     * 日志对象
     */
    protected Logger log = LoggerFactory.getLogger(getClass());
    /**
     * 参数绑定异常
     */
    @ExceptionHandler({Exception.class})
    public String bindException(Exception e, HttpServletRequest request, HttpServletResponse response) {
        log.warn("请求链接:{} 操作异常:{}", request.getRequestURI(), e.getMessage());
        CustomMessage message = new CustomMessage();
        message.setStatus(Globals.MSG_TYPE_WARNING);
        if (e instanceof RuntimeMsgException) {
            RuntimeMsgException msg = (RuntimeMsgException) e;
            message.setData(msg.getData());
            message.addMessage(msg.getMessage());
        } else if (e instanceof BindException ||
                e instanceof MissingServletRequestPartException ||
                e instanceof MissingServletRequestParameterException) {
            message.setCode(Globals.ERROR_HTTP_CODE_400);
            message.addMessage("您提交的参数，服务器无法处理");
        } else if (e instanceof AccessDeniedException) {
            message.setCode(Globals.ERROR_HTTP_CODE_403);
            message.addMessage("权限不足");
        } else if (e instanceof CustomParameterizedException) {
            CustomParameterizedException customParameterizedException= ((CustomParameterizedException) e);
            message.setData(customParameterizedException.getParams());
            message.addMessage(customParameterizedException.getMessage());
        } else if (e instanceof ConstraintViolationException) {
            ConstraintViolationException constraintViolationException = (ConstraintViolationException) e;
            Set<? extends ConstraintViolation> constraintViolations = constraintViolationException.getConstraintViolations();
            message.setData(constraintViolations);
            List<String> list = BeanValidators.extractPropertyAndMessageAsList((ConstraintViolationException) e, ": ");
            list.add(0, "数据验证失败：");
            message.addMessage(Collections3.convertToString(list, ""));
        } else if (e instanceof MethodArgumentNotValidException) {
            MethodArgumentNotValidException methodArgumentNotValidException = (MethodArgumentNotValidException) e;
            message.setData(BeanValidators.extractPropertyAndMessage(methodArgumentNotValidException));
            List<String> list = BeanValidators.extractPropertyAndMessageAsList(methodArgumentNotValidException, ": ");
            list.add(0, "数据验证失败：");
            message.addMessage(Collections3.convertToString(list, ""));
        } else {
            message.setCode(Globals.ERROR_HTTP_CODE_500);
            message.setStatus(Globals.MSG_TYPE_ERROR);
            message.setData(e);
            message.addMessage("操作异常; ");
            message.addMessage(e.getMessage());
        }


        if (albedoProperties.getHttp().getRestful() || RequestUtil.isRestfulRequest(request)) {
            GeneralResource.writeJsonHttpResponse(message, response);
            return null;
        } else {
            if (e instanceof BindException) {
                return "tip/400";
            } else if (e instanceof AccessDeniedException) {
                request.setAttribute(GeneralResource.MSG, e.getMessage());
                return "tip/401";
            } else {
                if (e instanceof RuntimeMsgException) {
                    RuntimeMsgException msg = (RuntimeMsgException) e;
                    if (msg.isRedirect()) {
                        request.getSession().setAttribute(GeneralResource.MSG, e.getMessage());
                        request.getSession().setAttribute(GeneralResource.MSG_TYPE, Globals.MSG_TYPE_WARNING);
                    } else {
                        request.setAttribute(GeneralResource.MSG, e.getMessage());
                        request.setAttribute(GeneralResource.MSG_TYPE, Globals.MSG_TYPE_WARNING);
                    }
                    return PublicUtil.isNotEmpty(msg.getUrl()) ? msg.getUrl() : "tip/200";
                }
                request.setAttribute(GeneralResource.MSG, message.readMessages());
                request.setAttribute(GeneralResource.MSG_TYPE, message.getStatus());
            }
            return "error";
        }

    }

}
