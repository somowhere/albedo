package com.albedo.java.common.core.annotation;

import com.albedo.java.common.core.vo.QueryCondition;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;

/**
 * bean中文名注解
 */
@Target({METHOD, FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface SearchField {

	/**
	 * 属性拼接条件 支持 = / != / > / >= / < / <= / like
	 *
	 * @return
	 */
	QueryCondition.Operator op() default QueryCondition.Operator.eq;
}
