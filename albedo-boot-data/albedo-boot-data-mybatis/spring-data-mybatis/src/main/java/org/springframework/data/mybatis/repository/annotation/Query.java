/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository.annotation;

import org.springframework.data.annotation.QueryAnnotation;

import java.lang.annotation.*;

import static org.springframework.data.mybatis.repository.annotation.Query.Operation.unknown;

/**
 * Annotated to named query.
 *
 * @author Jarvis Song
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
@QueryAnnotation
@Documented
public @interface Query {

    /**
     * statement name.
     *
     * @return
     */
    String value() default "";

    String namespace() default "";

    String sql() default "";

    Class<?> returnType() default Unspecified.class;

    Class<?> parameterType() default Unspecified.class;

    boolean basic() default true;

    Operation operation() default unknown;

    enum Operation {
        insert,
        update,
        select_one,
        select_list,
        delete,
        page,
        slice,
        stream,
        unknown
    }

    class Unspecified {
    }

}


