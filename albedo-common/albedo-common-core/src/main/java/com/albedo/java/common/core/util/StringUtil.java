/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.common.core.util;

import cn.hutool.core.util.EscapeUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.enums.SqlLike;
import com.baomidou.mybatisplus.core.toolkit.sql.SqlUtils;
import com.google.common.collect.Lists;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.DefaultResourceLoader;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 *
 * @author somewhere version 2014-1-20 下午3:37:29
 */
@UtilityClass
@Slf4j
public class StringUtil extends StrUtil {

	public static final String SPLIT_DEFAULT = ",";

	public static final String BRACKETS_START = "(";

	public static final String BRACKETS_END = ")";

	public static final String DOT_JAVA = ".java";

	private static final char SEPARATOR = '_';

	/**
	 * 转换为字节数组
	 *
	 * @param bytes
	 * @return
	 */
	public static String toString(byte[] bytes) {
		return new String(bytes, StandardCharsets.UTF_8);
	}

	/**
	 * 替换掉HTML标签方法
	 */
	public static String replaceHtml(String html) {
		if (isBlank(html)) {
			return "";
		}
		String regEx = "<.+?>";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(html);
		String s = m.replaceAll("");
		return s;
	}

	/**
	 * 替换为手机识别的HTML，去掉样式及属性，保留回车。
	 *
	 * @param html
	 * @return
	 */
	public static String replaceMobileHtml(String html) {
		if (html == null) {
			return "";
		}
		return html.replaceAll("<([a-z]+?)\\s+?.*?>", "<$1>");
	}

	/**
	 * 替换为手机识别的HTML，去掉样式及属性，保留回车。
	 *
	 * @param txt
	 * @return
	 */
	public static String toHtml(String txt) {
		if (txt == null) {
			return "";
		}
		return replace(replace(EscapeUtil.escapeHtml4(txt), "\n", "<br/>"), "\t", "&nbsp; &nbsp; ");
	}

	/**
	 * 缩略字符串（不区分中英文字符）
	 *
	 * @param str    目标字符串
	 * @param length 截取长度
	 * @return
	 */
	public static String abbr(String str, int length) {
		if (str == null) {
			return "";
		}
		try {
			StringBuilder sb = new StringBuilder();
			int currentLength = 0;
			for (char c : replaceHtml(EscapeUtil.unescapeHtml4(str)).toCharArray()) {
				currentLength += String.valueOf(c).getBytes("GBK").length;
				if (currentLength <= length - 3) {
					sb.append(c);
				} else {
					sb.append("...");
					break;
				}
			}
			return sb.toString();
		} catch (UnsupportedEncodingException e) {
			log.error("failed init", e);
		}
		return "";
	}

	/**
	 * 转换为Double类型
	 */
	public static Double toDouble(Object val) {
		if (val == null) {
			return 0D;
		}
		try {
			return Double.valueOf(trim(val.toString()));
		} catch (Exception e) {
			return 0D;
		}
	}

	/**
	 * 转换为Float类型
	 */
	public static Float toFloat(Object val) {
		return toDouble(val).floatValue();
	}

	/**
	 * 转换为Long类型
	 */
	public static Long toLong(Object val) {
		return toDouble(val).longValue();
	}

	/**
	 * 转换为Integer类型
	 */
	public static Integer toInteger(Object val) {
		return toLong(val).intValue();
	}

	/**
	 * 驼峰命名法工具
	 *
	 * @return toCamelCase(" hello_world ") == "helloWorld"
	 * toCapitalizeCamelCase("hello_world") == "HelloWorld" toUnderScoreCase("helloWorld")
	 * = "hello_world"
	 */
	public static String toCamelCase(String s) {
		return toCamelCase(s, SEPARATOR);
	}

	public static String toCamelCase(String s, Character... splits) {
		if (s == null) {
			return null;
		}
		StringBuilder sb = new StringBuilder(s.length());
		boolean upperCase = false;
		List<Character> splitList = Lists.newArrayList(splits);
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (splitList.contains(c)) {
				upperCase = true;
			} else if (upperCase) {
				sb.append(Character.toUpperCase(c));
				upperCase = false;
			} else {
				sb.append(c);
			}
		}

