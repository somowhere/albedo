/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.QueryUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.Order;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.PageQuery;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Service基类
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
public abstract class BaseServiceImpl<Repository extends BaseRepository<T>,
	T extends GeneralEntity, pk extends Serializable> extends ServiceImpl<Repository, T> implements com.albedo.java.common.persistence.service.BaseService<Repository, T, pk> {
	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());
	@Autowired
	public Repository repository;
	private Class<T> persistentClass;
	private String classNameProfix;


	@SuppressWarnings("unchecked")
	public BaseServiceImpl() {
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			persistentClass = (Class<T>) parameterizedType[1];
		}

	}

	@Override
	public Class<T> getPersistentClass() {
		return persistentClass;
	}

	@Override
	public String getClassNameProfix() {
		if (persistentClass != null && StringUtil.isEmpty(classNameProfix)) {
			classNameProfix = StringUtil.lowerFirst(persistentClass.getSimpleName()) + ".";
		}
		return classNameProfix;
	}

	@Override
	public String getClassNameProfix(String property) {
		return String.format("%s%s", getClassNameProfix(), property);
	}


	@Override
	public QueryWrapper<T> createEntityWrapper(List<Order> orders, QueryCondition... queryConditions) {

		return DynamicSpecifications.
			bySearchQueryCondition(getPersistentClass(), queryConditions).setOrders(orders)
			.toEntityWrapper();
	}

	@Override
	public QueryWrapper<T> createEntityWrapper(List<QueryCondition> queryConditions) {
		return DynamicSpecifications.
			bySearchQueryCondition(getPersistentClass(), queryConditions)
			.toEntityWrapper();
	}

	@Override
	public QueryWrapper<T> createEntityWrapper(QueryCondition... queryConditions) {
		return createEntityWrapper(null, queryConditions);
	}


	@Override
	public boolean doCheckWithEntity(T entity, Map<String, QueryCondition.Operator> maps) {
		boolean rs = false;
		if (ObjectUtil.isNotEmpty(entity)) {
			List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps);
			QueryWrapper<T> entityWrapper = createEntityWrapper(conditionList);
			Integer obj = countBasicAll(entityWrapper);
			if (obj == null || obj == 0) {
				rs = true;
			}
		}
		return rs;
	}

	@Override
	public boolean doCheckByProperty(T entity) {
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_ID, QueryCondition.Operator.ne);
			maps.put(BaseEntity.F_DELFLAG, QueryCondition.Operator.ne);
			BeanUtil.setProperty(entity, BaseEntity.F_DELFLAG, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			log.error("{}", e);
		}
		return doCheckWithEntity(entity, maps);

	}

	@Override
	public boolean doCheckByPK(T entity) {
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_DELFLAG, QueryCondition.Operator.ne);
			BeanUtil.setProperty(entity, BaseEntity.F_DELFLAG, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			log.error("{}", e);
		}
		return doCheckWithEntity(entity, maps);
	}


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findTopOne(Wrapper<T> wrapper) {
		return findOne(wrapper, 1);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findOne(Wrapper<T> wrapper, int max) {
		IPage<T> iPage = repository.selectPage(new PageQuery(0, max), wrapper);
		return iPage != null && CollUtil.isNotEmpty(iPage.getRecords()) ? iPage.getRecords().get(0) : null;
	}

	@Override
	public List<T> findAll() {
		return repository.selectList(null);
	}

	@Override
	public List<T> findAll(Map<String, Object> paramsMap) {
		return repository.selectByMap(paramsMap);
	}

	@Override
	public Integer countBasicAll(Wrapper<T> wrapper) {
		return repository.selectCount(wrapper);
	}

	@Override
	public List<Sort.Order> toOrders(List<Order> orders) {
		List<Sort.Order> orderList = Lists.newArrayList();
		if (CollUtil.isEmpty(orders)) {
			return orderList;
		}
		for (Order order : orders) {
			if (order == null) {
				continue;
			}
			String property = order.getProperty();
			Order.Direction direction = order.getDirection();
			if (StringUtil.isEmpty(property) || direction == null) {
				continue;
			}
			orderList.add(new Sort.Order(direction.equals(Order.Direction.asc) ?
				Sort.Direction.ASC : Sort.Direction.DESC, property));
		}
		return orderList;
	}


	/**
	 * 动态集合查询
	 *
	 * @param specificationDetail 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Integer count(SpecificationDetail specificationDetail) {
		return repository.selectCount(specificationDetail.toEntityWrapper(getPersistentClass()));
	}

	/**
	 * 动态集合查询
	 *
	 * @param specificationDetail 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<T> findAll(SpecificationDetail specificationDetail) {
		return findAll(specificationDetail.toEntityWrapper(getPersistentClass()));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<T> findAll(Wrapper<T> wrapper) {
		return repository.selectList(wrapper);
	}

	@Override
	public PageModel<T> findPage(PageModel<T> pm) {
		return findPage(pm, DynamicSpecifications.buildSpecification(
			getPersistentClass(),
			pm.getQueryConditionJson()
		));
	}

	/**
	 * 动态分页查询
	 *
	 * @param pm                  分页对象
	 * @param specificationDetail 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findPage(PageModel<T> pm, SpecificationDetail<T> specificationDetail) {
		if (specificationDetail != null) {
			return findPageWrapper(pm, specificationDetail.toEntityWrapper(getPersistentClass()));
		}
		return findPageWrapper(pm, null);

	}

	/**
	 * 动态分页查询
	 *
	 * @param pm      分页对象
	 * @param wrapper 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findPageWrapper(PageModel<T> pm, Wrapper<T> wrapper) {
		IPage<T> tiPage = baseMapper.selectPage(pm, wrapper);
		return (PageModel<T>) tiPage;
	}

	/**
	 * 动态分页查询
	 *
	 * @param pm                  分页对象
	 * @param specificationDetail 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findRelationPage(PageModel<T> pm, SpecificationDetail<T> specificationDetail) {
		if (specificationDetail != null) {
			specificationDetail.setRelationQuery(true);
			return findRelationPageWrapper(pm, specificationDetail.toEntityWrapper(getPersistentClass()));
		}
		return findRelationPageWrapper(pm, null);

	}

	/**
	 * 动态分页查询
	 *
	 * @param pm      分页对象
	 * @param wrapper 动态条件对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findRelationPageWrapper(PageModel<T> pm, Wrapper<T> wrapper) {
		IPage<T> relationPage = repository.findRelationPage(pm, wrapper);
		return (PageModel<T>) relationPage;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Optional<T> findById(pk id) {
		return Optional.ofNullable(repository.selectById(id));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findOneById(pk id) {
		return repository.selectById(id);
	}

	@Override
	public long findCount() {
		return repository.selectCount(null);
	}

	@Override
	public long findCount(SpecificationDetail<T> specificationDetail) {
		return repository.selectCount(specificationDetail.toEntityWrapper(persistentClass));
	}

	@Override
	public T findOne(Wrapper<T> queryWrapper) {
		return repository.selectOne(queryWrapper);
	}

	@Override
	public List<T> findListByIds(Collection<pk> ids) {
		return repository.selectBatchIds(ids);
	}

	@Override
	public Integer deleteBatchIds(Collection<pk> ids) {
		return repository.deleteBatchIds(ids);
	}

	/**
	 * 逻辑删除
	 *
	 * @param id
	 * @return
	 */
	@Override
	public void deleteById(pk id) {
		repository.deleteById(id);
	}

	@Override
	public Integer deleteAll() {
		return repository.delete(null);
	}
}
