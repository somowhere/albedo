package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.persistence.domain.TreeEntity;

import java.util.List;

public interface TreeService<
	T extends TreeEntity, D extends TreeDto> extends DataService<T, D, String> {

	Integer countByParentId(String parentId);

	/**
	 * 查询树
	 *
	 * @return 树
	 */
	<Q> List<TreeNode> findTreeNode(Q queryCriteria);

	List<T> findAllByParentIdsLike(String parentIds);

}
