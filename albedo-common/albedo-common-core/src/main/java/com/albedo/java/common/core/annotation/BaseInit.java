package com.albedo.java.common.core.annotation;


import java.lang.annotation.*;

/**
 * 初始化继承BaseInit的service
 * Created by somewhere on 2016/6/13.
 * <p>
 * afterPropertiesSet
 */
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface BaseInit {

	/**
	 * 指定方法
	 */
	String method() default "init";

}

