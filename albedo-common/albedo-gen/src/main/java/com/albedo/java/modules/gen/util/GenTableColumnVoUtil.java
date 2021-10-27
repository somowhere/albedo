/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.gen.util;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import lombok.extern.slf4j.Slf4j;

/**
 * 代码生成工具类
 *
 * @author somewhere
 * @version 2013-11-16
 */
@Slf4j
public class GenTableColumnVoUtil {

	public static String getHibernateValidatorExpression(TableColumnDto c) {
		if (!c.isPk() && !c.isNull()) {
			if (c.getJavaType() != null && c.getJavaType().endsWith(CommonConstants.TYPE_STRING)) {
				return (new StringBuilder()).append("@NotBlank ").append(getNotRequiredHibernateValidatorExpression(c))
					.toString();
			} else {
				return (new StringBuilder()).append("@NotNull ").append(getNotRequiredHibernateValidatorExpression(c))
					.toString();
			}
		} else {
			return getNotRequiredHibernateValidatorExpression(c);
		}
	}

	public static String getNotRequiredHibernateValidatorExpression(TableColumnDto c) {
		if (c == null) {
			return null;
		}
		String result = "", javaType = c.getJavaType(), jdbcType = c.getJdbcType();
		boolean mail = c.getName().contains("mail");
		if (c.getName() != null && mail) {
			result = (new StringBuilder()).append(result).append("@Email ").toString();
		}
		if (javaType == null) {
			javaType = "";
		}
		if (javaType.endsWith(CommonConstants.TYPE_STRING) && jdbcType != null) {
			Integer size = "text".equals(jdbcType) || "blob".equalsIgnoreCase(jdbcType)
				|| "clob".equalsIgnoreCase(jdbcType) || "nclob".equalsIgnoreCase(jdbcType) ? 65535
				: Integer.valueOf(jdbcType.substring(jdbcType.indexOf("(") + 1, jdbcType.length() - 1));
			result = (new StringBuilder()).append(result).append(String.format("@Size(max=%s)", size)).toString();
		}
		boolean javaTypeByte = javaType.endsWith("Byte");
		if (javaType.endsWith(CommonConstants.TYPE_LONG) || javaType.endsWith(CommonConstants.TYPE_INTEGER)
			|| javaType.endsWith(CommonConstants.TYPE_SHORT) || javaTypeByte) {
			boolean aShort = javaType.toLowerCase().contains("short");
			boolean abyte = javaType.toLowerCase().contains("byte");
			if (aShort) {
				result = (new StringBuilder()).append(result).append(" @Max(32767)").toString();
			} else if (abyte) {
				result = (new StringBuilder()).append(result).append(" @Max(127)").toString();
			}
		}
		return result.trim();
	}

}
