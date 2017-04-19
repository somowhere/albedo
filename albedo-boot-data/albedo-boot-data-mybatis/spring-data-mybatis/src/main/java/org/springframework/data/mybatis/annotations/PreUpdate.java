package org.springframework.data.mybatis.annotations;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * Created by lijie on 2017/4/19.
 */
@Target({METHOD})
@Retention(RUNTIME)
public @interface PreUpdate {
}
