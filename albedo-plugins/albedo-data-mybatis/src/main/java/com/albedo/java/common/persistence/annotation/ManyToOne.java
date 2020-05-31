package com.albedo.java.common.persistence.annotation;

import java.lang.annotation.*;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD})
@Deprecated
public @interface ManyToOne {

	/**
	 * 如果是字典类型，请设置字典的name值
	 */
	String name() default "";

}
