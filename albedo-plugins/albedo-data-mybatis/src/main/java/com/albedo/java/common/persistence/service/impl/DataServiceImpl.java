/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

/**
 * Service基类
 *
 * @author lj
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
public abstract class DataServiceImpl<Repository extends BaseRepository<T>, T extends DataEntity, PK extends Serializable>
	extends BaseServiceImpl<Repository, T, PK> implements com.albedo.java.common.persistence.service.DataService<Repository, T, PK> {


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findRelationOne(Serializable id) {
		List<T> relationList = repository.findRelationList(new QueryWrapper<T>().eq(getClassNameProfix() + DataEntity.F_SQL_ID, id));
		return CollUtil.getObject(relationList);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findPage(PageModel<T> pm) {
		return findPageQuery(pm, null, false);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findRelationPage(PageModel<T> pm) {
		return findPageQuery(pm, null, true);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
		return findPageQuery(pm, queryConditions, false);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findRelationPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
		return findPageQuery(pm, queryConditions, true);
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public PageModel<T> findPageQuery(PageModel<T> pm, List<QueryCondition> queryConditions, boolean isRelation) {
		SpecificationDetail<T> specificationDetail = DynamicSpecifications.buildSpecification(
			getPersistentClass(),
			pm.getQueryConditionJson()
		);
		if (CollUtil.isNotEmpty(queryConditions)) {
			specificationDetail.orAll(queryConditions);
		}
		return isRelation ? findRelationPage(pm, specificationDetail) : findPage(pm, specificationDetail);
	}

}
