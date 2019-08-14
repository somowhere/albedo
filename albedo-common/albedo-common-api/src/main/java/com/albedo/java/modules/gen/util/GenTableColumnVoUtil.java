package com.albedo.java.modules.gen.util;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 代码生成工具类
 *
 * @author somewhere
 * @version 2013-11-16
 */
public class GenTableColumnVoUtil {

	private static Logger logger = LoggerFactory.getLogger(GenTableColumnVoUtil.class);


	public static String getHibernateValidatorExpression(TableColumnVo c) {
		if (!c.isPk() && !c.isNull()) {
			if (c.getJavaType() != null && c.getJavaType().endsWith(CommonConstants.TYPE_STRING)) {
				return (new StringBuilder()).append("@NotBlank ").append(getNotRequiredHibernateValidatorExpression(c)).toString();
			} else {
				return (new StringBuilder()).append("@NotNull ").append(getNotRequiredHibernateValidatorExpression(c)).toString();
			}
		} else {
			return getNotRequiredHibernateValidatorExpression(c);
		}
	}

	public static String getNotRequiredHibernateValidatorExpression(TableColumnVo c) {
		if (c == null) {
			return null;
		}
		String result = "", javaType = c.getJavaType(), jdbcType = c.getJdbcType();
		if (c.getName() != null && c.getName().indexOf("mail") >= 0) {
			result = (new StringBuilder()).append(result).append("@Email ").toString();
		}
		if (javaType == null) {
			javaType = "";
		}
		if (javaType.endsWith(CommonConstants.TYPE_STRING) && jdbcType != null) {
			Integer size = "text".equals(jdbcType) || "clob".equalsIgnoreCase(jdbcType) || "nclob".equalsIgnoreCase(jdbcType) ? 65535 : Integer.valueOf(jdbcType.substring(jdbcType.indexOf("(") + 1, jdbcType.length() - 1));
			result = (new StringBuilder()).append(result).append(String.format("@Size(max=%s)", size)).toString();
		}
		if (javaType.endsWith(CommonConstants.TYPE_LONG) || javaType.endsWith(CommonConstants.TYPE_INTEGER) || javaType.endsWith(CommonConstants.TYPE_SHORT) || javaType.endsWith("Byte")) {
			if (javaType.toLowerCase().indexOf("short") >= 0) {
				result = (new StringBuilder()).append(result).append(" @Max(32767)").toString();
			} else if (javaType.toLowerCase().indexOf("byte") >= 0) {
				result = (new StringBuilder()).append(result).append(" @Max(127)").toString();
			}
		}
		return result.trim();
	}

}
