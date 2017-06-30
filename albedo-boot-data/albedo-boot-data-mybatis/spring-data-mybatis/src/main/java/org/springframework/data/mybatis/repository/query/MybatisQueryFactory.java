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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.repository.query.EvaluationContextProvider;
import org.springframework.expression.spel.standard.SpelExpressionParser;

/**
 * the factory of mybatis query.
 *
 * @author Jarvis Song
 */
public enum MybatisQueryFactory {

    INSTANCE;
    private transient static final Logger LOG = LoggerFactory.getLogger(MybatisQueryFactory.class);
    private static final SpelExpressionParser PARSER = new SpelExpressionParser();

    AbstractMybatisQuery fromQueryAnnotation(SqlSessionTemplate sqlSessionTemplate, MybatisQueryMethod method, EvaluationContextProvider evaluationContextProvider) {
        LOG.debug("Looking up query for method {}", method.getName());

        Query query = method.getQueryAnnotation();
        if (null == query) {
            return null;
        }


        return fromMethodWithQueryString(sqlSessionTemplate, method, method.getQueryAnnotation(), evaluationContextProvider);
    }

    AbstractMybatisQuery fromMethodWithQueryString(SqlSessionTemplate sqlSessionTemplate, MybatisQueryMethod method, Query query,
                                                   EvaluationContextProvider evaluationContextProvider) {

        return new SimpleMybatisQuery(sqlSessionTemplate, method, query, evaluationContextProvider, PARSER);
    }
}
