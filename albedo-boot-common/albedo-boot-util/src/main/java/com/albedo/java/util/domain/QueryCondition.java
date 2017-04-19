package com.albedo.java.util.domain;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.spring.SpringContextHolder;
import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.util.StringUtils;

@Slf4j @Data
public class QueryCondition implements Comparable<QueryCondition>, java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private  Class<?> persistentClass;
	/*** 节点 */
	public static final String F_FILEDNODE = "fieldNode";
	/*** 实体属性 注意区分大小写 */
	public static final String F_FILEDNAME = "fieldName";
	/*** 操作符 */
	public static final String F_OPERATE = "operate";
	/*** 值 */
	public static final String F_ATTRTYPE = "attrType";
	public static final String F_FORMAT = "format";
	public static final String F_VALUE = "value";
	public static final String F_ENDVALUE = "endValue";
	/*** 查询权重 */
	public static final String F_WEIGHT = "weight";

	/**
	 * 运算符
	 */
	public enum Operator {

		/** 等于 */
		eq("="),

		/** 不等于 */
		ne("!="),

		/** 大于 */
		gt(">"),

		/** 小于 */
		lt("<"),

		/** 大于等于 */
		ge(">="),

		/** 小于等于 */
		le("<="),

		/** 类似 */
		like("like"),
		/** 类似 */
		between("between"),

		/** 包含 */
		in("in"),

		/** 包含 */
		notIn("not in"),
		
		/** 为Null */
		isNull("is Null"),

		/** 不为Null */
		isNotNull("is Not Null");
		Operator(String operator) {
			this.operator = operator;
		}

		private String operator;

		public String getOperator() {
			return operator;
		}

		public void setOperator(String operator) {
			this.operator = operator;
		}
	}

	/**
	 * 节点
	 */
	private String fieldNode;
	/**
	 * 实体属性 注意区分大小写
	 */
	private String fieldName;
	/**
	 * 操作符
	 */
	private Operator operate;
	/**
	 * 值类型
	 */
	private String attrType;
	/**
	 * 值格式
	 */
	private String format;
	/**
	 * 值
	 */
	private Object value;

	/**
	 * 第二个值 operate= between
	 */
	private Object endValue;

	/**
	 * @Fields ingore : 是否忽略
	 */
	private boolean ingore = false;

	/**
	 * 查询权重
	 */
	private Integer weight = Integer.valueOf(0x186a0);

	/**
	 * 返回等于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 等于筛选
	 */
	public static QueryCondition eq(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.eq, value);
	}

	/**
	 * 返回不等于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 不等于筛选
	 */
	public static QueryCondition ne(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.ne, value);
	}

	/**
	 * 返回大于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 大于筛选
	 */
	public static QueryCondition gt(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.gt, value);
	}

	/**
	 * 返回小于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 小于筛选
	 */
	public static QueryCondition lt(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.lt, value);
	}

	/**
	 * 返回大于等于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 大于等于筛选
	 */
	public static QueryCondition ge(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.ge, value);
	}

	/**
	 * 返回小于等于筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 小于等于筛选
	 */
	public static QueryCondition le(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.le, value);
	}

	/**
	 * 返回相似筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 相似筛选
	 */
	public static QueryCondition like(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.like, value);
	}

	/**
	 * 返回包含筛选
	 *
	 * @param property
	 *            属性
	 * @param value
	 *            值
	 * @return 包含筛选
	 */
	public static QueryCondition in(String property, Object value) {
		return new QueryCondition(property, QueryCondition.Operator.in, value);
	}

	/**
	 * 返回为Null筛选
	 *
	 * @param property
	 *            属性
	 * @return 为Null筛选
	 */
	public static QueryCondition isNull(String property) {
		return new QueryCondition(property, QueryCondition.Operator.isNull, null);
	}

	/**
	 * 返回不为Null筛选
	 *
	 * @param property
	 *            属性
	 * @return 不为Null筛选
	 */
	public static QueryCondition isNotNull(String property) {
		return new QueryCondition(property, QueryCondition.Operator.isNotNull, null);
	}

	public QueryCondition(){
	}

	public QueryCondition(String fieldNode, String fieldName, Operator operate, Object value) {
		this.fieldNode = fieldNode;
		this.fieldName = fieldName;
		this.operate = operate;
		this.value = value;
	}

	public QueryCondition(String fieldName, Operator operate, Object value, Class<?> persistentClass) {
		this.fieldName = fieldName;
		this.operate = operate;
		this.value = value;
		this.persistentClass = persistentClass;
	}

	public QueryCondition(String fieldName, Operator operate, Object value) {
		this.fieldName = fieldName;
		this.operate = operate;
		this.value = value;
	}


	public String getFieldNode() {
		return fieldNode;
	}

	public void setFieldNode(String fieldNode) {
		this.fieldNode = fieldNode;
	}

	public String getFieldName() {
		if(PublicUtil.isNotEmpty(fieldName) && fieldName.contains("this.")){
			fieldName = fieldName.replace("this.", "");
		}
		return fieldName;
	}

	@JSONField(serialize = false)
	public String getFieldRealColumnName() {
		String fieldNameReal = new String(fieldName);
		try {
			if(persistentClass!=null && PublicUtil.isNotEmpty(getFieldName())){
				Entity entity = Reflections.getAnnotation(persistentClass, Entity.class);
				String quota = null != entity && StringUtils.hasText(entity.name()) ? entity.name():
						StringUtils.uncapitalize(persistentClass.getSimpleName());
				Column column = Reflections.getAnnotationByClazz(persistentClass, fieldName, Column.class);
				if(column!=null && PublicUtil.isNotEmpty(column.name())){
					Dialect dialect = SpringContextHolder.getBean(Dialect.class);
					fieldNameReal = dialect.openQuote() + quota + dialect.closeQuote() +'.'+column.name();
				}
			}
		}catch (Exception e){
			log.warn(e.getMessage());
		}
		return fieldNameReal;
	}


	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public Operator getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = Operator.valueOf(operate);
	}

	public void setOperate(Operator operate) {
		this.operate = operate;
	}

	public String getAttrType() {
		return attrType;
	}

	public void setAttrType(String attrType) {
		this.attrType = attrType;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public Object getValue() {
		return value;
	}

	public Object getEndValue() {
		return endValue;
	}

	public void setEndValue(Object endValue) {
		this.endValue = endValue;
	}

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public boolean isIngore() {
		return ingore;
	}

	public void setIngore(boolean ingore) {
		this.ingore = ingore;
	}

	public int compareTo(QueryCondition arg) {
		int weight = valueOfQueryType(operate) - valueOfQueryType(arg.getOperate());
		return weight != 0 ? weight : this.weight.intValue() - arg.weight.intValue();
	}

	private int valueOfQueryType(Operator op) {
		if (Operator.eq.equals(op))
			return 0;
		if (Operator.ne.equals(op))
			return 1;
		if (Operator.between.equals(op))
			return 2;
		if (Operator.in.equals(op))
			return 3;
		if (Operator.ge.equals(op) || Operator.gt.equals(op))
			return 4;
		if (Operator.le.equals(op) || Operator.lt.equals(op))
			return 5;
		if (Operator.like.equals(op))
			return 6;
		return !"query".equals(op) ? 999 : 100;
	}

}
