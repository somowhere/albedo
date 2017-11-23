package com.albedo.java.vo.gen;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.base.DataEntityVo;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 业务表Entity
 *
 * @author somewhere
 * @version 2013-10-15
 */
@Data
@ToString
@NoArgsConstructor
public class GenTableVo extends DataEntityVo {

    public static final String F_NAME = "name";
    public static final String F_NAMESANDCOMMENTS = "nameAndComments";
    private static final long serialVersionUID = 1L;
    // 名称
    /*** 编码 */
    private String name;
    /*** 描述 */
    private String comments;
    /*** 实体类名称 */
    private String className;
    /*** 关联父表 */
    private String parentTable;
    /*** 关联父表外键 */
    private String parentTableFk;
    /*** 父表对象 */
    private GenTableVo parent;
    /*** 子表列表 */
    private List<GenTableVo> childList;
    private String nameAndComments;
    /*** 按名称模糊查询 */
    private String nameLike;
    /*** 当前表主键列表 */
    private List<String> pkList;

    private String category;
    /**
     * 当前表主键列表
     */
    private List<GenTableColumnVo> pkColumnList;
    /*** 列 - 列表 */
    private List<GenTableColumnVo> columnList;
    /*** 表单提交列 - 列表 */
    @NotNull
    private List<GenTableColumnVo> columnFormList;
    public GenTableVo(String name, String comments) {
        this.name = name;
        this.comments = comments;
    }
    public List<GenTableColumnVo> getPkColumnList() {
        if (PublicUtil.isEmpty(pkColumnList) && PublicUtil.isNotEmpty(columnList)) {
            if (pkColumnList == null) {
                pkColumnList = Lists.newArrayList();
            }
            for (GenTableColumnVo column : getColumnList()) {
                if (column.getPk()) {
                    pkColumnList.add(column);
                }
            }
        }
        return pkColumnList;
    }

    public void setPkColumnList(List<GenTableColumnVo> pkColumnList) {
        this.pkColumnList = pkColumnList;
    }

    public boolean isCompositeId() {
        if (getPkList() == null) {
            throw new RuntimeMsgException("无法获取表的主键信息");
        }
        return getPkList().size() > 1;
    }

    public boolean isNotCompositeId() {
        return !isCompositeId();
    }

    @SuppressWarnings("unchecked")
    public List<String> getPkList() {
        if (PublicUtil.isEmpty(pkList) && PublicUtil.isNotEmpty(getPkColumnList())) {
            pkList = Collections3.extractToList(getPkColumnList(), "name");
        }
        return pkList;
    }

    public void setPkList(List<String> pkList) {
        this.pkList = pkList;
    }

    public String getNameLike() {
        return nameLike;
    }

    public void setNameLike(String nameLike) {
        this.nameLike = nameLike;
    }

    public List<GenTableColumnVo> getColumnList() {
        if (columnList == null) {
            columnList = Lists.newArrayList();
        }
        return columnList;
    }

    public void setColumnList(List<GenTableColumnVo> columnList) {
        this.columnList = columnList;
    }

    /**
     * 获取列名和说明
     *
     * @return
     */
    public String getNameAndComments() {
        if (PublicUtil.isEmpty(nameAndComments)) {
            nameAndComments = getName() + (comments == null ? "" : "  :  " + comments);
        }
        return nameAndComments;
    }

    public void setNameAndComments(String nameAndComments) {
        this.nameAndComments = nameAndComments;
    }

    public List<GenTableColumnVo> getColumnFormList() {
        return columnFormList;
    }

    public void setColumnFormList(List<GenTableColumnVo> columnFormList) {
        this.columnFormList = columnFormList;
    }

    /**
     * 获取导入依赖包字符串
     *
     * @return
     */
    @JSONField(serialize = false)
    public List<String> getImportList() {
        List<String> importList = Lists.newArrayList("com.albedo.java.util.PublicUtil", "org.apache.commons.lang3.builder.EqualsBuilder", "org.apache.commons.lang3.builder.HashCodeBuilder", "org.springframework.data.mybatis.annotations.*",
                "com.albedo.java.util.annotation.SearchField"); // 引用列表
        if ("treeTable".equalsIgnoreCase(getCategory())) {
            importList.add("com.albedo.java.common.domain.base.TreeEntity");
            // 如果有子表，则需要导入List相关引用
            if (getChildList() != null && getChildList().size() > 0) {
                addNoRepeatList(importList, "java.util.List", "com.google.common.collect.Lists", "org.hibernate.annotations.FetchMode", "org.hibernate.annotations.Fetch",
                        "org.hibernate.annotations.Where");
            }
        } else {
            importList.add("com.albedo.java.common.domain.base.DataEntity");
            initImport(importList);
            // 如果有子表，则需要导入List相关引用
            if (getChildList() != null && getChildList().size() > 0) {
                addNoRepeatList(importList, "java.util.List", "com.google.common.collect.Lists");
            }
            if (getPkJavaType().equals(SystemConfig.TYPE_STRING)) {
                addNoRepeatList(importList, "com.albedo.java.common.data.persistence.IdGen");
            }
        }

        return importList;
    }

