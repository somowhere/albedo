package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.config.SystemConfig;
import com.google.common.collect.Lists;
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

import java.util.List;

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
public class GenTableColumn extends IdEntity implements Comparable {

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

    public boolean getPk() {
        return SystemConfig.YES.equals(getIsPk());
    }

    public boolean getUnique() {
        return SystemConfig.YES.equals(getIsUnique());
    }

    public boolean getNullable() {
        return SystemConfig.YES.equals(getIsNull());
    }

    public String getDictType() {
        return dictType == null ? "" : dictType;
    }


    /**
     * 获取列名和说明
     *
     * @return
     */
    public String getNameAndComments() {
        return getName() + (comments == null ? "" : "  :  " + comments);
    }

    /**
     * 获取字符串长度
     *
     * @return
     */
    public String getDataLength() {
        String[] ss = StringUtil.split(StringUtil.substringBetween(getJdbcType(), "(", ")"), ",");
        if (ss != null && ss.length == 1) {// &&
            // "String".equals(getJavaType())){
            return ss[0];
        }
        return "0";
    }

    /**
     * 获取简写Java类型
     *
     * @return
     */
    public String getSimpleJavaType() {
        if ("This".equals(getJavaType())) {
            return StringUtil.capitalize(genTable.getClassName());
        }
        return StringUtil.indexOf(getJavaType(), ".") != -1 ? StringUtil.substringAfterLast(getJavaType(), ".") : getJavaType();
    }

    /**
     * 获取简写Java字段
     *
     * @return
     */
    public String getSimpleJavaField() {
        return StringUtil.substringBefore(getJavaField(), ".");
    }

    /**
     * 获取全大写Java字段
     *
     * @return
     */
    public String getConstantJavaField() {
        return StringUtil.upperCase(getSimpleJavaField());
    }

    /**
     * 获取Java字段，如果是对象，则获取对象.附加属性1
     *
     * @return
     */
    public String getJavaFieldId() {
        return StringUtil.substringBefore(getJavaField(), "|");
    }

    /**
     * 获取Java字段，如果是对象，则获取对象.附加属性2
     *
     * @return
     */
    public String getJavaFieldName() {
        String[][] ss = getJavaFieldAttrs();
        return ss.length > 0 ? getSimpleJavaField() + "." + ss[0][0] : "";
    }

    /**
     * 获取Java字段，如果是对象，则获取对象.附加属性2
     *
     * @return
     */
    public String getJavaFieldShowName() {
        String[][] ss = getJavaFieldAttrs();
        return ss.length > 0 ? getSimpleJavaField() + StringUtil.capitalize(ss[0][0]) : "";
    }


    /**
     * 获取Java字段，如果是对象，则获取对象.附加属性2 默认 name
     *
     * @return
     */
    public String getDefaultJavaFieldName() {
        String[][] ss = getJavaFieldAttrs();
        return ss.length > 0 ? ss[0][0] : "name";
    }

    /**
     * 获取Java字段，所有属性名
     *
     * @return
     */
    public String[][] getJavaFieldAttrs() {
        String[] ss = StringUtil.split(StringUtil.substringAfter(getJavaField(), "|"), "|");
        String[][] sss = new String[ss.length][2];
        if (ss != null) {
            for (int i = 0; i < ss.length; i++) {
                sss[i][0] = ss[i];
                sss[i][1] = StringUtil.toUnderScoreCase(ss[i]);
            }
        }
        return sss;
    }

    /**
     * 获取列注解列表
     *
     * @return
     */
    public List<String> getAnnotationList() {
        List<String> list = Lists.newArrayList();
        // 导入Jackson注解
        if ("This".equals(getJavaType())) {
            list.add("com.fasterxml.jackson.annotation.JsonBackReference");
        }
        if ("java.util.Date".equals(getJavaType())) {
            list.add("com.fasterxml.jackson.annotation.JsonFormat(pattern = \"yyyy-MM-dd HH:mm:ss\")");
        }
        // 导入JSR303验证依赖包
        if (!"1".equals(getIsNull()) && !"String".equals(getJavaType())) {
            list.add("javax.validation.constraints.NotNull(message=\"" + getComments() + "不能为空\")");
        } else if (!"1".equals(getIsNull()) && "String".equals(getJavaType()) && !"0".equals(getDataLength())) {
            list.add("org.hibernate.validator.constraints.Length(min=1, max=" + getDataLength() + ", message=\"" + getComments() + "长度必须介于 1 和 " + getDataLength() + " 之间\")");
        } else if ("String".equals(getJavaType()) && !"0".equals(getDataLength())) {
            list.add("org.hibernate.validator.constraints.Length(min=0, max=" + getDataLength() + ", message=\"" + getComments() + "长度必须介于 0 和 " + getDataLength() + " 之间\")");
        }
        return list;
    }

