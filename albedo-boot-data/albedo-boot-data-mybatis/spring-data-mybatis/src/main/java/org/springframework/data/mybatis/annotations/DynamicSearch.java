package org.springframework.data.mybatis.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Created by lijie on 2017/4/15.
 */
@Documented
@Target(TYPE)
@Retention(RUNTIME)
public @interface DynamicSearch {
}