    private void initImport(List<String> importList) {
        for (GenTableColumnVo column : getColumnList()) {
            if (column.getIsNotBaseField() || ("1".equals(column.getIsQuery()) && "between".equals(column.getQueryType()) &&
                    (DataEntityVo.F_CREATEDDATE.equals(column.getSimpleJavaField()) ||
                            DataEntityVo.F_LASTMODIFIEDDATE.equals(column.getSimpleJavaField())))) {
                // 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
                if (StringUtil.indexOf(column.getJavaType(), ".") != -1) {
                    addNoRepeatList(importList, column.getJavaType());
                }
            }
            if (column.getIsNotBaseField()) {
                // 导入JSR303、Json等依赖包
                for (String ann : column.getAnnotationList()) {
                    addNoRepeatList(importList, ann.substring(0, ann.indexOf("(")));
                }
            }
            if (!SystemConfig.YES.equals(column.getIsPk()) && !SystemConfig.YES.equals(column.getIsNull()) && column.getJavaType().endsWith(SystemConfig.TYPE_STRING)) {
                addNoRepeatList(importList, "org.hibernate.validator.constraints.NotBlank");
            }
            if (PublicUtil.isNotEmpty(column.getDictType())) {
                addNoRepeatList(importList, "com.albedo.java.util.annotation.DictType");
            }
            if (column.getName().indexOf("mail") != -1) {
                addNoRepeatList(importList, "org.hibernate.validator.constraints.Email");
            }

            if (column.getUnique()) {
                addNoRepeatList(importList, "com.albedo.java.util.annotation.SearchField");
            }
        }
    }


    private void addNoRepeatList(List<String> list, String... val) {
        if (PublicUtil.isNotEmpty(list)) {
            for (String s : val) {
                if (!list.contains(s)) {
                    list.add(s);
                }
            }
        }
    }

    /**
     * 是否存在父类
     *
     * @return
     */
    public Boolean getParentExists() {
        return parent != null && StringUtil.isNotBlank(parentTable) && StringUtil.isNotBlank(parentTableFk);
    }
    public List<GenTableVo> getChildList() {
        return childList!=null ? childList : Lists.newArrayList();
    }

    /**
     * 是否存在子类
     *
     * @return
     */
    public Boolean getChildeExists() {
        return PublicUtil.isNotEmpty(childList);
    }

    /**
     * 是否存在create_time列
     *
     * @return
     */
    public Boolean getCreateTimeExists() {
        for (GenTableColumnVo c : columnList) {
            if ("create_time".equals(c.getName())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 是否存在update_time列
     *
     * @return
     */
    public Boolean getUpdateTimeExists() {
        for (GenTableColumnVo c : columnList) {
            if ("update_time".equals(c.getName())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 是否存在status列
     *
     * @return
     */
    public Boolean getStatusExists() {
        for (GenTableColumnVo c : columnList) {
            if ("status".equals(c.getName())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 获取主键类型
     *
     * @return
     */
    public String getPkJavaType() {
        String type = "";
        if (isCompositeId()) {
            type = PublicUtil.toAppendStr(getClassName(), "Id");
        } else {
            for (GenTableColumnVo column : getColumnList()) {
                if (column.getPk()) {
                    type = column.getJavaType();
                    break;
                }
            }
        }
        return type;
    }

    /**
     * 获取主键sqlname
     *
     * @return
     */
    public String getPkSqlName() {
        String name = "";
        if (isNotCompositeId()) {
            for (GenTableColumnVo column : getColumnList()) {
                if (column.getPk()) {
                    name = column.getName();
                    break;
                }
            }
        }
        return name;
    }

    /**
     * 获取主键sqlname
     *
     * @return
     */
    public String getPkSize() {
        String name = "";
        if (isNotCompositeId()) {
            for (GenTableColumnVo column : getColumnList()) {
                if (column.getPk()) {
                    name = column.getSize();
                    break;
                }
            }
        }
        return name;
    }

    /**
     * 获取主键column
     *
     * @return
     */
    public GenTableColumnVo getPkColumn() {
        if (isNotCompositeId()) {
            for (GenTableColumnVo column : getColumnList()) {
                if (column.getPk()) {
                    return column;
                }
            }
        }
        return null;
    }
}
