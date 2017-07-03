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
import org.springframework.data.mybatis.mapping.MybatisMappingContext;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.data.projection.ProjectionFactory;
import org.springframework.data.repository.core.NamedQueries;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.query.EvaluationContextProvider;
import org.springframework.data.repository.query.QueryLookupStrategy;
import org.springframework.data.repository.query.QueryLookupStrategy.Key;
import org.springframework.data.repository.query.RepositoryQuery;
import org.springframework.util.Assert;

import java.lang.reflect.Method;

/**
 * mybatis implementation of {@link QueryLookupStrategy}.
 *
 * @author Jarvis Song
 */
public final class MybatisQueryLookupStrategy {

    private MybatisQueryLookupStrategy() {
    }

    public static QueryLookupStrategy create(
            MybatisMappingContext context,
            SqlSessionTemplate sqlSessionTemplate,
            Dialect dialect,
            Key key,
            EvaluationContextProvider evaluationContextProvider) {
        Assert.notNull(evaluationContextProvider, "EvaluationContextProvider must not be null!");
        switch (key != null ? key : Key.CREATE_IF_NOT_FOUND) {
            case CREATE:
                return new CreateQueryLookupStrategy(context, sqlSessionTemplate, dialect);
            case USE_DECLARED_QUERY:
                return new DeclaredQueryLookupStrategy(sqlSessionTemplate, evaluationContextProvider);
            case CREATE_IF_NOT_FOUND:
                return new CreateIfNotFoundQueryLookupStrategy(
                        new CreateQueryLookupStrategy(context, sqlSessionTemplate, dialect),
                        new DeclaredQueryLookupStrategy(sqlSessionTemplate, evaluationContextProvider));
            default:
                throw new IllegalArgumentException(String.format("Unsupported query lookup strategy %s!", key));
        }
    }

    private abstract static class AbstractQueryLookupStrategy implements QueryLookupStrategy {

        @Override
        public RepositoryQuery resolveQuery(Method method, RepositoryMetadata metadata, ProjectionFactory factory, NamedQueries namedQueries) {

            return resolveQuery(new MybatisQueryMethod(method, metadata, factory), namedQueries);
        }

        protected abstract RepositoryQuery resolveQuery(MybatisQueryMethod method, NamedQueries namedQueries);
    }

    private static class CreateQueryLookupStrategy extends AbstractQueryLookupStrategy {

        private final MybatisMappingContext context;
        private final SqlSessionTemplate sqlSessionTemplate;
        private final Dialect dialect;

        public CreateQueryLookupStrategy(MybatisMappingContext context, SqlSessionTemplate sqlSessionTemplate, Dialect dialect) {
            this.context = context;
            this.sqlSessionTemplate = sqlSessionTemplate;
            this.dialect = dialect;
        }

        @Override
        protected RepositoryQuery resolveQuery(MybatisQueryMethod method, NamedQueries namedQueries) {
            try {
                return new PartTreeMybatisQuery(context, sqlSessionTemplate, dialect, method);
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException(
                        String.format("Could not create query metamodel for method %s!", method.toString()), e);
            }
        }
    }

    private static class DeclaredQueryLookupStrategy extends AbstractQueryLookupStrategy {
        private final SqlSessionTemplate sqlSessionTemplate;
        private final EvaluationContextProvider evaluationContextProvider;

        private DeclaredQueryLookupStrategy(SqlSessionTemplate sqlSessionTemplate, EvaluationContextProvider evaluationContextProvider) {
            this.sqlSessionTemplate = sqlSessionTemplate;
            this.evaluationContextProvider = evaluationContextProvider;
        }

        @Override
        protected RepositoryQuery resolveQuery(MybatisQueryMethod method, NamedQueries namedQueries) {

            RepositoryQuery query = MybatisQueryFactory.INSTANCE.fromQueryAnnotation(sqlSessionTemplate, method, evaluationContextProvider);
            if (null != query) {
                return query;
            }
//            String name = method.getNamedQueryName();
//            if (namedQueries.hasQuery(name)) {
//                return MybatisQueryFactory.INSTANCE.fromMethodWithQueryString(sqlSessionTemplate, method, namedQueries.getQuery(name), evaluationContextProvider);
//            }
            throw new IllegalStateException(
                    String.format("Did neither find a NamedQuery nor an annotated query for method %s!", method));
        }
    }

    private static class CreateIfNotFoundQueryLookupStrategy extends AbstractQueryLookupStrategy {
        private final DeclaredQueryLookupStrategy lookupStrategy;
        private final CreateQueryLookupStrategy createStrategy;

        private CreateIfNotFoundQueryLookupStrategy(
                CreateQueryLookupStrategy createStrategy,
                DeclaredQueryLookupStrategy lookupStrategy) {
            this.lookupStrategy = lookupStrategy;
            this.createStrategy = createStrategy;
        }

        @Override
        protected RepositoryQuery resolveQuery(MybatisQueryMethod method, NamedQueries namedQueries) {
            try {
                return lookupStrategy.resolveQuery(method, namedQueries);
            } catch (IllegalStateException e) {
                return createStrategy.resolveQuery(method, namedQueries);
            }

        }
    }
}
