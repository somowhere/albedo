package com.albedo.java.vo.gen;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.vo.base.DataEntityVo;
import com.albedo.java.vo.base.TreeEntityVo;
import com.albedo.java.vo.util.GenTableColumnVoUtil;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

/**
 * 业务表字段Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenTableColumnVo extends DataEntityVo implements Comparable {

    private static final long serialVersionUID = 1L;
    /**
     * 归属表
     */
    private String genTableId;
    /**
     * 归属表
     */
    private GenTableVo genTable;
    /**
     * 列名
     */
    private String name;
    /**
     * 描述
     */
    private String comments;
    /**
     * JDBC类型
     */
    private String jdbcType;
    /**
     * JAVA类型
     */
    private String javaType;
    /**
     * JAVA字段名
     */
    private String javaField;
    /**
     * 是否主键（1：主键）
     */
    private Integer isPk = SystemConfig.NO;
    /**
     * 是否唯一（1：是；0：否）
     */
    private Integer isUnique = SystemConfig.NO;
    /**
     * 是否可为空（1：可为空；0：不为空）
     */
    private Integer isNull = SystemConfig.NO;
    /**
     * 是否为插入字段（1：插入字段）
     */
    private Integer isInsert = SystemConfig.NO;
    /**
     * 是否编辑字段（1：编辑字段）
     */
    private Integer isEdit = SystemConfig.NO;
    /**
     * 是否列表字段（1：列表字段）
     */
    private Integer isList = SystemConfig.NO;
    /**
     * 是否查询字段（1：查询字段）
     */
    private Integer isQuery = SystemConfig.NO;
    /**
     * 查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）
     */
    private String queryType;
    /**
     * 字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）
     */
    private String showType;
    /**
     * 字典类型
     */
    private String dictType;
    /**
     * 排序（升序）
     */
    private Integer sort;

    /**
     * hibernate验证表达式
     */
    private String hibernateValidatorExprssion;


    private String nameAndComments;
    public GenTableColumnVo(String name, Integer isNull, Integer sort, String comments, String jdbcType) {
        this.name = name;
        this.isNull = isNull;
        this.sort = sort;
        this.comments = comments;
        this.jdbcType = jdbcType;
    }
    @Override
    public int compareTo(Object obj) {
        if (obj instanceof GenTableColumnVo) {
            GenTableColumnVo b = (GenTableColumnVo) obj;
            // 按id比较大小，用于默认排序
            return this.sort - b.sort;
        }
        return 0;
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
            // SystemConfig.TYPE_STRING.equals(getJavaType())){
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
        if (!"1".equals(getIsNull()) && !SystemConfig.TYPE_STRING.equals(getJavaType())) {
            list.add("javax.validation.constraints.NotNull(message=\"" + getComments() + "不能为空\")");
        } else if (!"1".equals(getIsNull()) && SystemConfig.TYPE_STRING.equals(getJavaType()) && !"0".equals(getDataLength())) {
            list.add("org.hibernate.validator.constraints.Length(min=1, max=" + getDataLength() + ", message=\"" + getComments() + "长度必须介于 1 和 " + getDataLength() + " 之间\")");
        } else if (SystemConfig.TYPE_STRING.equals(getJavaType()) && !"0".equals(getDataLength())) {
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
        return !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_ID) && !StringUtil.equals(getName(), "id_") &&
                !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_DESCRIPTION) && !StringUtil.equals(getName(), "description_")
                && !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_CREATEDBY) && !StringUtil.equals(getName(), "created_by") &&
                !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_CREATEDDATE) && !StringUtil.equals(getName(), "created_date")
                && !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_LASTMODIFIEDBY) && !StringUtil.equals(getName(), "last_modified_by") &&
                !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_LASTMODIFIEDDATE) && !StringUtil.equals(getName(), "last_modified_date")
                && !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_STATUS) && !StringUtil.equals(getName(), "status_") &&
                !StringUtil.equals(getSimpleJavaField(), DataEntityVo.F_VERSION) && !StringUtil.equals(getName(), "version_");
    }

    /**
     * 是否是基类字段
     *
     * @return
     */
    public Boolean getIsNotBaseTreeField() {
        return !StringUtil.equals(getSimpleJavaField(), TreeEntityVo.F_NAME) && !StringUtil.equals(getName(), "name_") &&
                !StringUtil.equals(getSimpleJavaField(), TreeEntityVo.F_PARENTID) && !StringUtil.equals(getSimpleJavaField(), "parent")
                && !StringUtil.equals(getName(), "parent_id") &&
                !StringUtil.equals(getSimpleJavaField(), TreeEntityVo.F_PARENTIDS)
                && !StringUtil.equals(getName(), "parent_ids")
                && !StringUtil.equals(getSimpleJavaField(), TreeEntityVo.F_SORT)
                && !StringUtil.equals(getName(), "sort_")
                && !StringUtil.equals(getSimpleJavaField(), TreeEntityVo.F_ISLEAF)
                && !StringUtil.equals(getName(), "is_leaf");

    }

    public boolean getIsDateTimeColumn() {
        return getJavaField().contains(SystemConfig.TYPE_DATE) && getJavaType().contains(SystemConfig.TYPE_DATE);
    }

    public String getHibernateValidatorExprssion() {
        if (PublicUtil.isEmpty(hibernateValidatorExprssion)) {
            hibernateValidatorExprssion = GenTableColumnVoUtil.getHibernateValidatorExpression(this);
        }
        return hibernateValidatorExprssion;
    }

    public void setHibernateValidatorExprssion(String hibernateValidatorExprssion) {
        this.hibernateValidatorExprssion = hibernateValidatorExprssion;
    }

    public String getSize() {
        String size;
        if (jdbcType != null && jdbcType.contains("(")) {
            size = jdbcType.substring(jdbcType.indexOf("(") + 1, jdbcType.length() - 1);
        } else if ("text".equals(jdbcType)) {
            size = "65535";
        } else {
            size = "";
        }
        return size;
    }



}
