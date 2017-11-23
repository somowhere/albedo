package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.config.SystemConfig;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.data.mybatis.annotations.ManyToOne;

/**
 * 业务表字段Entity
 *
 * @version 2013-10-15
 */
@Entity(table = "gen_table_column_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenTableColumn extends IdEntity {

    private static final long serialVersionUID = 1L;

    @Column(name = "gen_table_id")
    private String genTableId; // 列名
    @ManyToOne
    @JoinColumn(name = "gen_table_id", insertable = false, updatable = false)
    private GenTable genTable; // 归属表
    @Length(min = 1, max = 200)
    @Column(name = "name_")
    private String name; // 列名
    @Column(name = "comments")
    private String comments; // 描述
    @Column(name = "jdbc_type")
    private String jdbcType; // JDBC类型
    @Column(name = "java_type")
    private String javaType; // JAVA类型
    @Column(name = "java_field")
    private String javaField; // JAVA字段名
    @Column(name = "is_pk")
    private Integer isPk = SystemConfig.NO; // 是否主键（1：主键）
    @Column(name = "is_unique")
    private Integer isUnique = SystemConfig.NO; // 是否唯一（1：是；0：否）
    @Column(name = "is_null")
    private Integer isNull = SystemConfig.NO; // 是否可为空（1：可为空；0：不为空）
    @Column(name = "is_insert")
    private Integer isInsert = SystemConfig.NO; // 是否为插入字段（1：插入字段）
    @Column(name = "is_edit")
    private Integer isEdit = SystemConfig.NO; // 是否编辑字段（1：编辑字段）
    @Column(name = "is_list")
    private Integer isList = SystemConfig.NO; // 是否列表字段（1：列表字段）
    @Column(name = "is_query")
    private Integer isQuery = SystemConfig.NO; // 是否查询字段（1：查询字段）
    @Column(name = "query_type")
    private String queryType; // 查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）
    @Column(name = "show_type")
    private String showType; // 字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）
    @Column(name = "dict_type")
    private String dictType; // 字典类型
    @Column(name = "sort_")
    private Integer sort; // 排序（升序）

    @Transient
    private String hibernateValidatorExprssion;
    @Transient
    private String size;

    public GenTableColumn(String id) {
        super();
        this.id = id;
    }

    public GenTableColumn(String name, Integer isNull, Integer sort, String comments, String jdbcType) {
        this.name = name;
        this.isNull = isNull;
        this.sort = sort;
        this.comments = comments;
        this.jdbcType = jdbcType;
    }


}
