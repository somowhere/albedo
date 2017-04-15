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

package org.springframework.data.mybatis.repository.support;

import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.Predicate;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;

import java.io.Serializable;

/**
 * query dsl repository, but now we can not support this type.
 *
 * @author Jarvis Song
 */
public class QueryDslMybatisRepository<T, ID extends Serializable> extends SimpleMybatisRepository<T, ID> implements QueryDslPredicateExecutor<T> {


    public QueryDslMybatisRepository(MybatisEntityInformation<T, ID> entityInformation, SqlSessionTemplate sqlSessionTemplate) {
        super(entityInformation, sqlSessionTemplate);
        throw new UnsupportedOperationException("unsupported QueryDsl Repository...");
    }

    @Override
    public T findOne(Predicate predicate) {
        return null;
    }

    @Override
    public Iterable<T> findAll(Predicate predicate) {
        return null;
    }

    @Override
    public Iterable<T> findAll(Predicate predicate, Sort sort) {
        return null;
    }

    @Override
    public Iterable<T> findAll(Predicate predicate, OrderSpecifier<?>... orders) {
        return null;
    }

    @Override
    public Iterable<T> findAll(OrderSpecifier<?>... orders) {
        return null;
    }

    @Override
    public Page<T> findAll(Predicate predicate, Pageable pageable) {
        return null;
    }

    @Override
    public long count(Predicate predicate) {
        return 0;
    }

    @Override
    public boolean exists(Predicate predicate) {
        return false;
    }
}
