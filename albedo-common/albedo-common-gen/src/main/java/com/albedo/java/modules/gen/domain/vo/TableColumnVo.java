package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.common.core.vo.TreeEntityVo;
import com.albedo.java.modules.gen.util.GenTableColumnVoUtil;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.apache.commons.lang.StringUtils;

import javax.validation.constraints.NotBlank;
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
public class TableColumnVo extends DataEntityVo<String> implements Comparable {

	private static final long serialVersionUID = 1L;
	/**
	 * 归属表
	 */
	private String tableId;
	/**
	 * 归属表
	 */
	@JSONField(serialize = false)
	private TableDataVo table;
	/**
	 * 列名
	 */
	private String name;
	/**
	 * 标题
	 */
	@NotBlank
	private String title;
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
	private boolean isPk;
	/**
	 * 是否唯一（1：是；0：否）
	 */
	private boolean isUnique;
	/**
	 * 是否可为空（1：可为空；0：不为空）
	 */
	private boolean isNull;
	/**
	 * 是否为插入字段（1：插入字段）
	 */
	private boolean isInsert;
	/**
	 * 是否编辑字段（1：编辑字段）
	 */
	private boolean isEdit;
	/**
	 * 是否列表字段（1：列表字段）
	 */
	private boolean isList;
	/**
	 * 是否查询字段（1：查询字段）
	 */
	private boolean isQuery;
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


	private String nameAndTitle;

	public TableColumnVo(String name, boolean isNull, Integer sort, String title, String jdbcType) {
		this.name = name;
		this.isNull = isNull;
		this.sort = sort;
		this.title = title;
		this.jdbcType = jdbcType;
	}

	@Override
	public int compareTo(Object obj) {
		if (obj instanceof TableColumnVo) {
			TableColumnVo b = (TableColumnVo) obj;
			// 按id比较大小，用于默认排序
			return this.sort - b.sort;
		}
		return 0;
	}

	public String getDictType() {
		return dictType == null ? "" : dictType;
	}


	/**
	 * 获取列名和说明
	 *
	 * @return
	 */
	public String getNameAndTitle() {
		return getName() + (title == null ? "" : "  :  " + title);
	}

	/**
	 * 获取字符串长度
	 *
	 * @return
	 */
	public String getDataLength() {
		String[] ss = StringUtil.split(StringUtils.substringBetween(getJdbcType(), "(", ")"), StringUtil.SPLIT_DEFAULT);
		if (ss != null && ss.length == 1) {// &&
			// CommonConstants.TYPE_STRING.equals(getJavaType())){
			return ss[0];
		}
		return "0";
	}

	/**
	 * 获取简写Java类型
	 *
	 * @return
	 */
	@JSONField(serialize = false)
	public String getSimpleJavaType() {
		if ("This".equals(getJavaType())) {
			return StringUtils.capitalize(table.getClassName());
		}
		return StringUtil.indexOf(getJavaType(), StringUtil.C_DOT) != -1 ?
			StringUtils.substringAfterLast(getJavaType(), ".") : getJavaType();
	}

	/**
	 * 获取简写Java类型
	 *
	 * @return
	 */
	@JSONField(serialize = false)
	public String getSimpleTsType() {
		String javaSimpleType = getSimpleJavaType();
		return StringUtil.isNotEmpty(javaSimpleType) && (javaSimpleType.indexOf("Integer") != -1 || javaSimpleType.indexOf("Double") != -1 || javaSimpleType.indexOf("Float") != -1) ? "number" : "string";
	}

	/**
	 * 获取简写Java字段
	 *
	 * @return
	 */
	public String getSimpleJavaField() {
		return StringUtils.substringBefore(getJavaField(), ".");
	}

	/**
	 * 获取全大写Java字段
	 *
	 * @return
	 */
	public String getConstantJavaField() {
		return StringUtils.upperCase(getSimpleJavaField());
	}

