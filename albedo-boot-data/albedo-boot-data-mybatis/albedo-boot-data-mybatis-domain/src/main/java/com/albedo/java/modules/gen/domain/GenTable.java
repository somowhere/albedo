package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.annotation.SearchField;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.*;

import java.util.List;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Entity(table = "gen_table_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenTable extends IdEntity {

    public static final String F_NAME = "name";
    public static final String F_NAMESANDCOMMENTS = "nameAndComments";
    private static final long serialVersionUID = 1L;
    @Column(name = "name_")
    @SearchField
    @Length(min = 1, max = 200)
    private String name; // 名称
    @Column(name = "comments")
    private String comments; // 描述
    @Column(name = "class_name")
    private String className; // 实体类名称
    @Column(name = "parent_table")
    private String parentTable; // 关联父表
    @Column(name = "parent_table_fk")
    private String parentTableFk; // 关联父表外键

    @OneToMany()
    @JoinColumn(name = "gen_table_id")
    @JSONField(serialize = false)
    private List<GenTableColumn> columnList; // 表列

    @ManyToOne
    @JoinColumn(name = "parent_table", referencedColumnName = "name_", insertable = false, updatable = false)
    @JSONField(serialize = false)
    private GenTable parent; // 父表对象
    @OneToMany
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

    public GenTable(String id) {
        super();
        this.id = id;
    }

    public GenTable(String name, String comments) {
        this.name = name;
        this.comments = comments;
    }


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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
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

}
