package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

public interface TreeService<Repository extends TreeRepository<T>,
	T extends TreeEntity, D extends TreeDto> extends DataService<Repository, T, D, String> {

	Integer countByParentId(String parentId);

	/**
	 * 查询树
	 * @return 树
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	<Q> Set<TreeNode> findTreeList(Q queryCriteria);

	List<T> findAllByParentIdsLike(String parentIds);

	List<T> findAllOrderBySort();

}
