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

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Default implementation of the {@link org.springframework.data.repository.CrudRepository} interface.
 *
 * @author Jarvis Song
 */
@Repository
@Transactional(readOnly = true)
public class SimpleMybatisRepository<T, ID extends Serializable> extends SqlSessionRepositorySupport
        implements MybatisRepository<T, ID> {

    private static final String STATEMENT_INSERT = "_insert";
    private static final String STATEMENT_UPDATE = "_update";
    private static final String STATEMENT_UPDATE_IGNORE_NULL = "_updateIgnoreNull";
    private static final String STATEMENT_GET_BY_ID = "_getById";
    private static final String STATEMENT_DELETE_BY_ID = "_deleteById";

    private final MybatisEntityInformation<T, ID> entityInformation;
    private AuditorAware<Long> auditorAware;

    public SimpleMybatisRepository(
            MybatisEntityInformation<T, ID> entityInformation,
            SqlSessionTemplate sqlSessionTemplate) {
        super(sqlSessionTemplate);
        this.entityInformation = entityInformation;
    }

    @Override
    protected String getNamespace() {
        return entityInformation.getJavaType().getName();
    }

    @Override
    @Transactional
    public <S extends T> S insert(S entity) {
        entityInformation.setCreatedDate(entity);
        entityInformation.setCreatedBy(entity);
        entityInformation.setLastModifiedBy(entity);
        entityInformation.setLastModifiedDate(entity);
        entityInformation.preInssert(entity);
        if (entityInformation.hasVersion()) {
            entityInformation.setVersion(entity, 0);
        }


        insert(STATEMENT_INSERT, entity);
        return entity;
    }

    @Override
    @Transactional
    public <S extends T> S update(S entity) {
        entityInformation.setLastModifiedDate(entity);
        entityInformation.setLastModifiedBy(entity);
        entityInformation.preUpdate(entity);
        int row = update(STATEMENT_UPDATE, entity);
        if (row == 0) {
            throw new MybatisNoHintException("update effect 0 row, maybe version control lock occurred.");
        }
        if (entityInformation.hasVersion()) {
            entityInformation.increaseVersion(entity);
        }
        return entity;
    }

    @Override
    @Transactional
    public <S extends T> S updateIgnoreNull(S entity) {
        entityInformation.setLastModifiedDate(entity);
        entityInformation.setLastModifiedBy(entity);
        entityInformation.preUpdate(entity);
        int row = update(STATEMENT_UPDATE_IGNORE_NULL, entity);
        if (row == 0) {
            throw new MybatisNoHintException("update effect 0 row, maybe version control lock occurred.");
        }
        if (entityInformation.hasVersion()) {
            entityInformation.increaseVersion(entity);
        }
        return entity;
    }

    @Override
    @Transactional
    public <S extends T> S save(S entity) {
        Assert.notNull(entity, "entity can not be null");
        if (entityInformation.isNew(entity)) {
            // insert
            insert(entity);
        } else {
            // update
            update(entity);
        }
        return entity;
    }

    @Override
    @Transactional
    public <S extends T> S saveIgnoreNull(S entity) {
        Assert.notNull(entity, "entity can not be null");

        if (entityInformation.isNew(entity)) {
            // insert
            insert(entity);
        } else {
            // update
            updateIgnoreNull(entity);
        }
        return entity;
    }

    @Override
    public T findOne(ID id) {
        Assert.notNull(id, "id can not be null");
        return selectOne(STATEMENT_GET_BY_ID, id);
    }

    @Override
    public T findBasicOne(ID id, String... columns) {
        Assert.notNull(id);
        return selectOne("_getBasicById", id);
    }

    @Override
    public boolean exists(ID id) {
        return null != findOne(id);
    }

    @Override
    public long count() {
        return selectOne("_count");
    }

    @Override
    @Transactional
    public void delete(ID id) {
        Assert.notNull(id);
        super.delete(STATEMENT_DELETE_BY_ID, id);
    }

    @Override
    @Transactional
    public void delete(T entity) {
        Assert.notNull(entity);

        delete(entityInformation.getId(entity));
    }

    @Override
    @Transactional
    public void delete(Iterable<? extends T> entities) {
        if (null == entities) {
            return;
        }
        for (T entity : entities) {
            delete(entity);
        }
    }

    @Override
    @Transactional
    public void deleteAll() {
        super.delete("_deleteAll");
    }


    @Override
    public List<T> findAll() {
        return findAll((T) null);
    }

    @Override
    public List<T> findAll(Sort sort) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_sorts", sort);
        return selectList("_findAll", params);
    }

    @Override
    public List<T> findAll(Iterable<ID> ids) {
        if (null == ids) {
            return Collections.emptyList();
        }

        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("_ids", ids);
        return selectList("_findAll", params);
    }

    @Override
    @Transactional
    public <S extends T> List<S> save(Iterable<S> entities) {
        if (null == entities) return Collections.emptyList();
        for (S entity : entities) {
            save(entity);
        }
        return (List<S>) entities;
    }

    @Override
    public <S extends T> List<S> findAll(Example<S> example) {
        return null;
    }

    @Override
    public <S extends T> List<S> findAll(Example<S> example, Sort sort) {
        return null;
    }

    @Override
    public <S extends T> S findOne(Example<S> example) {
        return null;
    }

    @Override
    public <S extends T> Page<S> findAll(Example<S> example, Pageable pageable) {
        return null;
    }

    @Override
    public <S extends T> long count(Example<S> example) {
        return 0;
    }

    @Override
    public <S extends T> boolean exists(Example<S> example) {
        return false;
    }

    @Override
    public Page<T> findAll(Pageable pageable) {
        if (null == pageable) {
            return new PageImpl<T>(findAll());
        }
        return findAll(pageable, null);
    }

    @Override
    public <X extends T> T findOne(X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectOne("_findAll", params);
    }

    @Override
    public <X extends T> List<T> findAll(X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList("_findAll", params);
    }

    @Override
    public <X extends T> List<T> findAll(Sort sort, X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        params.put("_sorts", sort);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList("_findAll", params);
    }

    @Override
    public <X extends T> Page<T> findAll(Pageable pageable, X condition, String... columns) {
        Map<String, Object> otherParam = new HashMap<String, Object>();
        if (null != columns) {
            otherParam.put("_specifiedFields", columns);
        }
        return findByPager(pageable, "_findByPager", "_countByCondition", condition, otherParam);
    }

    @Override
    public <X extends T> Long countAll(X condition) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        return selectOne("_countByCondition", params);
    }

    @Override
    public T findOne(boolean isBasic, Map<String, Object> paramsMap, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.putAll(paramsMap);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectOne(isBasic ? "_findBasicAll" : "_findAll", params);
    }

    @Override
    public List<T> findAll(boolean isBasic, Map<String, Object> paramsMap, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.putAll(paramsMap);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList(isBasic ? "_findBasicAll" : "_findAll", params);
    }

    @Override
    public List<T> findAll(boolean isBasic, Sort sort, Map<String, Object> paramsMap, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.putAll(paramsMap);
        params.put("_sorts", sort);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList(isBasic ? "_findBasicAll" : "_findAll", params);
    }

    @Override
    public Page<T> findAll(boolean isBasic, Pageable pageable, Map<String, Object> paramsMap, String... columns) {
        return findByPager(pageable, isBasic ? "_findBasicByPager" : "_findByPager",
                isBasic ? "_countBasicByCondition" : "_countByCondition", null, paramsMap, columns);

    }

    @Override
    public Page<T> findAll(String selectStatement, String countStatement, Pageable pageable, Map<String, Object> paramsMap, String... columns) {
        return findByPager(pageable, selectStatement, countStatement, null, paramsMap, columns);

    }

    @Override
    public Long countAll(boolean isBasic, Map<String, Object> paramsMap) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.putAll(paramsMap);
        return selectOne(isBasic ? "_countBasicByCondition" : "_countByCondition", params);
    }


    @Override
    public <X extends T> T findBasicOne(X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectOne("_findBasicAll", params);
    }

    @Override
    public <X extends T> List<T> findBasicAll(X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList("_findBasicAll", params);
    }

    @Override
    public <X extends T> List<T> findBasicAll(Sort sort, X condition, String... columns) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        params.put("_sorts", sort);
        if (null != columns) {
            params.put("_specifiedFields", columns);
        }
        return selectList("_findBasicAll", params);
    }

    @Override
    public <X extends T> Page<T> findBasicAll(Pageable pageable, X condition, String... columns) {
        return findByPager(pageable, "_findBasicByPager", "_countBasicByCondition", condition, columns);
    }

    @Override
    public <X extends T> Long countBasicAll(X condition) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        return selectOne("_countBasicByCondition", params);
    }

    @Override
    @Transactional
    public <X extends T> int deleteByCondition(X condition) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("_condition", condition);
        return super.delete("_deleteByCondition", params);
    }

    @Override
    @Transactional
    public void deleteInBatch(Iterable<T> entities) {
        //FIXME improve delete in batch
        delete(entities);
    }
}
