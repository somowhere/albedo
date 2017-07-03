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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.mybatis.repository.annotation.Basic;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.mybatis.repository.annotation.Query.Operation;
import org.springframework.data.mybatis.repository.query.MybatisQueryExecution.*;
import org.springframework.data.repository.query.ParametersParameterAccessor;
import org.springframework.data.repository.query.RepositoryQuery;
import org.springframework.data.repository.query.ResultProcessor;
import org.springframework.data.repository.query.ReturnedType;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import static org.springframework.data.mybatis.repository.annotation.Query.Operation.unknown;

/**
 * abstract mybatis query.
 *
 * @author Jarvis Song
 */
public abstract class AbstractMybatisQuery implements RepositoryQuery {

    protected final SqlSessionTemplate sqlSessionTemplate;
    protected final MybatisQueryMethod method;

    protected AbstractMybatisQuery(SqlSessionTemplate sqlSessionTemplate, MybatisQueryMethod method) {
        this.sqlSessionTemplate = sqlSessionTemplate;
        this.method = method;
    }

    @Override
    public Object execute(Object[] parameters) {
        return doExecute(getExecution(), parameters);
    }

    @Override
    public MybatisQueryMethod getQueryMethod() {
        return method;
    }

    private Object doExecute(MybatisQueryExecution execution, Object[] parameters) {

        Object result = execution.execute(this, parameters);

        ParametersParameterAccessor accessor = new ParametersParameterAccessor(method.getParameters(), parameters);
        ResultProcessor withDynamicProjection = method.getResultProcessor().withDynamicProjection(accessor);

        return withDynamicProjection.processResult(result, new TupleConverter(withDynamicProjection.getReturnedType()));
    }

    protected Class<?> getStatementParameterType() {
        Query annotation = method.getQueryAnnotation();
        if (null == annotation || null == annotation.parameterType()) {
            return Query.Unspecified.class;
        }
        return annotation.parameterType();
    }

    protected Class<?> getStatementReturnType() {
        Query annotation = method.getQueryAnnotation();
        if (null == annotation || null == annotation.returnType()) {
            return Query.Unspecified.class;
        }
        return annotation.returnType();
    }

    protected Operation getOperation() {
        Query annotation = method.getQueryAnnotation();
        if (null == annotation) {
            return null;
        }
        return annotation.operation();
    }

    protected String getStatementId() {
        return getNamespace() + "." + getStatementName();
    }

    protected String getCountStatementId() {
        return getNamespace() + ".count_" + getStatementName();
    }

    protected String getQueryForDeleteStatementId() {
        return getNamespace() + ".query_" + getStatementName();
    }

    protected String getNamespace() {
        Query annotation = method.getQueryAnnotation();
        if (null == annotation || StringUtils.isEmpty(annotation.namespace())) {
            return method.getEntityInformation().getJavaType().getName();
        }

        return annotation.namespace();
    }

    protected String getStatementId(String id) {
        return getNamespace() + "." + id;
    }

    protected String getStatementName() {
        Query annotation = method.getQueryAnnotation();
        if (null == annotation || StringUtils.isEmpty(annotation.value())) {
            return method.getName();
        }
        return annotation.value();
    }

    protected boolean isBasicQuery() {
        Basic basic = method.getBasicAnnotation();
        return null != basic;
    }

    public SqlSessionTemplate getSqlSessionTemplate() {
        return sqlSessionTemplate;
    }


    protected MybatisQueryExecution getExecution() {
        Operation operation = getOperation();
        if (null != operation && operation != unknown) {
            switch (operation) {
                case insert:
                    return new InsertExecution();
                case update:
                    return new UpdateExecution();
                case select_one:
                    return new SingleEntityExecution();
                case select_list:
                    return new CollectionExecution();
                case delete:
                    return new DeleteExecution();
                case page:
                    return new PagedExecution();
                case slice:
                    return new SlicedExecution();
                case stream:
                    return new StreamExecution();
                case unknown:
                    break;
            }
        }


        if (method.isStreamQuery()) {
            return new StreamExecution();
        } else if (method.isSliceQuery()) {
            return new SlicedExecution();
        } else if (method.isPageQuery()) {
            return new PagedExecution();
        } else if (method.isCollectionQuery()) {
            return new CollectionExecution();
        } else {
            return new SingleEntityExecution();
        }
    }


    static class TupleConverter implements Converter<Object, Object> {

        private final ReturnedType type;

        /**
         * Creates a new {@link TupleConverter} for the given {@link ReturnedType}.
         *
         * @param type must not be {@literal null}.
         */
        public TupleConverter(ReturnedType type) {

            Assert.notNull(type, "Returned type must not be null!");

            this.type = type;
        }

        private static boolean isIndexAsString(String source) {

            try {
                Integer.parseInt(source);
                return true;
            } catch (NumberFormatException o_O) {
                return false;
            }
        }

        /*
         * (non-Javadoc)
         * @see org.springframework.core.convert.converter.Converter#convert(java.lang.Object)
         */
        @Override
        public Object convert(Object source) {

            return source;

        }
    }


}