    /**
     * 获取简写列注解列表
     *
     * @return
     */
    public List<String> getSimpleAnnotationList() {
        List<String> list = Lists.newArrayList();
        for (String ann : getAnnotationList()) {
            list.add(StringUtil.substringAfterLast(ann, "."));
        }
        return list;
    }

    /**
     * 是否是基类字段
     *
     * @return
     */
    public Boolean getIsNotBaseField() {
        return !StringUtil.equals(getSimpleJavaField(), IdEntity.F_ID) && !StringUtil.equals(getName(), "id_") &&
                !StringUtil.equals(getSimpleJavaField(), IdEntity.F_DESCRIPTION) && !StringUtil.equals(getName(), "description_")
                && !StringUtil.equals(getSimpleJavaField(), IdEntity.F_CREATEDBY) && !StringUtil.equals(getName(), "created_by") &&
                !StringUtil.equals(getSimpleJavaField(), IdEntity.F_CREATEDDATE) && !StringUtil.equals(getName(), "created_date")
                && !StringUtil.equals(getSimpleJavaField(), IdEntity.F_LASTMODIFIEDBY) && !StringUtil.equals(getName(), "last_modified_by") &&
                !StringUtil.equals(getSimpleJavaField(), IdEntity.F_LASTMODIFIEDDATE) && !StringUtil.equals(getName(), "last_modified_date")
                && !StringUtil.equals(getSimpleJavaField(), IdEntity.F_STATUS) && !StringUtil.equals(getName(), "status_") &&
                !StringUtil.equals(getSimpleJavaField(), IdEntity.F_VERSION) && !StringUtil.equals(getName(), "version_");
    }

    /**
     * 是否是基类字段
     *
     * @return
     */
    public Boolean getIsNotBaseTreeField() {
        return !StringUtil.equals(getSimpleJavaField(), TreeEntity.F_NAME) && !StringUtil.equals(getName(), "name_") &&
                !StringUtil.equals(getSimpleJavaField(), TreeEntity.F_PARENTID) && !StringUtil.equals(getSimpleJavaField(), "parent")
                && !StringUtil.equals(getName(), "parent_id") &&
                !StringUtil.equals(getSimpleJavaField(), TreeEntity.F_PARENTIDS)
                && !StringUtil.equals(getName(), "parent_ids")
                && !StringUtil.equals(getSimpleJavaField(), TreeEntity.F_SORT)
                && !StringUtil.equals(getName(), "sort_")
                && !StringUtil.equals(getSimpleJavaField(), TreeEntity.F_ISLEAF)
                && !StringUtil.equals(getName(), "is_leaf");

    }

    public boolean getIsDateTimeColumn() {
        return getJavaField().contains("Date") && getJavaType().contains("Date");
    }

    public String getHibernateValidatorExprssion() {
        if (PublicUtil.isEmpty(hibernateValidatorExprssion)) {
            hibernateValidatorExprssion = GenUtil.getHibernateValidatorExpression(this);
        }
        return hibernateValidatorExprssion;
    }

    public void setHibernateValidatorExprssion(String hibernateValidatorExprssion) {
        this.hibernateValidatorExprssion = hibernateValidatorExprssion;
    }

    public String getSize() {
        if (jdbcType.contains("(") && PublicUtil.isEmpty(size)) {
            size = jdbcType.substring(jdbcType.indexOf("(") + 1, jdbcType.length() - 1);
        } else if (jdbcType.equals("text"))
            size = "65535";
        else
            size = "";
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    @Override
    public int compareTo(Object obj) {
        GenTableColumn b = (GenTableColumn) obj;
        return this.sort - b.sort; // 按书的id比较大小，用于默认排序
    }


}
