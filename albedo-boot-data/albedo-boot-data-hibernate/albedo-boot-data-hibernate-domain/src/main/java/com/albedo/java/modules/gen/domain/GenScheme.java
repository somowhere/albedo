package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.config.SystemConfig;
import com.alibaba.fastjson.annotation.JSONField;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.*;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@Entity
@Table(name = "gen_scheme_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GenScheme extends IdEntity {

    /**
     * @Fields CATEGORY_CURD : 增删改查（单表）
     */
    public static final String CATEGORY_CURD = "curd";
    /**
     * @Fields CATEGORY_CURD_MANY : 增删改查（一对多）
     */
    public static final String CATEGORY_CURD_MANY = "curd_many";
    /**
     * @Fields CATEGORY_SERVICE : 仅持久层（service/entity）
     */
    public static final String CATEGORY_SERVICE = "service";
    /**
     * @Fields CATEGORY_CURD : 数据层（entity）
     */
    public static final String CATEGORY_ENITY = "entity";
    /**
     * @Fields CATEGORY_CURD : 树结构表（一体）
     */
    public static final String CATEGORY_TREETABLE = "treeTable";
    private static final long serialVersionUID = 1L;
    @Length(min = 1, max = 200)
    @Column(name = "name_")
    private String name; // 名称
    @Column(name = "category_")
    private String category; // 分类
    @Column(name = "view_type")
    private Integer viewType; // 视图类型 0 普通表格 1 表格采用ajax刷新
    @Column(name = "package_name")
    private String packageName; // 生成包路径
    @Column(name = "module_name")
    private String moduleName; // 生成模块名
    @Column(name = "sub_module_name")
    private String subModuleName; // 生成子模块名
    @Column(name = "function_name")
    private String functionName; // 生成功能名
    @Column(name = "function_name_simple")
    private String functionNameSimple; // 生成功能名（简写）
    @Column(name = "function_author")
    private String functionAuthor; // 生成功能作者
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "gen_table_id", nullable = true)
    @NotFound(action = NotFoundAction.IGNORE)
    private GenTable genTable; // 业务表名
    @Column(name = "gen_table_id", nullable = true, updatable = false, insertable = false)
    private String genTableId; // 业务表名

    @JSONField(serialize = false)
    @Transient
    private Boolean genCode = false; // flase：保存方案； ture：保存方案并生成代码
    @JSONField(serialize = false)
    @Transient
    private Boolean replaceFile = false; // 是否替换现有文件 true：替换文件 ；false：不替换；
    @JSONField(serialize = false)
    @Transient
    private Boolean syncModule = false; // 是否同步模块数据 true：同步；false：不同步
    @JSONField(serialize = false)
    @Transient
    private String parentModuleId; // 上级模块 ID 仅当syncModule 为 true有效

    public GenScheme() {
        super();
    }

    public GenScheme(String id) {
        super();
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public Integer getViewType() {
        return viewType;
    }

    public void setViewType(Integer viewType) {
        this.viewType = viewType;
    }

    /**
     * true 使用ajax视图
     *
     * @return
     */
    @Transient
    public boolean getModalView() {
        return SystemConfig.YES.equals(viewType);
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getSubModuleName() {
        return subModuleName;
    }

    public void setSubModuleName(String subModuleName) {
        this.subModuleName = subModuleName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFunctionName() {
        return functionName;
    }

    public void setFunctionName(String functionName) {
        this.functionName = functionName;
    }

    public String getFunctionNameSimple() {
        return functionNameSimple;
    }

    public void setFunctionNameSimple(String functionNameSimple) {
        this.functionNameSimple = functionNameSimple;
    }

    public String getFunctionAuthor() {
        return functionAuthor;
    }

    public void setFunctionAuthor(String functionAuthor) {
        this.functionAuthor = functionAuthor;
    }

    public GenTable getGenTable() {
        return genTable;
    }

    public void setGenTable(GenTable genTable) {
        this.genTable = genTable;
    }

    public String getGenTableId() {
        return genTableId;
    }

    public void setGenTableId(String genTableId) {
        this.genTableId = genTableId;
    }

    public Boolean getGenCode() {
        return genCode;
    }

    public void setGenCode(Boolean genCode) {
        this.genCode = genCode;
    }

    public Boolean getReplaceFile() {
        return replaceFile;
    }

    public void setReplaceFile(Boolean replaceFile) {
        this.replaceFile = replaceFile;
    }

    public Boolean getSyncModule() {
        return syncModule;
    }

    public void setSyncModule(Boolean syncModule) {
        this.syncModule = syncModule;
    }

    public String getParentModuleId() {
        return parentModuleId;
    }

    public void setParentModuleId(String parentModuleId) {
        this.parentModuleId = parentModuleId;
    }

}
