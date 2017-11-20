package com.albedo.java.common.data.persistence.service;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.common.data.persistence.repository.JpaCustomeRepository;
import com.albedo.java.common.domain.base.BaseEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

@Transactional
public class BaseService<Repository extends BaseRepository<T, PK>, T extends BaseEntity, PK extends Serializable> {
    public final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    public JpaCustomeRepository<T> baseRepository;
    @Autowired
    public Repository repository;

    private Class<T> persistentClass;

    @SuppressWarnings("unchecked")
    public BaseService() {
        Class<?> c = getClass();
        Type type = c.getGenericSuperclass();
        if (type instanceof ParameterizedType) {
            Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
            if (parameterizedType[1] instanceof Class) {
                persistentClass = (Class<T>) parameterizedType[1];
            }
        }
    }

    public T save(T entity) {
        entity = repository.save(entity);
        log.debug("Save Information for Entity: {}", entity);
        return entity;
    }

    public Iterable<T> save(Iterable<T> entitys) {
        entitys.forEach(item -> save(item));
        return entitys;
    }

    public List<T> findAll(){
        return repository.findAll();
    }

    public Class<T> getPersistentClass() {
        return persistentClass;
    }

    public void setPersistentClass(Class<T> persistentClass) {
        this.persistentClass = persistentClass;
    }
}
