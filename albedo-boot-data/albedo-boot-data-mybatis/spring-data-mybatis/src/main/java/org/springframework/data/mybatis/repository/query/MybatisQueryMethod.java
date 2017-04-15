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

package org.springframework.data.mybatis.repository.query;

import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.data.mybatis.repository.annotation.Basic;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.projection.ProjectionFactory;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.query.Parameters;
import org.springframework.data.repository.query.QueryMethod;
import org.springframework.util.Assert;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * the mybatis implementation of {@link QueryMethod}.
 *
 * @author Jarvis Song
 */
public class MybatisQueryMethod extends QueryMethod {

    private static final Set<Class<?>> NATIVE_ARRAY_TYPES;

    private final Method method;

    static {

        Set<Class<?>> types = new HashSet<Class<?>>();
        types.add(byte[].class);
        types.add(Byte[].class);
        types.add(char[].class);
        types.add(Character[].class);

        NATIVE_ARRAY_TYPES = Collections.unmodifiableSet(types);
    }


    /**
     * Creates a new {@link QueryMethod} from the given parameters. Looks up the correct query to use for following
     * invocations of the method given.
     *
     * @param method   must not be {@literal null}.
     * @param metadata must not be {@literal null}.
     * @param factory  must not be {@literal null}.
     */
    public MybatisQueryMethod(final Method method, RepositoryMetadata metadata, ProjectionFactory factory) {
        super(method, metadata, factory);

        Assert.notNull(method, "Method must not be null!");
        this.method = method;

        Assert.isTrue(!(isModifyingQuery() && getParameters().hasSpecialParameter()),
                String.format("Modifying method must not contain %s!", Parameters.TYPES));


    }

    @Override
    protected Parameters<?, ?> createParameters(Method method) {
        return new MybatisParameters(method);
    }

    @Override
    public MybatisParameters getParameters() {
        return (MybatisParameters) super.getParameters();
    }


    @Override
    public boolean isCollectionQuery() {
        return super.isCollectionQuery() && !NATIVE_ARRAY_TYPES.contains(method.getReturnType());
    }


    Class<?> getReturnType() {
        return method.getReturnType();
    }

    Query getQueryAnnotation() {
        return method.getAnnotation(Query.class);
    }

    Basic getBasicAnnotation() {
        return method.getAnnotation(Basic.class);
    }


    private <T> T getAnnotationValue(String attribute, Class<T> type) {
        return getMergedOrDefaultAnnotationValue(attribute, Query.class, type);
    }

    private <T> T getMergedOrDefaultAnnotationValue(String attribute, Class annotationType, Class<T> targetType) {

        Annotation annotation = AnnotatedElementUtils.findMergedAnnotation(method, annotationType);
        if (annotation == null) {
            return targetType.cast(AnnotationUtils.getDefaultValue(annotationType, attribute));
        }

        return targetType.cast(AnnotationUtils.getValue(annotation, attribute));
    }


}