	/**
	 * 获取Java字段，如果是对象，则获取对象.附加属性1
	 *
	 * @return
	 */
	public String getJavaFieldId() {
		return StringUtils.substringBefore(getJavaField(), "|");
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
		return ss.length > 0 ? getSimpleJavaField() + StringUtils.capitalize(ss[0][0]) : "";
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
		String[] ss = StringUtil.split(StringUtils.substringAfter(getJavaField(), "|"), "|");
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
		// 导入JSR303验证依赖包
		if (!"1".equals(isPk()) && !CommonConstants.TYPE_STRING.equals(getJavaType())) {
			list.add("javax.validation.constraints.NotNull(message=\"" + getTitle() + "不能为空\")");
		} else if (!"1".equals(isNull()) && CommonConstants.TYPE_STRING.equals(getJavaType()) && !"0".equals(getDataLength())) {
			list.add("javax.validation.constraints.Size(min=1, max=" + getDataLength() + ", message=\"" + getTitle() + "长度必须介于 1 和 " + getDataLength() + " 之间\")");
		} else if (CommonConstants.TYPE_STRING.equals(getJavaType()) && !"0".equals(getDataLength())) {
			list.add("javax.validation.constraints.Size(min=0, max=" + getDataLength() + ", message=\"" + getTitle() + "长度必须介于 0 和 " + getDataLength() + " 之间\")");
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
			list.add(StringUtils.substringAfterLast(ann, "."));
		}
		return list;
	}

	/**
	 * 是否是基类字段
	 *
	 * @return
	 */
	public Boolean getIsNotBaseField() {
		return !StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_ID) && !StringUtil.equalsIgnoreCase(getName(), "id") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_DESCRIPTION) && !StringUtil.equalsIgnoreCase(getName(), "description")
			&& !StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_CREATEDBY) && !StringUtil.equalsIgnoreCase(getName(), "created_by") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_CREATEDDATE) && !StringUtil.equalsIgnoreCase(getName(), "created_date")
			&& !StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_LASTMODIFIEDBY) && !StringUtil.equalsIgnoreCase(getName(), "last_modified_by") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_LASTMODIFIEDDATE) && !StringUtil.equalsIgnoreCase(getName(), "last_modified_date")
			&& !StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_DELFLAG) && !StringUtil.equalsIgnoreCase(getName(), "del_flag") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), DataEntityVo.F_VERSION) && !StringUtil.equalsIgnoreCase(getName(), "version");
	}

	/**
	 * 是否是基类字段
	 *
	 * @return
	 */
	public Boolean getIsNotBaseTreeField() {
		return !StringUtil.equalsIgnoreCase(getSimpleJavaField(), TreeEntityVo.F_NAME) && !StringUtil.equalsIgnoreCase(getName(), "name") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), TreeEntityVo.F_PARENTID) && !StringUtil.equalsIgnoreCase(getSimpleJavaField(), "parent")
			&& !StringUtil.equalsIgnoreCase(getName(), "parent_id") &&
			!StringUtil.equalsIgnoreCase(getSimpleJavaField(), TreeEntityVo.F_PARENTIDS)
			&& !StringUtil.equalsIgnoreCase(getName(), "parent_ids")
			&& !StringUtil.equalsIgnoreCase(getSimpleJavaField(), TreeEntityVo.F_SORT)
			&& !StringUtil.equalsIgnoreCase(getName(), "sort")
			&& !StringUtil.equalsIgnoreCase(getSimpleJavaField(), TreeEntityVo.F_ISLEAF)
			&& !StringUtil.equalsIgnoreCase(getName(), "leaf");

	}

	public boolean getIsDateTimeColumn() {
		return getJavaField().contains(CommonConstants.TYPE_DATE) && getJavaType().contains(CommonConstants.TYPE_DATE);
	}

	public String getHibernateValidatorExprssion() {
		if (StringUtil.isEmpty(hibernateValidatorExprssion)) {
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
