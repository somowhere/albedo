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

package org.springframework.data.support;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Persistable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mybatis.repository.support.MybatisRepository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;

import java.io.Serializable;
import java.util.List;

/**
 * * CRUD Basic Service.
 *
 * @param <R>  Repository
 * @param <T>  domain
 * @param <ID> primary key
 * @author Jarvis Song
 */
public abstract class AbstractCrudService<R extends MybatisRepository<T, ID>, T, ID extends Serializable> implements CrudService<T, ID> {

    protected final R repository;

    /**
     * 构造函数.
     *
     * @param repository 注入的Repository
     */
    public AbstractCrudService(R repository) {
        this.repository = repository;
    }

    protected R getRepository() {
        return repository;
    }

    /**
     * 失效缓存。需要子类复写。
     *
     * @param entity
     */
    protected void evictCache(T entity) {
    }

    /**
     * 是否使用了缓存, 子类可改写。默认不使用。
     *
     * @return
     */
    protected boolean useCache() {
        return false;
    }

    @Override
    @Transactional(readOnly = true)
    public T get(ID id) {
        Assert.notNull(id, "When you to get a entity with its primary key , you should make sure id is not null.");
        return repository.findOne(id);
    }

    @Override
    @Transactional(readOnly = true)
    public T getBasic(ID id) {
        Assert.notNull(id, "When you to get a entity with its primary key , you should make sure id is not null.");
        return repository.findBasicOne(id);
    }

    @Override
    @Transactional
    public void save(T entity) {
        Assert.notNull(entity, "Entity can not be null. [" + entity.getClass() + "]");
        if (useCache()) {
            if (entity instanceof Persistable && (null != ((Persistable) entity).getId())) {
                evictCache(getBasic((ID) ((Persistable) entity).getId()));
            } else {
                evictCache(entity);
            }
        }
        repository.save(entity);

        if (useCache()) {
            evictCache(entity);
        }
    }


    @Override
    @Transactional
    public void saveIgnoreNull(T entity) {
        Assert.notNull(entity, "Entity can not be null. [" + entity.getClass() + "]");
        if (useCache()) {
            if (entity instanceof Persistable && (null != ((Persistable) entity).getId())) {
                evictCache(getBasic((ID) ((Persistable) entity).getId()));
            } else {
                evictCache(entity);
            }
        }
        repository.saveIgnoreNull(entity);

        if (useCache()) {
            evictCache(entity);
        }
    }

    @Override
    @Transactional
    public void insert(T entity) {
        Assert.notNull(entity, "Entity can not be null. [" + entity.getClass() + "]");
        if (useCache()) {
            if (entity instanceof Persistable && (null != ((Persistable) entity).getId())) {
                evictCache(getBasic((ID) ((Persistable) entity).getId()));
            } else {
                evictCache(entity);
            }
        }
        repository.insert(entity);

        if (useCache()) {
            evictCache(entity);
        }
    }

    @Override
    @Transactional
    public void update(T entity) {
        Assert.notNull(entity, "Entity can not be null. [" + entity.getClass() + "]");
        if (useCache()) {
            if (entity instanceof Persistable && (null != ((Persistable) entity).getId())) {
                evictCache(getBasic((ID) ((Persistable) entity).getId()));
            } else {
                evictCache(entity);
            }
        }
        repository.update(entity);

        if (useCache()) {
            evictCache(entity);
        }
    }

    @Override
    @Transactional
    public void updateIgnore(T entity) {
        Assert.notNull(entity, "Entity can not be null. [" + entity.getClass() + "]");
        if (useCache()) {
            if (entity instanceof Persistable && (null != ((Persistable) entity).getId())) {
                evictCache(getBasic((ID) ((Persistable) entity).getId()));
            } else {
                evictCache(entity);
            }
        }
        repository.updateIgnoreNull(entity);

        if (useCache()) {
            evictCache(entity);
        }
    }

    @Override
    @Transactional
    public void delete(ID id) {
        Assert.notNull(id, "When you to delete a entity, the primary key of the entity can not be null.");
        if (useCache()) {
            T entity = getBasic(id);
            if (null != entity) {
                evictCache(entity);
            }
        }
        repository.delete(id);

    }

    @Override
    @Transactional
    public <X extends T> void delete(X condition) {
        Assert.notNull(condition, "When you to delete a entity, the condition of the entity can not be null.");
        doDelete(condition);
    }

    protected <X extends T> void doDelete(X condition) {
        if (useCache()) {
            List<T> list = findBasicAll(condition);
            if (!CollectionUtils.isEmpty(list)) {
                for (T entity : list) {
                    evictCache(entity);
                }

            }
        }
        repository.deleteByCondition(condition);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> Page<T> findAll(Pageable pageable, X condition, String... columns) {
        Assert.notNull(pageable, "When you find entities by pageable, pageable argument can not be null.");
        return repository.findAll(pageable, condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> List<T> findAll(X condition, String... columns) {
        return (List<T>) repository.findAll(condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> List<T> findAll(Sort sort, X condition, String... columns) {
        return (List<T>) repository.findAll(sort, condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> T findOne(X condition, String... columns) {
        return repository.findOne(condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> Page<T> findBasicAll(Pageable pageable, X condition, String... columns) {
        return repository.findBasicAll(pageable, condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> List<T> findBasicAll(X condition, String... columns) {
        return (List<T>) repository.findBasicAll(condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> List<T> findBasicAll(Sort sort, X condition, String... columns) {
        return (List<T>) repository.findBasicAll(sort, condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> T findBasicOne(X condition, String... columns) {
        return repository.findBasicOne(condition, columns);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> Long countBasicAll(X condition) {
        return repository.countBasicAll(condition);
    }

    @Override
    @Transactional(readOnly = true)
    public <X extends T> Long countAll(X condition) {
        return repository.countAll(condition);
    }
}
