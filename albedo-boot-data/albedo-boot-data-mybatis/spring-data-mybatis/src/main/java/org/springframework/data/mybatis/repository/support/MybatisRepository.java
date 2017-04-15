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

import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.QueryByExampleExecutor;

import java.io.Serializable;
import java.util.List;

/**
 * Mybatis specific extension of {@link org.springframework.data.repository.Repository}.
 *
 * @author Jarvis Song
 */
@NoRepositoryBean
public interface MybatisRepository<T, ID extends Serializable>
        extends PagingAndSortingRepository<T, ID>, QueryByExampleExecutor<T> {

    <S extends T> S insert(S entity);

    <S extends T> S update(S entity);

    <S extends T> S updateIgnoreNull(S entity);

    <S extends T> S saveIgnoreNull(S entity);

    @Override
    <S extends T> List<S> save(Iterable<S> entities);

    @Override
    List<T> findAll();

    @Override
    List<T> findAll(Sort sort);

    @Override
    List<T> findAll(Iterable<ID> ids);

    @Override
    <S extends T> List<S> findAll(Example<S> example);

    @Override
    <S extends T> List<S> findAll(Example<S> example, Sort sort);

    T findBasicOne(ID id, String... columns);


    /***  Query with association ***/

    <X extends T> T findOne(X condition, String... columns);

    <X extends T> List<T> findAll(X condition, String... columns);

    <X extends T> List<T> findAll(Sort sort, X condition, String... columns);

    <X extends T> Page<T> findAll(Pageable pageable, X condition, String... columns);

    <X extends T> Long countAll(X condition);

    /*** Query with non association ***/

    <X extends T> T findBasicOne(X condition, String... columns);

    <X extends T> List<T> findBasicAll(X condition, String... columns);

    <X extends T> List<T> findBasicAll(Sort sort, X condition, String... columns);

    <X extends T> Page<T> findBasicAll(Pageable pageable, X condition, String... columns);

    <X extends T> Long countBasicAll(X condition);

    void deleteInBatch(Iterable<T> entities);

    <X extends T> int deleteByCondition(X condition);
}
