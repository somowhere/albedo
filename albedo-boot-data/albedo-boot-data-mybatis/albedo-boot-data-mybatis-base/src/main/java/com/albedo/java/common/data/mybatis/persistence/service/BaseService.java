/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.data.mybatis.persistence.service;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.data.mybatis.persistence.GeneralEntity;
import com.albedo.java.common.data.mybatis.persistence.SpecificationDetail;
import com.albedo.java.common.data.mybatis.persistence.data.JpaCustomeRepository;
import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.QueryUtil;
import com.albedo.java.util.base.Assert;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

/**
 * Service基类
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional
public abstract class BaseService<Repository extends BaseRepository<T, pk>, T extends GeneralEntity, pk extends Serializable> {
	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());
	@Autowired
	public  Repository repository;

	@Autowired
	JpaCustomeRepository<T> jpaCustomeRepository;

	public Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public BaseService() {
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			persistentClass = (Class<T>) parameterizedType[1];
		}

	}
	public boolean doCheckWithEntity(T entity, Map<String, QueryCondition.Operator> maps) {
		boolean rs = false;
		if (PublicUtil.isNotEmpty(entity)) {
			Map<String, Object> paramsMap = Maps.newHashMap();
			List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps);
			String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(conditionList,
					null,
					paramsMap);
			paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
			Long obj = countBasicAll(paramsMap);
			if (obj == null || obj == 0) {
				rs = true;
			}
		}
		return rs;
	}
	public boolean doCheckByProperty(T entity) {
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_ID, QueryCondition.Operator.ne);
			maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
			Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			log.error(e.toString());
		}
		return doCheckWithEntity(entity, maps);

	}

	public boolean doCheckByPK(T entity) {

		boolean rs = false;
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
			Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			log.error(e.toString());
		}
		return doCheckWithEntity(entity, maps);
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


	public T findBasicOne(Map<String, Object> paramsMap, String... columns) {
		return repository.findBasicOne(paramsMap, columns);
	}

	public List<T> findBasicAll(Map<String, Object> paramsMap, String... columns) {
		return repository.findBasicAll(paramsMap, columns);
	}

	public List<T> findBasicAll(Sort sort, Map<String, Object> paramsMap, String... columns) {
		return repository.findBasicAll(sort, paramsMap, columns);
	}

	public Page<T> findBasicAll(Pageable pageable, Map<String, Object> paramsMap, String... columns) {
		return repository.findBasicAll(pageable, paramsMap, columns);

	}

	public Long countBasicAll(Map<String, Object> paramsMap) {
		return repository.countBasicAll(paramsMap);
	}

	@Transactional(readOnly=true)
	public List<T> findAll(SpecificationDetail specificationDetail) {
		try {
			T entity = persistentClass.newInstance();
			specificationDetail.setPersistentClass(persistentClass);
			String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(specificationDetail.getAndQueryConditions(),
					specificationDetail.getOrQueryConditions(),
					Lists.newArrayList(DynamicSpecifications.MYBITS_SEARCH_PARAMS_MAP),
					entity.getParamsMap(), true);
			entity.setSqlConditionDsf(sqlConditionDsf);
			return repository.findBasicAll(new Sort(specificationDetail.getOrders()),entity);
		} catch (Exception e) {
			log.error(e.getMessage());
			Assert.buildException(e.getMessage());
		}
		return null;
	}
	@Transactional(readOnly=true)
	public PageModel<T> findBasePage(PageModel<T> pm, SpecificationDetail<T> specificationDetail) {
		try {
			Map<String, Object> paramsMap = Maps.newHashMap();
			String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(specificationDetail.getAndQueryConditions(),
					specificationDetail.getOrQueryConditions(),
					null,
					paramsMap, true);
			paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
			paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
			paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
			pm.setPageInstance(repository.findBasicAll(pm, paramsMap));
			return pm;
		} catch (Exception e) {
			log.error(e.getMessage());
			Assert.buildException(e.getMessage());
		}
		return null;
	}

}
