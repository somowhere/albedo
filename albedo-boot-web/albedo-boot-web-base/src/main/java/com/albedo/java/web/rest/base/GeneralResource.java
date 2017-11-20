package com.albedo.java.web.rest.base;

import com.albedo.java.util.DateUtil;
import com.albedo.java.util.Json;
import com.albedo.java.util.exception.RuntimeMsgException;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Validator;
import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.util.Date;

/**
 * Created by lijie on 2017/3/23.
 */
public class GeneralResource {

    /*** 返回消息状态头 type */
    public static final String MSG_TYPE = "status";
    /*** 返回消息内容头 msg */
    public static final String MSG = "message";
    /*** 返回消息内容头 msg */
    public static final String DATA = "data";
    protected static Logger logger = LoggerFactory.getLogger(GeneralResource.class);
    protected static final String RESPONSE_JSON = "application/json;charset=UTF-8";
    protected final String ENCODING_UTF8 = "UTF-8";
    /**
     * 日志对象
     */
    protected Logger log = LoggerFactory.getLogger(getClass());
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
    /**
     * 前端URL后缀
     */
    @Value("${albedo.urlSuffix}")
    protected String urlSuffix;
    /**
     * 验证Bean实例对象
     */
    @Resource
    protected Validator validator;
    @Resource
    protected HttpServletRequest request;
    protected HttpServletResponse response;
    protected HttpSession session;

    public static final void writeStringHttpResponse(String str, HttpServletResponse response) {
        if (str == null) {
            throw new RuntimeMsgException("WRITE_STRING_RESPONSE_NULL");
        }
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
        if (object == null) {
            throw new RuntimeMsgException("WRITE_JSON_RESPONSE_NULL");
        }
        try {
            response.reset();
            response.setContentType(RESPONSE_JSON);
            response.setCharacterEncoding("UTF-8");
            String str = object instanceof String ? (String) object : Json.toJsonString(object);
            logger.info("write {}", str);
            response.getWriter().write(str);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @ModelAttribute
    public void setReqAndRes(HttpServletResponse response) {
        this.response = response;
        this.session = request.getSession();
    }

    /**
     * 初始化数据绑定 1. 将所有传递进来的String进行HTML编码，防止XSS攻击 2. 将字段中Date类型转换为String类型
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        // String类型转换，将所有传递进来的String进行HTML编码，防止XSS攻击
        binder.registerCustomEditor(String.class, new PropertyEditorSupport() {

            @Override
            public void setAsText(String text) {
                setValue(text == null ? null : StringEscapeUtils.escapeHtml4(text.trim()));
            }

            @Override
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
