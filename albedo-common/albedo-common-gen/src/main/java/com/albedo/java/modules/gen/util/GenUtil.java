package com.albedo.java.modules.gen.util;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.modules.gen.domain.vo.SchemeDataVo;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.domain.vo.TemplateVo;
import com.albedo.java.modules.gen.domain.xml.GenCategory;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.User;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.io.Charsets;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
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
 * @version 2013-11-16
 */
public class GenUtil {

	private static Logger logger = LoggerFactory.getLogger(GenUtil.class);

	/**
	 * 初始化列属性字段
	 *
	 * @param table
	 */
	public static void initColumnField(TableDataVo table) {
		for (TableColumnVo column : table.getColumnList()) {

			// 如果是不是新增列，则跳过。
			if (StringUtil.isNotBlank(column.getId())) {
				continue;
			}

			// 设置字段说明
			if (StringUtil.isBlank(column.getTitle())) {
				column.setTitle(column.getName());
			}

			// 设置java类型
			if (StringUtil.startWithIgnoreCase(column.getJdbcType(), "CHAR") || StringUtil.startWithIgnoreCase(column.getJdbcType(), "VARCHAR") || StringUtil.startWithIgnoreCase(column.getJdbcType(), "NARCHAR")) {
				column.setJavaType(CommonConstants.TYPE_STRING);
			} else if (StringUtil.startWithIgnoreCase(column.getJdbcType(), "DATETIME") || StringUtil.startWithIgnoreCase(column.getJdbcType(), "DATE") || StringUtil.startWithIgnoreCase(column.getJdbcType(), "TIMESTAMP")) {
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
				String[] ss = StringUtil.split(StringUtil.subBetween(column.getJdbcType(), "(", ")"), ",");
				if (ss != null && ss.length == 2 && Integer.parseInt(ss[1]) > 0) {
					column.setJavaType(CommonConstants.TYPE_DOUBLE);
				}
				// 如果是整形
				else if (ss != null && ss.length == 1 && Integer.parseInt(ss[0]) <= 10) {
					column.setJavaType(CommonConstants.TYPE_INTEGER);
				}
				// 长整形
				else {
					column.setJavaType(CommonConstants.TYPE_LONG);
				}
			}

			// 设置java字段名
			column.setJavaField(StringUtil.toCamelCase(column.getName()));

			// 是否是主键
			column.setPk(table.getPkList().contains(column.getName()));

			// 插入字段
			column.setInsert(true);


			if (column.getIsNotBaseField()) {
				column.setList(true);// 列表字段
				column.setEdit(true);// 编辑字段
			}

			if (StringUtil.equalsIgnoreCase(column.getJavaField(), DataEntity.F_DESCRIPTION)) {
				column.setEdit(true);
				column.setTitle("备注");
			}
			// 查询字段
			if (StringUtil.equalsIgnoreCase(column.getJavaField(), TreeEntity.F_NAME) || StringUtil.equalsIgnoreCase(column.getJavaField(), "title")) {
				column.setQuery(true);
				column.setQueryType("like");
			}
			if (StringUtil.startWithIgnoreCase(column.getName(), "is_") || StringUtil.startWithIgnoreCase(column.getName(), "has_")) {
				column.setDictType("sys_flag");
				column.setShowType("radio");
			}
			// 用户
			if (StringUtil.startWithIgnoreCase(column.getName(), "user_id")) {
				column.setJavaType(User.class.getName());
				column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
				column.setTitle("用户");
				column.setShowType("userselect");
			}
			// 部门
			else if (StringUtil.startWithIgnoreCase(column.getName(), "dept_id")) {
				column.setJavaType(Dept.class.getName());
				column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
				column.setTitle("机构");
				column.setShowType("orgselect");
			}
//            // 区域
//            else if (StringUtil.startWithIgnoreCase(column.getName(), "area_id")) {
//                column.setJavaType(Area.class.getName());
//                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
//                column.setTitle("区域");
//                column.setShowType("areaselect");
//            }
			// 创建者、更新者
			else if (StringUtil.startWithIgnoreCase(column.getName(), DataEntity.F_CREATEDBY) || StringUtil.startWithIgnoreCase(column.getName(), DataEntity.F_LASTMODIFIEDBY)) {
				column.setJavaType(User.class.getName());
				column.setJavaField(column.getJavaField());
			}
			// 创建时间、更新时间
			else if (StringUtil.startWithIgnoreCase(column.getName(), DataEntity.F_CREATEDDATE) || StringUtil.startWithIgnoreCase(column.getName(), DataEntity.F_LASTMODIFIEDDATE)) {
				column.setShowType("dateselect");
			}
			// 备注、内容
			else if (StringUtil.equalsIgnoreCase(column.getJavaField(), DataEntity.F_DESCRIPTION) || StringUtil.equalsIgnoreCase(column.getJavaField(), "content") || StringUtil.equalsIgnoreCase(column.getJavaField(), "remark")) {
				column.setShowType("textarea");
			}
			// 父级ID
			else if (StringUtil.equalsIgnoreCase(column.getName(), TreeEntity.F_PARENTID)) {
				column.setJavaType("This");
				column.setJavaField("parent.id|name");
				column.setShowType("treeselect");
				column.setTitle("父节点");
			}
			// 所有父级ID
			else if (StringUtil.equalsIgnoreCase(column.getName(), TreeEntity.F_PARENTIDS)) {
				column.setQueryType("like");
				column.setList(false);// 列表字段
				column.setTitle("所有父级");
			}
			// 删除标记
			else if (StringUtil.equalsIgnoreCase(column.getJavaField(), DataEntity.F_DELFLAG)) {
				column.setShowType("radio");
				column.setDictType("sys_flag");
			}

			if (StringUtil.isEmpty(column.getShowType())) {
				column.setShowType("input");
			}
			if (StringUtil.isEmpty(column.getQueryType())) {
				column.setQueryType("eq");
			}
			if (StringUtil.isEmpty(column.getJavaType())) {
				column.setJavaType("String");
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

//			File file = new DefaultResourceLoader().getResource("").getFile();
//			if (file != null) {
//				return StringUtil.toAppendStr(file.getAbsolutePath(), File.separator, "codet", File.separator);
//			}
			return StringUtil.toAppendStr("classpath*:/codet/");
		} catch (Exception e) {
			logger.error("{}", e);
		}

		return "";
		// String path = StringUtil.getProjectPath() + StringUtil.replaceEach(".src.main.java." + GenUtil.class.getName(), new String[] { "util." + GenUtil.class.getSimpleName(), "." }, new String[] { "template", File.separator });
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

		String content = "";
		try {
			content = IOUtils.toString(resourceLoader.getResources(pathName)[0].getInputStream(), Charsets.toCharset("utf-8"));
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
								templateList.addAll(getTemplateList(config, StringUtil.replace(s, GenCategory.CATEGORY_REF, ""), false));
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
	public static Map<String, Object> getDataModel(SchemeDataVo scheme) {
		Map<String, Object> model = Maps.newHashMap();
		String applicationName = SpringContextHolder.getApplicationContext().getBeansWithAnnotation(SpringBootApplication.class).keySet().iterator().next();
		model.put("applicationName", SpringContextHolder.getApplicationContext().getBean(applicationName).getClass().getPackage().getName() + "." + StringUtil.upperFirst(applicationName));
		model.put("packageName", StringUtil.lowerCase(scheme.getPackageName()));
		model.put("lastPackageName", StringUtil.subAfter((String) model.get("packageName"), ".", true));
		model.put("moduleName", StringUtil.lowerCase(scheme.getModuleName()));
		model.put("subModuleName", StringUtil.lowerCase(StringUtil.isEmpty(scheme.getSubModuleName()) ? "" : scheme.getSubModuleName()));
		model.put("className", StringUtil.lowerFirst(scheme.getTableDataVo().getClassName()));
		model.put("classNameUrl", StringUtil.toRevertCamelCase(StringUtil.toStrString(model.get("className")), CharUtil.DASHED));
		model.put("ClassName", StringUtil.upperFirst(scheme.getTableDataVo().getClassName()));

		model.put("functionName", scheme.getFunctionName());
		model.put("functionNameSimple", scheme.getFunctionNameSimple());
		model.put("functionAuthor", StringUtil.isNotBlank(scheme.getFunctionAuthor()) ? scheme.getFunctionAuthor() : "");
		model.put("functionVersion", DateUtil.now());
		model.put("urlPrefix", model.get("moduleName") + (StringUtil.isNotBlank(scheme.getSubModuleName()) ? "/" +
			StringUtil.lowerCase(scheme.getSubModuleName()) : "") + "/" + model.get("classNameUrl")
		);
		model.put("viewPrefix", // StringUtil.substringAfterLast(model.get("packageName"),".")+"/"+
			model.get("urlPrefix"));
		model.put("permissionPrefix", model.get("moduleName") + (StringUtil.isNotBlank(scheme.getSubModuleName()) ? "_" + StringUtil.lowerCase(scheme.getSubModuleName()) : "") + "_" + model.get("className"));
		model.put("table", scheme.getTableDataVo());
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
				+ StringUtils.replaceEach(FreeMarkers.renderString(tpl.getFilePath() + "/", model), new String[]{"//", "/", "."}, new String[]{File.separator, File.separator, File.separator})
				+ realFileName;

		logger.debug(" fileName === " + fileName);
		if ("entityId".equals(tpl.getName())) {
			TableDataVo table = (TableDataVo) model.get("table");
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
			FileUtil.writeToFile(fileName, content, true);
			logger.debug(" file create === " + fileName);
			return "生成成功：" + fileName + "<br/>";
		} else {
			logger.debug(" file extents === " + fileName);
			return "文件已存在：" + fileName + "<br/>";
		}
	}

//	public static void main(String[] args) {
//		try {
//			GenConfig config = getConfig();
//			System.out.println(config);
//			System.out.println(JaxbMapper.toXml(config));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

}