		return sb.toString();
	}

	public static String toRevertCamelCase(String s, Character split) {
		if (s == null) {
			return null;
		}
		StringBuilder sb = new StringBuilder(s.length());
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (Character.isUpperCase(c)) {
				sb.append(split).append(Character.toLowerCase(c));
			} else {
				sb.append(c);
			}
		}

		return sb.toString();
	}

	/**
	 * 驼峰命名法工具
	 *
	 * @return toCamelCase(" hello_world ") == "helloWorld"
	 * toCapitalizeCamelCase("hello_world") == "HelloWorld" toUnderScoreCase("helloWorld")
	 * = "hello_world"
	 */
	public static String toCapitalizeCamelCase(String s) {
		if (s == null) {
			return null;
		}
		s = toCamelCase(s);
		return s.substring(0, 1).toUpperCase() + s.substring(1);
	}

	/**
	 * 驼峰命名法工具
	 *
	 * @return toCamelCase(" hello_world ") == "helloWorld"
	 * toCapitalizeCamelCase("hello_world") == "HelloWorld" toUnderScoreCase("helloWorld")
	 * = "hello_world"
	 */
	public static String toUnderScoreCase(String s) {
		if (s == null) {
			return null;
		}
		StringBuilder sb = new StringBuilder();
		boolean upperCase = false;
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);

			boolean nextUpperCase = true;

			if (i < (s.length() - 1)) {
				nextUpperCase = Character.isUpperCase(s.charAt(i + 1));
			}

			if ((i > 0) && Character.isUpperCase(c)) {
				if (!upperCase || !nextUpperCase) {
					sb.append(SEPARATOR);
				}
				upperCase = true;
			} else {
				upperCase = false;
			}

			sb.append(Character.toLowerCase(c));
		}

		return sb.toString();
	}

	/**
	 * 获取工程路径
	 *
	 * @return
	 */
	public static String getProjectPath(String fileName, String relativeUiPath) {
		String projectPath = "";
		try {
			File file = new DefaultResourceLoader().getResource("").getFile();
			if (file != null) {
				while (true) {
					File f = new File(file.getPath() + File.separator + "src" + File.separator + "main");
					if (f == null || f.exists()) {
						break;
					}
					if (file.getParentFile() != null) {
						file = file.getParentFile();
					} else {
						break;
					}
				}
				if (!fileName.endsWith(DOT_JAVA) && isNotEmpty(relativeUiPath)) {
					File fileTemp = new File(file.getPath() + File.separator + relativeUiPath);
					if (fileTemp == null || fileTemp.exists()) {
						file = fileTemp;
					}
				}

				projectPath = file.toString();
			}
		} catch (IOException e) {
			log.error("failed init", e);
		}
		return projectPath;
	}

	/**
	 * 转换为JS获取对象值，生成三目运算返回结果
	 *
	 * @param objectString 对象串 例如：row.user.id
	 *                     返回：!row?'':!row.user?'':!row.user.id?'':row.user.id
	 */
	public static String jsGetVal(String objectString) {
		StringBuilder result = new StringBuilder();
		StringBuilder val = new StringBuilder();
		List<String> vals = split(objectString, StrPool.DOT);
		for (int i = 0; i < vals.size(); i++) {
			val.append(StrPool.DOT + vals.get(i));
			result.append("!" + (val.substring(1)) + "?'':");
		}
		result.append(val.substring(1));
		return result.toString();
	}

	/**
	 * @param string
	 * @param separate
	 * @return
	 * @description 按指定分隔符解析字符串
	 * @date 2008-4-15
	 * @author cy
	 */
	public static List<String> parseStringTokenizer(String string, String separate) {
		List<String> list = new ArrayList<String>();
		StringTokenizer objTokenizer = new StringTokenizer(string, separate);
		while (objTokenizer.hasMoreTokens()) {
			list.add(objTokenizer.nextToken().trim());
		}
		return list;
	}

	/**
	 * 拼接字符串
	 *
	 * @return
	 */
	public static String toAppendStr(Object... strings) {
		StringBuffer sb = new StringBuffer();
		for (Object str : strings) {
			if (str != null) {
				sb.append(str);
			}
		}
		return sb.toString();
	}

	public static String toStrString(Object obj) {
		if (ObjectUtil.isNotEmpty(obj)) {
			return String.valueOf(obj);
		}
		return "";
	}

	public static String toStrStringNull(Object obj) {
		if (ObjectUtil.isNotEmpty(obj)) {
			return String.valueOf(obj);
		}
		return null;
	}

	/**
	 * 子字符串modelStr在字符串str中第count次出现时的下标
	 *
	 * @param str
	 * @param modelStr
	 * @param count
	 * @return
	 */
	public static int getFromIndex(String str, String modelStr, Integer count) {
		// 对子字符串进行匹配
		Matcher slashMatcher = Pattern.compile(modelStr).matcher(str);
		int index = 0;
		// matcher.find();尝试查找与该模式匹配的输入序列的下一个子序列
		while (slashMatcher.find()) {
			index++;
			// 当modelStr字符第count次出现的位置
			if (index == count) {
				break;
			}
		}
		// matcher.start();返回以前匹配的初始索引。
		return slashMatcher.start();
	}

	public static String lowerCase(final String str) {
		if (str == null) {
			return null;
		}
		return str.toLowerCase();
	}

	public static String getBlock(Object msg) {
		if (msg == null) {
			msg = "";
		}
		return "[" + msg + "]";
	}

	/**
	 * mybatis plus like查询转换
	 */
	public static String keywordConvert(String value) {
		if (StrUtil.isBlank(value)) {
			return StrPool.EMPTY;
		}
		value = value.replaceAll(StrPool.PERCENT, "\\\\%");
		value = value.replaceAll(StrPool.UNDERSCORE, "\\\\_");
		return value;
	}

	public static Object keywordConvert(Object value) {
		if (value instanceof String) {
			return keywordConvert(String.valueOf(value));
		}
		return value;
	}


	/**
	 * 拼接like条件
	 *
	 * @param value   值
	 * @param sqlType 拼接类型
	 * @return 拼接后的值
	 */
	public static String like(Object value, SqlLike sqlType) {
		return SqlUtils.concatLike(keywordConvert(String.valueOf(value)), sqlType);
	}

}
