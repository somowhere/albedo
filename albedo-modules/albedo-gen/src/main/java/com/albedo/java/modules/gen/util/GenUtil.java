/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.gen.util;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.CharUtil;
import cn.hutool.core.util.CharsetUtil;
import com.albedo.java.common.core.domain.BaseDataDo;
import com.albedo.java.common.core.domain.TreeDo;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.vo.TemplateVo;
import com.albedo.java.modules.gen.domain.xml.GenCategory;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.sys.domain.UserDo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 代码生成工具类
 *
 * @author somewhere
 * @version 2013-11-16
 */
public class GenUtil {

	private static Logger logger = LoggerFactory.getLogger(GenUtil.class);

	private static void initTreeColumn(TableColumnDto column) {
		boolean isTitle = StringUtil.equalsIgnoreCase(column.getJavaFieldName(), "title");
		if (StringUtil.equalsIgnoreCase(column.getJavaFieldName(), TreeDo.F_NAME) || isTitle) {
			column.setQueryField(true);
			column.setQueryType("like");
		} // 父级ID
		else if (StringUtil.equalsIgnoreCase(column.getName(), TreeDo.F_PARENT_ID)) {
			column.setShowType("treeselect");
			column.setNullField(false);
			column.setTitle("父节点");
		}
		// 所有父级ID
		else if (StringUtil.equalsIgnoreCase(column.getName(), TreeDo.F_PARENT_IDS)) {
			column.setQueryType("like");
			column.setListField(false);
			column.setNullField(false);
			column.setTitle("所有父级");
		}
		// 所有父级ID
		else if (StringUtil.equalsIgnoreCase(column.getName(), TreeDo.F_LEAF)) {
			column.setQueryType("eq");
			column.setListField(false);
			column.setEditField(false);
			column.setNullField(false);
			column.setTitle("叶子节点");
		} else if (StringUtil.equalsIgnoreCase(column.getName(), TreeDo.F_SQL_SORT)) {
			column.setListField(true);
			column.setEditField(true);
			column.setNullField(false);
			column.setTitle("排序");
			column.setJavaType(CommonConstants.TYPE_INTEGER);
		}
	}

	private static void initDataColumn(TableColumnDto column) {
		boolean content = StringUtil.equalsIgnoreCase(column.getJavaFieldName(), "content");
		boolean remark = StringUtil.equalsIgnoreCase(column.getJavaFieldName(), "remark");
		if (StringUtil.equalsIgnoreCase(column.getJavaFieldName(), BaseDataDo.F_DESCRIPTION)) {
			column.setEditField(true);
			column.setTitle("备注");
		}
		// 创建者、更新者
		else if (StringUtil.startWithIgnoreCase(column.getName(), BaseDataDo.F_CREATED_BY)
			|| StringUtil.startWithIgnoreCase(column.getName(), BaseDataDo.F_LAST_MODIFIED_BY)) {
			column.setJavaType(UserDo.class.getName());
			column.setJavaFieldName(column.getJavaFieldName());
			column.setNullField(false);
		}
		// 创建时间、更新时间
		else if (StringUtil.startWithIgnoreCase(column.getName(), BaseDataDo.F_CREATED_DATE)
			|| StringUtil.startWithIgnoreCase(column.getName(), BaseDataDo.F_LAST_MODIFIED_DATE)) {
			column.setShowType("dateselect");
			column.setNullField(false);
		}
		// 备注、内容
		else if (StringUtil.equalsIgnoreCase(column.getJavaFieldName(), BaseDataDo.F_DESCRIPTION) || content
			|| remark) {
			column.setShowType("textarea");
		}
		// 删除标记
		else if (StringUtil.equalsIgnoreCase(column.getJavaFieldName(), BaseDataDo.F_DEL_FLAG)) {
			column.setShowType("radio");
			column.setDictType(DictNameConstants.SYS_FLAG);
			column.setNullField(false);
		}
	}

