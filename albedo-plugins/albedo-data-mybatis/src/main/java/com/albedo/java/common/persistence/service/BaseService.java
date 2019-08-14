package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.Order;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface BaseService<Repository extends BaseRepository<T>,
	T extends GeneralEntity, pk extends Serializable> extends IService<T> {
	Class<T> getPersistentClass();

	String getClassNameProfix();

	String getClassNameProfix(String property);

	QueryWrapper<T> createEntityWrapper(List<Order> orders, QueryCondition... queryConditions);

	QueryWrapper<T> createEntityWrapper(List<QueryCondition> queryConditions);

	QueryWrapper<T> createEntityWrapper(QueryCondition... queryConditions);

	boolean doCheckWithEntity(T entity, Map<String, QueryCondition.Operator> maps);

	boolean doCheckByProperty(T entity);

	boolean doCheckByPK(T entity);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findTopOne(Wrapper<T> wrapper);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findOne(Wrapper<T> wrapper, int max);

	List<T> findAll();

	List<T> findAll(Map<String, Object> paramsMap);

	Integer countBasicAll(Wrapper<T> wrapper);

	List<Sort.Order> toOrders(List<Order> orders);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Integer count(SpecificationDetail specificationDetail);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<T> findAll(SpecificationDetail specificationDetail);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<T> findAll(Wrapper<T> wrapper);

	PageModel<T> findPage(PageModel<T> pm);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findPage(PageModel<T> pm, SpecificationDetail<T> specificationDetail);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findPageWrapper(PageModel<T> pm, Wrapper<T> wrapper);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findRelationPage(PageModel<T> pm, SpecificationDetail<T> specificationDetail);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findRelationPageWrapper(PageModel<T> pm, Wrapper<T> wrapper);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Optional<T> findById(pk id);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findOneById(pk id);

	long findCount();

	long findCount(SpecificationDetail<T> specificationDetail);

	T findOne(Wrapper<T> queryWrapper);

	List<T> findListByIds(Collection<pk> ids);

	Integer deleteBatchIds(Collection<pk> ids);

	void deleteById(pk id);

	Integer deleteAll();
}
