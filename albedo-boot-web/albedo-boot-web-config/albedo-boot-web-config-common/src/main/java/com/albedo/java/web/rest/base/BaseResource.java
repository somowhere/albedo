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
import com.albedo.java.web.rest.errors.CustomParameterizedException;
import com.albedo.java.web.rest.util.RequestUtil;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.List;
import java.util.Set;

/**
 * 基础控制器支持类 copyright 2014 albedo all right reserved author MrLi created on
 * 2014年10月15日 下午4:04:00
 */
public class BaseResource extends GeneralResource {

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
     * @param object 验证的实体对象
     * @param groups 验证组
     * @return 验证成功：返回true；严重失败：将错误信息添加到 message 中
     */
    protected boolean beanValidator(Model model, Object object, Class<?>... groups) {
        try {
            BeanValidators.validateWithException(validator, object, groups);
        } catch (ConstraintViolationException ex) {
            List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
            list.add(0, "数据验证失败：");
            String[] msg = list.toArray(new String[]{});
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
     * @param object 验证的实体对象
     * @param groups 验证组
     * @return 验证成功：返回true；严重失败：将错误信息添加到 flash message 中
     */
    protected boolean beanValidatorRe(RedirectAttributes redirectAttributes, Object object, Class<?>... groups) {
        try {
            BeanValidators.validateWithException(validator, object, groups);
        } catch (ConstraintViolationException ex) {
            List<String> list = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
            list.add(0, "数据验证失败：");
            redirectAttributes.addAttribute(CustomMessage.createError(list.toArray(new String[]{})));
            return false;
        }
        return true;
    }


}
