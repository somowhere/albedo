package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.albedo.java.common.persistence.service.TreeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.Data;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;


/**
 * @param <Repository>
 * @param <T>
 * @param <D>
 * @author somewhere
 */
@Data
public class TreeServiceImpl<Repository extends TreeRepository<T>,
	T extends TreeEntity, D extends TreeDto>
	extends DataServiceImpl<Repository, T, D, String> implements TreeService<T, D> {

	/**
	 * 构建树
	 *
	 * @param trees
	 * @return
	 */
	public List<TreeNode> getNodeTree(List<T> trees) {
		List<TreeNode> treeList = trees.stream()
			.map(tree -> {
				TreeNode node = new TreeNode();
				node.setId(tree.getId());
				node.setParentId(tree.getParentId());
				node.setLabel(tree.getName());
				return node;
			}).collect(Collectors.toList());
		return TreeUtil.buildByLoopAutoRoot(treeList);
	}

	/**
	 * 查询全部部门树
	 *
	 * @return 树
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public <Q> List<TreeNode> findTreeNode(Q queryCriteria) {
		return getNodeTree(findTreeList(queryCriteria));
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public <Q> List<T> findTreeList(Q queryCriteria) {
		return repository.selectList(QueryWrapperUtil.
			<T>getWrapper(queryCriteria).orderByAsc(TreeEntity.F_SQL_SORT));
	}

	/**
	 * 构建树Wrapper
	 *
	 * @param query
	 * @return
	 */
	@Override
	public <Q> QueryWrapper<T> getTreeWrapper(Q query) {
		QueryWrapper<T> wrapper = QueryWrapperUtil.getWrapper(query);
		boolean emptyWrapper = wrapper.isEmptyOfWhere();
		if (emptyWrapper) {
			wrapper.eq(TreeEntity.F_SQL_PARENT_ID, TreeUtil.ROOT);
		}
		wrapper.eq(TreeEntity.F_SQL_DEL_FLAG, TreeEntity.FLAG_NORMAL).orderByAsc(TreeEntity.F_SQL_SORT);
		return wrapper;
	}


	@Override
	public Integer countByParentId(String parentId) {
		return repository.selectCount(
			Wrappers.<T>query().eq(TreeEntity.F_SQL_PARENT_ID, parentId)
		);
	}


	@Override
	public List<T> findAllByParentIdsLike(String parentIds) {
		return repository.selectList(
			Wrappers.<T>query().like(TreeEntity.F_SQL_PARENT_IDS, parentIds));
	}


	@Override
	public boolean saveOrUpdate(T entityDto) {
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = entityDto.getParentIds();
		if (entityDto.getParentId() != null) {
			T parent = repository.selectById(entityDto.getParentId());
			if (parent != null && ObjectUtil.isNotEmpty(parent.getId())) {
				parent.setLeaf(false);
				super.updateById(parent);
				entityDto.setParentIds(StringUtil.toAppendStr(parent.getParentIds(), parent.getId(), StringUtil.SPLIT_DEFAULT));
			}
		} else {
			entityDto.setParentId(TreeUtil.ROOT);
		}

		if (ObjectUtil.isNotEmpty(entityDto.getId())) {
			Integer count = countByParentId(entityDto.getId());
			entityDto.setLeaf(count == null || count == 0);
		} else {
			entityDto.setLeaf(true);
		}
		boolean flag = super.saveOrUpdate(entityDto);
		if (ObjectUtil.isNotEmpty(oldParentIds)) {
			// 更新子节点 parentIds
			List<T> list = findAllByParentIdsLike(entityDto.getId());
			for (T e : list) {
				if (StringUtil.isNotEmpty(e.getParentIds())) {
					e.setParentIds(e.getParentIds().replace(oldParentIds, entityDto.getParentIds()));
				}
			}
			if (ObjectUtil.isNotEmpty(list)) {
				super.updateBatchById(list);
			}
		}
		log.debug("Save Information for T: {}", entityDto);
		return flag;
	}


	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		idList.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<T> menuList = this.list(Wrappers.<T>query().eq(TreeEntity.F_SQL_PARENT_ID, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new BadRequestException("含有下级不能删除");
			}
			Assert.isTrue(this.removeById(id), "删除失败");
		});
		return true;
	}
}
