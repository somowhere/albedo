package com.albedo.java.common.annotation;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * bean中文名注解
 */
@Target({ METHOD, FIELD })
@Retention(RetentionPolicy.RUNTIME)
@Inherited
public @interface ApiAuthority {
}
