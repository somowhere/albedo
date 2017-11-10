package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;
import org.hibernate.validator.constraints.Length;

import javax.persistence.CascadeType;
import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import java.util.List;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Entity
@Table(name = "gen_table_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GenTable extends IdEntity {

    public static final String F_NAME = "name";
    public static final String F_NAMESANDCOMMENTS = "nameAndComments";
    private static final long serialVersionUID = 1L;
    @Column(name = "name_")
    @SearchField
    private String name; // 名称
    @Column(name = "comments")
    private String comments; // 描述
    @Column(name = "class_name")
    private String className; // 实体类名称
    @Column(name = "parent_table")
    private String parentTable; // 关联父表
    @Column(name = "parent_table_fk")
    private String parentTableFk; // 关联父表外键

    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.EAGER)
    @JoinColumn(name = "gen_table_id")
    @Where(clause = "status_ = 0")
    @OrderBy("sort_")
    @Fetch(FetchMode.SUBSELECT)
    @JSONField(serialize = false)
    private List<GenTableColumn> columnList; // 表列

    @ManyToOne(targetEntity = GenTable.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_table", referencedColumnName = "name_", nullable = true, insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    @JSONField(serialize = false)
    private GenTable parent; // 父表对象
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch = FetchType.LAZY, mappedBy = "parent", targetEntity = GenTable.class)
    @Where(clause = "status_ = 0")
    @Fetch(FetchMode.SUBSELECT)
    @JSONField(serialize = false)
    private List<GenTable> childList; // 子表列表

    @Transient
    private String nameAndComments;
    @Transient
    private String nameLike; // 按名称模糊查询
    @Transient
    @JSONField(serialize = false)
    private List<String> pkList; // 当前表主键列表
    @Transient
    @JSONField(serialize = false)
    private List<GenTableColumn> pkColumnList; // 当前表主键列表
    @Transient
    private String category; // 当前表的生成分类
    @Transient
    @JSONField(serialize = false)
    private List<GenTableColumn> columnFormList;

    public GenTable() {
        super();
    }

    public GenTable(String id) {
        super();
        this.id = id;
    }

    public GenTable(String name, String comments) {
        this.name = name;
        this.comments = comments;
    }

    @Length(min = 1, max = 200)
    public String getName() {
        return StringUtil.lowerCase(name);
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getParentTable() {
        return StringUtil.lowerCase(parentTable);
    }

    public void setParentTable(String parentTable) {
        this.parentTable = parentTable;
    }

    public String getParentTableJavaFieldFk() {
        return StringUtil.toCamelCase(parentTableFk);
    }

    public String getParentTableFk() {
        return StringUtil.lowerCase(parentTableFk);
    }

    public void setParentTableFk(String parentTableFk) {
        this.parentTableFk = parentTableFk;
    }

    public List<GenTableColumn> getPkColumnList() {
        if (PublicUtil.isEmpty(pkColumnList) && PublicUtil.isNotEmpty(columnList)) {
            if (pkColumnList == null)
                pkColumnList = Lists.newArrayList();
            for (GenTableColumn column : getColumnList()) {
                if (column.getPk()) {
                    pkColumnList.add(column);
                }
            }
        }
        return pkColumnList;
    }

    public void setPkColumnList(List<GenTableColumn> pkColumnList) {
        this.pkColumnList = pkColumnList;
    }

    public boolean isCompositeId() {
        if (getPkList() == null) throw new RuntimeMsgException("无法获取表的主键信息");
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

    public GenTable getParent() {
        return parent;
    }

    public void setParent(GenTable parent) {
        this.parent = parent;
    }

    public List<GenTableColumn> getColumnList() {
        if (columnList == null)
            columnList = Lists.newArrayList();
        return columnList;
    }

    public void setColumnList(List<GenTableColumn> columnList) {
        this.columnList = columnList;
    }

    public List<GenTable> getChildList() {
        return childList;
    }

    public void setChildList(List<GenTable> childList) {
        this.childList = childList;
    }

    /**
     * 获取列名和说明
     *
     * @return
     */
    public String getNameAndComments() {
        if (PublicUtil.isEmpty(nameAndComments))
            nameAndComments = getName() + (comments == null ? "" : "  :  " + comments);
        return nameAndComments;
    }

    public void setNameAndComments(String nameAndComments) {
        this.nameAndComments = nameAndComments;
    }

    public List<GenTableColumn> getColumnFormList() {
        return columnFormList;
    }

    public void setColumnFormList(List<GenTableColumn> columnFormList) {
        this.columnFormList = columnFormList;
    }

    /**
     * 获取导入依赖包字符串
     *
     * @return
     */
    public List<String> getImportList() {
        List<String> importList = null;
        if ("treeTable".equalsIgnoreCase(getCategory())) {
            importList = Lists.newArrayList("org.apache.commons.lang3.builder.EqualsBuilder", "org.apache.commons.lang3.builder.HashCodeBuilder", "org.apache.commons.lang3.builder.ToStringBuilder",
                    "org.apache.commons.lang3.builder.ToStringStyle", "javax.persistence.Entity", "javax.persistence.Table", "org.hibernate.annotations.Cache", "org.hibernate.annotations.CacheConcurrencyStrategy",
                    "org.hibernate.annotations.DynamicInsert", "org.hibernate.annotations.DynamicUpdate", "com.albedo.java.common.domain.base.TreeEntity"); // 引用列表
            for (GenTableColumn column : getColumnList()) {
                if (column.getIsNotBaseTreeField()) {
                    addNoRepeatList(importList, "javax.persistence.Column");
                    if (column.getIsNotBaseField() || ("1".equals(column.getIsQuery()) && "between".equals(column.getQueryType()) && (DataEntity.F_CREATEDDATE.equals(column.getSimpleJavaField()) || DataEntity.F_LASTMODIFIEDDATE.equals(column.getSimpleJavaField())))) {
                        // 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
                        if (StringUtil.indexOf(column.getJavaType(), ".") != -1) {
                            addNoRepeatList(importList, column.getJavaType());
                        }
                    }
//					if (column.getIsDateTimeColumn()) {
//						addNoRepeatList(importList, "javax.persistence.Temporal", "javax.persistence.TemporalType");
//					}
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
                    if (column.getUnique()) {
                        addNoRepeatList(importList, "com.albedo.java.util.annotation.SearchField");
                    }
                    if ("userselect".equals(column.getShowType()) || "orgselect".equals(column.getShowType()) || "areaselect".equals(column.getShowType())) {
                        addNoRepeatList(importList, "javax.persistence.FetchType", "javax.persistence.JoinColumn", "javax.persistence.ManyToOne", "org.hibernate.annotations.NotFound", "org.hibernate.annotations.NotFoundAction");
                    }
                }
            }
            // 如果有子表，则需要导入List相关引用
            if (getChildList() != null && getChildList().size() > 0) {
                addNoRepeatList(importList, "javax.persistence.CascadeType", "javax.persistence.OneToMany", "java.util.List", "com.google.common.collect.Lists", "org.hibernate.annotations.FetchMode", "org.hibernate.annotations.Fetch",
                        "org.hibernate.annotations.Where");
            }
            if (getParentExists()) {
                addNoRepeatList(importList, "javax.persistence.FetchType", "javax.persistence.JoinColumn", "javax.persistence.ManyToOne", "org.hibernate.annotations.NotFound", "org.hibernate.annotations.NotFoundAction");
            }
        } else {
            importList = Lists.newArrayList("org.apache.commons.lang3.builder.EqualsBuilder", "org.apache.commons.lang3.builder.HashCodeBuilder", "org.apache.commons.lang3.builder.ToStringBuilder",
                    "org.apache.commons.lang3.builder.ToStringStyle", "javax.persistence.Entity", "javax.persistence.Table", "javax.persistence.PrePersist", "org.hibernate.annotations.Cache",
                    "org.hibernate.annotations.CacheConcurrencyStrategy", "org.hibernate.annotations.DynamicInsert", "org.hibernate.annotations.DynamicUpdate", "com.albedo.java.common.domain.base.DataEntity",
                    "com.albedo.java.util.annotation.SearchField"); // 引用列表
            for (GenTableColumn column : getColumnList()) {
                addNoRepeatList(importList, "javax.persistence.Column");
                if (column.getIsNotBaseField() || ("1".equals(column.getIsQuery()) && "between".equals(column.getQueryType()) && (DataEntity.F_CREATEDDATE.equals(column.getSimpleJavaField()) || DataEntity.F_LASTMODIFIEDDATE.equals(column.getSimpleJavaField())))) {
                    // 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
                    if (StringUtil.indexOf(column.getJavaType(), ".") != -1) {
                        addNoRepeatList(importList, column.getJavaType());
                    }
                }
//				if (column.getIsDateTimeColumn()) {
//					addNoRepeatList(importList, "javax.persistence.Temporal", "javax.persistence.TemporalType");
//				}
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
                if (column.getUnique()) {
                    addNoRepeatList(importList, "com.albedo.java.util.annotation.SearchField");
                }
                if ("userselect".equals(column.getShowType()) || "orgselect".equals(column.getShowType()) || "areaselect".equals(column.getShowType())) {
                    addNoRepeatList(importList, "javax.persistence.FetchType", "javax.persistence.JoinColumn", "javax.persistence.ManyToOne", "org.hibernate.annotations.NotFound", "org.hibernate.annotations.NotFoundAction");
                }
            }
            // 如果有子表，则需要导入List相关引用
            if (getChildList() != null && getChildList().size() > 0) {
                addNoRepeatList(importList, "javax.persistence.CascadeType", "javax.persistence.OneToMany", "java.util.List", "com.google.common.collect.Lists", "org.hibernate.annotations.FetchMode", "org.hibernate.annotations.Fetch",
                        "org.hibernate.annotations.Where");
            }
            if (getPkJavaType().equals(SystemConfig.TYPE_STRING)) {
                addNoRepeatList(importList, "com.albedo.java.common.domain.base.pk.IdGen");
            }
            if (isCompositeId()) {
                addNoRepeatList(importList, "javax.persistence.EmbeddedId");
            } else {
                addNoRepeatList(importList, "javax.persistence.Id");
            }
            if (getParentExists()) {
                addNoRepeatList(importList, "javax.persistence.FetchType", "javax.persistence.JoinColumn", "javax.persistence.ManyToOne", "org.hibernate.annotations.NotFound", "org.hibernate.annotations.NotFoundAction");
            }
        }

        return importList;
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
        for (GenTableColumn c : columnList) {
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
        for (GenTableColumn c : columnList) {
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
        for (GenTableColumn c : columnList) {
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
            for (GenTableColumn column : getColumnList()) {
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
            for (GenTableColumn column : getColumnList()) {
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
            for (GenTableColumn column : getColumnList()) {
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
    public GenTableColumn getPkColumn() {
        if (isNotCompositeId()) {
            for (GenTableColumn column : getColumnList()) {
                if (column.getPk()) {
                    return column;
                }
            }
        }
        return null;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