	/**
	 * 初始化列属性字段
	 *
	 * @param table
	 */
	public static void initColumnField(TableDto table) {
		for (TableColumnDto column : table.getColumnList()) {
			// 如果是不是新增列，则跳过。
			if (StringUtil.isNotBlank(column.getId())) {
				continue;
			}
			// 设置字段说明
			if (StringUtil.isBlank(column.getTitle())) {
				column.setTitle(column.getName());
			}
			// 设置java类型
			if (StringUtil.startWithIgnoreCase(column.getJdbcType(), "CHAR")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "VARCHAR")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "NARCHAR")) {
				column.setJavaType(CommonConstants.TYPE_STRING);
			} else if (StringUtil.startWithIgnoreCase(column.getJdbcType(), "DATETIME")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "DATE")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "TIMESTAMP")) {
				column.setJavaType("java.util.Date");
				column.setShowType("dateselect");
			} else if (StringUtil.startWithIgnoreCase(column.getJdbcType(), "INT")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "TINYINT")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "BIGINT")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "NUMBER")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "DECIMAL")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "BIT")
				|| StringUtil.startWithIgnoreCase(column.getJdbcType(), "DOUBLE")) {
				// 如果是浮点型
				List<String> ss = CharSequenceUtil.split(
					StringUtil.subBetween(column.getJdbcType(), StringUtil.BRACKETS_START, StringUtil.BRACKETS_END),
					StringUtil.SPLIT_DEFAULT);
				if (ss != null && ss.size() == 2 && Integer.parseInt(ss.get(1)) > 0) {
					column.setJavaType(CommonConstants.TYPE_DOUBLE);
				}
				// 如果是整形
				else if (ss != null && ss.size() == 1 && Integer.parseInt(ss.get(0)) <= 10) {
					column.setJavaType(CommonConstants.TYPE_INTEGER);
				}
				// 长整形
				else {
					column.setJavaType(CommonConstants.TYPE_LONG);
				}
			}
			// 设置java字段名
			column.setJavaFieldName(StringUtil.toCamelCase(column.getName()));
			// 是否是主键
			column.setPk(table.getPkList().contains(column.getName()));
			// 插入字段
			column.setInsertField(true);
			if (column.getIsNotBaseField()) {
				column.setListField(true);
				column.setEditField(true);
			}
			// 查询字段
			if (StringUtil.isEmpty(column.getShowType())) {
				column.setShowType("input");
			}
			if (StringUtil.isEmpty(column.getQueryType())) {
				column.setQueryType("eq");
			}
			if (StringUtil.isEmpty(column.getJavaType())) {
				column.setJavaType("String");
			}
			initDataColumn(column);
			initTreeColumn(column);
			if (StringUtil.equalsIgnoreCase(column.getName(), TreeDo.F_TENANT_CODE)) {
				column.setListField(false);
				column.setEditField(false);
				column.setNullField(false);
			}
		}
	}

	/**
	 * 获取模板路径
	 *
	 * @return
	 */
	public static String getTemplatePath() {
		try {
			return StringUtil.toAppendStr("classpath*:/templates/codet/");
		} catch (Exception e) {
			logger.error("{}", e);
		}

		return "";
	}

	/**
	 * XML文件转换为对象
	 *
	 * @param fileName
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T fileToObject(String fileName, Class<?> clazz) {
		String pathName = getTemplatePath() + fileName;
		logger.debug("file to object: {} ", pathName);

		PathMatchingResourcePatternResolver resourceLoader = new PathMatchingResourcePatternResolver();
		String content = null;
		try {
			content = IoUtil.read(resourceLoader.getResources(pathName)[0].getInputStream(), CharsetUtil.CHARSET_UTF_8);
			return (T) JaxbMapper.fromXml(content, clazz);
		} catch (IOException e) {
			logger.warn("error convert: {}", e.getMessage());
		}
		return null;
	}

	/**
	 * 获取代码生成配置对象
	 *
	 * @return
	 */
	public static GenConfig getConfig() {
		return fileToObject("config.xml", GenConfig.class);
	}

	/**
	 * 根据分类获取模板列表
	 *
	 * @param config
	 * @param category
	 * @param isChildTable 是否是子表
	 * @return
	 */
	public static List<TemplateVo> getTemplateList(GenConfig config, String category, boolean isChildTable) {
		List<TemplateVo> templateList = Lists.newArrayList();
		if (config != null && config.getCategoryList() != null && category != null) {
			for (GenCategory e : config.getCategoryList()) {
				if (category.equals(e.getVal())) {
					List<String> list = null;
					if (!isChildTable) {
						list = e.getTemplate();
					} else {
						list = e.getChildTableTemplate();
					}
					if (list != null) {
						for (String s : list) {
							if (StringUtil.startWith(s, GenCategory.CATEGORY_REF)) {
								templateList.addAll(getTemplateList(config,
									StringUtil.replace(s, GenCategory.CATEGORY_REF, ""), false));
							} else {
								TemplateVo template = fileToObject(s, TemplateVo.class);
								if (template != null) {
									templateList.add(template);
								}
							}
						}
					}
					break;
				}
			}
		}
		return templateList;
	}

	/**
	 * 获取数据模型
	 *
	 * @param scheme
	 * @return
	 */
	public static Map<String, Object> getDataModel(SchemeDto scheme) {
		Map<String, Object> model = Maps.newHashMap();
		String applicationName = SpringContextHolder.getApplicationContext()
			.getBeansWithAnnotation(SpringBootApplication.class).keySet().iterator().next();
		model.put("applicationName",
			SpringContextHolder.getApplicationContext().getBean(applicationName).getClass().getPackage().getName()
				+ StrPool.DOT + StringUtil.upperFirst(applicationName));
		model.put("packageName", StringUtil.lowerCase(scheme.getPackageName()));
		model.put("lastPackageName", StringUtil.subAfter((String) model.get("packageName"), StrPool.DOT, true));
		model.put("moduleName", StringUtil.lowerCase(scheme.getModuleName()));
		model.put("subModuleName",
			StringUtil.lowerCase(StringUtil.isEmpty(scheme.getSubModuleName()) ? "" : scheme.getSubModuleName()));
		model.put("className", StringUtil.lowerFirst(scheme.getTableDto().getClassName()));
		model.put("classNameUrl",
			StringUtil.toRevertCamelCase(StringUtil.toStrString(model.get("className")), CharUtil.DASHED));
		model.put("ClassName", StringUtil.upperFirst(scheme.getTableDto().getClassName()));

		model.put("functionName", scheme.getFunctionName());
		model.put("functionNameSimple", scheme.getFunctionNameSimple());
		model.put("functionAuthor",
			StringUtil.isNotBlank(scheme.getFunctionAuthor()) ? scheme.getFunctionAuthor() : "");
		model.put("functionVersion", DateUtil.now());
		model.put("urlPrefix",
			model.get("moduleName")
				+ (StringUtil.isNotBlank(scheme.getSubModuleName())
				? StringUtil.SLASH + StringUtil.lowerCase(scheme.getSubModuleName()) : "")
				+ StringUtil.SLASH + model.get("classNameUrl"));
		model.put("viewPrefix", model.get("urlPrefix"));
		model.put("permissionPrefix",
			model.get("moduleName")
				+ (StringUtil.isNotBlank(scheme.getSubModuleName())
				? "_" + StringUtil.lowerCase(scheme.getSubModuleName()) : "")
				+ "_" + model.get("className"));
		model.put("table", scheme.getTableDto());
		model.put("scheme", scheme);
		return model;
	}

	/**
	 * 生成到文件
	 *
	 * @param tpl
	 * @param model
	 * @param isReplaceFile
	 * @return
	 */
	public static String generateToFile(TemplateVo tpl, Map<String, Object> model, boolean isReplaceFile) {
		// 获取生成文件 "c:\\temp\\"//
		String realFileName = FreeMarkers.renderString(tpl.getFileName(), model),
			fileName = StringUtil.getProjectPath(realFileName, getConfig().getCodeUiPath()) + File.separator
				+ FreeMarkers.renderString(tpl.getFilePath() + StringUtil.SLASH, model).replaceAll("//|/|\\.",
				"\\" + File.separator)
				+ realFileName;

		logger.debug(" fileName === " + fileName);
		boolean entityId = "entityId".equals(tpl.getName());
		if (entityId) {
			TableDto table = (TableDto) model.get("table");
			if (table.isNotCompositeId()) {
				return "因不满足联合主键条件已忽略" + fileName + "<br/>";
			}
		}

		// 获取生成文件内容
		String content = FreeMarkers.renderString(StringUtil.trimToEmpty(tpl.getContent()), model);
		logger.debug(" content === \r\n" + content);

		// 如果选择替换文件，则删除原文件
		if (isReplaceFile) {
			FileUtil.deleteFile(fileName);
		}

		// 创建并写入文件
		if (FileUtil.createFile(fileName)) {
			FileUtil.writeString(content, fileName, CharsetUtil.UTF_8);
			logger.debug(" file create === " + fileName);
			return "生成成功：" + fileName + "<br/>";
		} else {
			logger.debug(" file extents === " + fileName);
			return "文件已存在：" + fileName + "<br/>";
		}
	}

	// public static void main(String[] args) {
	// try {
	// GenConfig config = getConfig();
	// System.out.println(config);
	// System.out.println(JaxbMapper.toXml(config));
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

}
