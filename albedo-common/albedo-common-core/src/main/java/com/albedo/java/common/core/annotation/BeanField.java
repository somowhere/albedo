package com.albedo.java.common.core.annotation;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;

/**
 * <p>
 * bean copy ingore 属性
 * </p>
 */
@Target({METHOD, FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface BeanField {

	/**
	 * 指定属性
	 */
	String writeProperty() default "";

	/**
	 * 是否忽略
	 */
	boolean ingore() default false;

}
