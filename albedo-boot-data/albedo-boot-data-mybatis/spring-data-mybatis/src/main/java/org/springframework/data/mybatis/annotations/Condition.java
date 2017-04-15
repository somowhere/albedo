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

package org.springframework.data.mybatis.annotations;

import org.springframework.data.repository.query.parser.Part.IgnoreCaseType;
import org.springframework.data.repository.query.parser.Part.Type;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
import static org.springframework.data.repository.query.parser.Part.IgnoreCaseType.NEVER;
import static org.springframework.data.repository.query.parser.Part.Type.SIMPLE_PROPERTY;

/**
 * Annotation to specify search condition.
 *
 * @author Jarvis Song
 */
@Target({METHOD, FIELD})
@Retention(RUNTIME)
public @interface Condition {

    String column() default "";

    String[] properties() default {};

    String alias() default "";

    Type type() default SIMPLE_PROPERTY;

    IgnoreCaseType ignoreCaseType() default NEVER;

}
