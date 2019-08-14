package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

public interface DataService<Repository extends BaseRepository<T>, T extends DataEntity, PK extends Serializable>
	extends IService<T>, BaseService<Repository, T, PK> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findRelationOne(Serializable id);

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findPage(PageModel<T> pm);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findRelationPage(PageModel<T> pm);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findPage(PageModel<T> pm, List<QueryCondition> queryConditions);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findRelationPage(PageModel<T> pm, List<QueryCondition> queryConditions);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	PageModel<T> findPageQuery(PageModel<T> pm, List<QueryCondition> authQueryConditions, boolean isRelation);
}
