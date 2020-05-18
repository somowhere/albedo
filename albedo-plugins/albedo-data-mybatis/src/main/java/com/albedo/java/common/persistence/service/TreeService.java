package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

/**
 * TreeService
 * @author somewhere
 * @param <T>
 * @param <D>
 */
public interface TreeService<T extends TreeEntity, D extends TreeDto> extends DataService<T, D, String> {
	/**
	 * countByParentId
	 * @param parentId
	 * @return
	 */
	Integer countByParentId(String parentId);

	/**
	 * getTreeWrapper
	 * @param query
	 * @param <Q>
	 * @return
	 */
	<Q> QueryWrapper<T> getTreeWrapper(Q query);
	/**
	 * findTreeNode
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	<Q> List<TreeNode> findTreeNode(Q queryCriteria);

	/**
	 * findAllByParentIdsLike
	 * @param parentIds
	 * @return
	 */
	List<T> findAllByParentIdsLike(String parentIds);

}
