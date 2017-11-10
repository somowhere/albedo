package com.albedo.java.modules.gen.util;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.modules.gen.domain.GenTemplate;
import com.albedo.java.modules.gen.domain.xml.GenCategory;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.util.DateUtil;
import com.albedo.java.util.FileUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.FreeMarkers;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.mapper.JaxbMapper;
import com.albedo.java.vo.gen.GenSchemeVo;
import com.albedo.java.vo.gen.GenTableColumnVo;
import com.albedo.java.vo.gen.GenTableVo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.io.Charsets;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
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

    /**
     * 初始化列属性字段
     *
     * @param genTableVo
     */
    public static void initColumnField(GenTableVo genTableVo) {
        for (GenTableColumnVo column : genTableVo.getColumnList()) {

            // 如果是不是新增列，则跳过。
            if (StringUtil.isNotBlank(column.getId())) {
                continue;
            }

            // 设置字段说明
            if (StringUtil.isBlank(column.getComments())) {
                column.setComments(column.getName());
            }

            // 设置java类型
            if (StringUtil.startsWithIgnoreCase(column.getJdbcType(), "CHAR") || StringUtil.startsWithIgnoreCase(column.getJdbcType(), "VARCHAR") || StringUtil.startsWithIgnoreCase(column.getJdbcType(), "NARCHAR")) {
                column.setJavaType(SystemConfig.TYPE_STRING);
            } else if (StringUtil.startsWithIgnoreCase(column.getJdbcType(), "DATETIME") || StringUtil.startsWithIgnoreCase(column.getJdbcType(), "DATE") || StringUtil.startsWithIgnoreCase(column.getJdbcType(), "TIMESTAMP")) {
                column.setJavaType(Date.class.getName());
                column.setShowType("dateselect");
            } else if (StringUtil.startsWithIgnoreCase(column.getJdbcType(), "BIT")) {
                column.setJavaType(Boolean.class.getName());
            } else if (StringUtil.startsWithIgnoreCase(column.getJdbcType(), "INT") ||
                    StringUtil.startsWithIgnoreCase(column.getJdbcType(), "TINYINT") ||
                    StringUtil.startsWithIgnoreCase(column.getJdbcType(), "BIGINT")
                    || StringUtil.startsWithIgnoreCase(column.getJdbcType(), "NUMBER") ||
                    StringUtil.startsWithIgnoreCase(column.getJdbcType(), "DECIMAL")) {
                // 如果是浮点型
                String[] ss = StringUtil.split(StringUtil.substringBetween(column.getJdbcType(), "(", ")"), ",");
                if (ss != null && ss.length == 2 && Integer.parseInt(ss[1]) > 0) {
                    column.setJavaType(BigDecimal.class.getName());
                }
                // 如果是整形
                else if (ss != null && ss.length == 1 && Integer.parseInt(ss[0]) <= 10) {
                    column.setJavaType(SystemConfig.TYPE_INTEGER);
                }
                // 长整形
                else {
                    column.setJavaType(SystemConfig.TYPE_LONG);
                }
            }

            // 设置java字段名
            column.setJavaField(StringUtil.toCamelCase(column.getName()));

            // 是否是主键
            column.setIsPk(genTableVo.getPkList().contains(column.getName()) ? SystemConfig.YES : SystemConfig.NO);

            // 插入字段
            column.setIsInsert(SystemConfig.YES);


            if (column.getIsNotBaseField()) {
                column.setIsList(SystemConfig.YES);// 列表字段
                column.setIsEdit(SystemConfig.YES);// 编辑字段
            }

            if (StringUtil.equalsIgnoreCase(column.getJavaField(), DataEntity.F_DESCRIPTION)) {
                column.setIsEdit(SystemConfig.YES);
            }
            // 查询字段
            if (StringUtil.equalsIgnoreCase(column.getJavaField(), TreeEntity.F_NAME) || StringUtil.equalsIgnoreCase(column.getJavaField(), "title")) {
                column.setIsQuery(SystemConfig.YES);
                column.setQueryType("like");
            }
            if (StringUtil.startsWithIgnoreCase(column.getName(), "is_") || StringUtil.startsWithIgnoreCase(column.getName(), "has_")) {
                column.setDictType("sys_yes_no");
                column.setShowType("radiobox");
            }
            // 用户
            if (StringUtil.startsWithIgnoreCase(column.getName(), "user_id")) {
                column.setJavaType(User.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setComments("用户");
                column.setShowType("userselect");
            }
            // 部门
            else if (StringUtil.startsWithIgnoreCase(column.getName(), "org_id")) {
                column.setJavaType(Org.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setComments("机构");
                column.setShowType("orgselect");
            }
            // 区域
            else if (StringUtil.startsWithIgnoreCase(column.getName(), "area_id")) {
                column.setJavaType(Area.class.getName());
                column.setJavaField(column.getJavaField().replaceAll("Id", ".id|name"));
                column.setComments("区域");
                column.setShowType("areaselect");
            }
            // 创建者、更新者
            else if (StringUtil.startsWithIgnoreCase(column.getName(), DataEntity.F_CREATEDBY) || StringUtil.startsWithIgnoreCase(column.getName(), DataEntity.F_LASTMODIFIEDBY)) {
                column.setJavaType(User.class.getName());
                column.setJavaField(column.getJavaField());
            }
            // 创建时间、更新时间
            else if (StringUtil.startsWithIgnoreCase(column.getName(), DataEntity.F_CREATEDDATE) || StringUtil.startsWithIgnoreCase(column.getName(), DataEntity.F_LASTMODIFIEDDATE)) {
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
                column.setComments("父节点");
            }
            // 所有父级ID
            else if (StringUtil.equalsIgnoreCase(column.getName(), TreeEntity.F_PARENTIDS)) {
                column.setQueryType("like");
                // 列表字段
                column.setIsList(SystemConfig.NO);
                column.setComments("所有父级");
            }
            // 删除标记
            else if (StringUtil.equalsIgnoreCase(column.getJavaField(), DataEntity.F_STATUS)) {
                column.setShowType("radiobox");
                column.setDictType("sys_status");

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
//				return PublicUtil.toAppendStr(file.getAbsolutePath(), File.separator, "codet", File.separator);
//			}
            return PublicUtil.toAppendStr("classpath*:/codet/");
        } catch (Exception e) {
            logger.error("{}", e);
        }

        return "";
        // String path = StringUtil.getProjectPath() + StringUtil.replaceEach(".src.main.java." + GenTableColumnVoUtil.class.getName(), new String[] { "util." + GenTableColumnVoUtil.class.getSimpleName(), "." }, new String[] { "template", File.separator });
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
     * @param childTable 是否是子表
     * @return
     */
    public static List<GenTemplate> getTemplateList(GenConfig config, String category, boolean childTable) {
        List<GenTemplate> templateList = Lists.newArrayList();
        if (config != null && config.getCategoryList() != null && category != null) {
            for (GenCategory e : config.getCategoryList()) {
                if (category.equals(e.getVal())) {
                    List<String> list = null;
                    if (!childTable) {
                        list = e.getTemplate();
                    } else {
                        list = e.getChildTableTemplate();
                    }
                    if (list != null) {
                        for (String s : list) {
                            if (StringUtil.startsWith(s, GenCategory.CATEGORY_REF)) {
                                templateList.addAll(getTemplateList(config, StringUtil.replace(s, GenCategory.CATEGORY_REF, ""), false));
                            } else {
                                GenTemplate template = fileToObject(s, GenTemplate.class);
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
     * @param genSchemeVo
     * @return
     */
    public static Map<String, Object> getDataModel(GenSchemeVo genSchemeVo) {
        Map<String, Object> model = Maps.newHashMap();

        model.put("packageName", StringUtil.lowerCase(genSchemeVo.getPackageName()));
        model.put("lastPackageName", StringUtil.substringAfterLast((String) model.get("packageName"), "."));
        model.put("moduleName", StringUtil.lowerCase(genSchemeVo.getModuleName()));
        model.put("subModuleName", StringUtil.lowerCase(genSchemeVo.getSubModuleName()));
        model.put("className", StringUtil.uncapitalize(genSchemeVo.getGenTable().getClassName()));
        model.put("ClassName", StringUtil.capitalize(genSchemeVo.getGenTable().getClassName()));

        model.put("functionName", genSchemeVo.getFunctionName());
        model.put("functionNameSimple", genSchemeVo.getFunctionNameSimple());
        model.put("functionAuthor", StringUtil.isNotBlank(genSchemeVo.getFunctionAuthor()) ? genSchemeVo.getFunctionAuthor() : "");
        model.put("functionVersion", DateUtil.getDate());

        model.put("urlPrefix", model.get("moduleName") + (StringUtil.isNotBlank(genSchemeVo.getSubModuleName()) ? "/" + StringUtil.lowerCase(genSchemeVo.getSubModuleName()) : "") + "/" + model.get("className"));
        model.put("viewPrefix", // StringUtil.substringAfterLast(model.get("packageName"),".")+"/"+
                model.get("urlPrefix"));
        model.put("permissionPrefix", model.get("moduleName") + (StringUtil.isNotBlank(genSchemeVo.getSubModuleName()) ? "_" + StringUtil.lowerCase(genSchemeVo.getSubModuleName()) : "") + "_" + model.get("className"));

        model.put("dbType", SystemConfig.get("jdbc.type"));

        model.put("table", genSchemeVo.getGenTable());
        model.put("scheme", genSchemeVo);
        return model;
    }

    /**
     * 生成到文件
     *
     * @param tpl
     * @param model
     * @param replaceFile
     * @return
     */
    public static String generateToFile(GenTemplate tpl, Map<String, Object> model, boolean replaceFile) {
        // 获取生成文件 "c:\\temp\\"//
        String fileName = StringUtil.getProjectPath() + File.separator
                + StringUtil.replaceEach(FreeMarkers.renderString(tpl.getFilePath() + "/", model), new String[]{"//", "/", "."}, new String[]{File.separator, File.separator, File.separator})
                + FreeMarkers.renderString(tpl.getFileName(), model);

        logger.debug(" fileName === " + fileName);
        if ("entityId".equals(tpl.getName())) {
            GenTableVo table = (GenTableVo) model.get("table");
            if (table.isNotCompositeId()) {
                return "因不满足联合主键条件已忽略" + fileName + "<br/>";
            }
        }
        logger.debug(tpl.getContent());
        // 获取生成文件内容
        String content = FreeMarkers.renderString(StringUtil.trimToEmpty(tpl.getContent()), model);
        logger.debug(" content === \r\n" + content);

        // 如果选择替换文件，则删除原文件
        if (replaceFile) {
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
