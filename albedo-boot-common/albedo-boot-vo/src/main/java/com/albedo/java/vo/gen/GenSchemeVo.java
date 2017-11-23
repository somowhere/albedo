package com.albedo.java.vo.gen;

import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.vo.base.DataEntityVo;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.mybatis.annotations.Entity;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@Entity(table = "gen_scheme_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenSchemeVo extends DataEntityVo {

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
    /**
     * 名称
     */
    private String name;
    /**
     * 分类
     */
    private String category;
    /**
     * 视图类型 0 普通表格 1 表格采用ajax刷新
     */
    private Integer viewType;
    /**
     * 生成包路径
     */
    private String packageName;
    /**
     * 生成模块名
     */
    private String moduleName;
    /**
     * 生成子模块名
     */
    private String subModuleName;
    /**
     * 生成功能名
     */
    private String functionName;
    /**
     * 生成功能名（简写）
     */
    private String functionNameSimple;
    /**
     * 生成功能作者
     */
    private String functionAuthor;
    /**
     * 业务表名
     */
    private String genTableId;
    /**
     * 业务表名
     */
    private GenTableVo genTable;

    @JSONField(serialize = false)
    /**
     * flase：保存方案； ture：保存方案并生成代码
     */
    private Boolean genCode = false;
    @JSONField(serialize = false)
    /**
     * 是否替换现有文件 true：替换文件 ；false：不替换；
     */
    private Boolean replaceFile = false;
    @JSONField(serialize = false)
    /**
     * 是否同步模块数据 true：同步；false：不同步
     */
    private Boolean syncModule = false;
    @JSONField(serialize = false)
    /**
     * 上级模块 ID 仅当syncModule 为 true有效
     */
    private String parentModuleId;

    /**
     * true 使用ajax视图
     *
     * @return
     */
    public boolean getModalView() {
        return SystemConfig.YES.equals(viewType);
    }
}
