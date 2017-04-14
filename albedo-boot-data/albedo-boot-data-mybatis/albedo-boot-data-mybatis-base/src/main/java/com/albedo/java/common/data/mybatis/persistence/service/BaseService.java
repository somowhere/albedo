/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.data.mybatis.persistence.service;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * Service基类
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional
public abstract class BaseService<Repository extends BaseRepository<T, pk>, T extends BaseEntity, pk extends Serializable> {
	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());
	public  Repository repository;

	private Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public BaseService() {
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			persistentClass = (Class<T>) parameterizedType[0];
		}
	}

	public T save(T entity) {
		entity = repository.save(entity);
		log.debug("Save Information for Entity: {}", entity);
		return entity;
	}

	@Transactional(readOnly=true)
	public T findOne(pk id) {
		return repository.findOne(id);
	}

}
