package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.core.vo.TreeUtil;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.albedo.java.common.persistence.service.TreeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.Data;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


/**
 * @author somewhere
 */
@Data
public class TreeServiceImpl<Repository extends TreeRepository<T>,
	T extends TreeEntity, D extends TreeDto>
	extends DataServiceImpl<Repository, T, D, String> implements TreeService<Repository, T, D>
	 {

	/**
	 * 构建树
	 *
	 * @param trees
	 * @return
	 */
	public Set<TreeNode> getNodeTree(List<T> trees) {
//		Collections.sort(trees, Comparator.comparing((T t) -> t.getSort()).reversed());
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




	@Override
	public Integer countByParentId(String parentId) {
		return repository.selectCount(
			new QueryWrapper<T>().eq(TreeEntity.F_SQL_PARENTID, parentId)
		);
	}
		 /**
		  * 查询全部部门树
		  *
		  * @return 树
		  */
		 @Override
		 @Transactional(readOnly = true, rollbackFor = Exception.class)
		 public <Q> Set<TreeNode> findTreeList(Q deptQueryCriteria) {
			 return getNodeTree(repository.selectList(QueryWrapperUtil.<T>getWrapper(deptQueryCriteria).orderByAsc(TreeEntity.F_SQL_SORT)));
		 }

		 @Override
	public List<T> findAllByParentIdsLike(String parentIds) {
		return repository.selectList(
			new QueryWrapper<T>().like(TreeEntity.F_SQL_PARENTIDS, parentIds));
	}

	@Override
	public List<T> findAllOrderBySort() {
		return repository.selectList(
			new QueryWrapper<T>()
				.orderByAsc(TreeEntity.F_SQL_SORT)
		);
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

}
