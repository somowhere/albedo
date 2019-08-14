package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeResult;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

public interface TreeService<Repository extends TreeRepository<T>, T extends TreeEntity>
	extends IService<T>, BaseService<Repository, T, String>,
	DataService<Repository, T, String> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findTreeOne(Serializable id);

	Integer countByParentId(String parentId);


	List<T> findAllByParentIdsLike(String parentIds);

	List<T> findAllByParentId(String parentId);

	List<T> findTop1ByParentIdOrderBySortDesc(String parentId);

	List<T> findAllOrderBySort();

	List<T> findAllByIdOrParentIdsLike(String id, String likeParentIds);

	@Override
	boolean saveOrUpdate(T entity);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TreeResult> findTreeData(TreeQuery query);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Integer countTopByParentId(String parentId);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	T findTopByParentId(String parentId);

	void deleteByParentIds(List<String> ids);

	void deleteByParentIds(String id);
}
