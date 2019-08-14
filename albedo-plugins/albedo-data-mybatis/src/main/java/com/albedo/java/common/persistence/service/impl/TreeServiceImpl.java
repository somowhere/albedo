package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeResult;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.repository.TreeRepository;
import com.albedo.java.common.persistence.service.TreeService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.List;


@Transactional
public abstract class TreeServiceImpl<Repository extends TreeRepository<T>,
	T extends TreeEntity>
	extends DataServiceImpl<Repository, T, String> implements TreeService<Repository, T> {


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findTreeOne(Serializable id) {
		List<T> treeList = repository.findRelationList(
			new QueryWrapper<T>().eq(getClassNameProfix() + TreeEntity.F_SQL_ID, id));
		return CollUtil.getObject(treeList);
	}

	@Override
	public Integer countByParentId(String parentId) {
		return repository.selectCount(
			new QueryWrapper<T>().eq(TreeEntity.F_SQL_PARENTID, parentId)
		);
	}

	@Override
	public List<T> findAllByParentIdsLike(String parentIds) {
		return repository.findRelationList(
			new QueryWrapper<T>().like(getClassNameProfix() + TreeEntity.F_SQL_PARENTIDS, parentIds));
	}

	@Override
	public List<T> findAllByParentId(String parentId) {
		return repository.findRelationList(
			new QueryWrapper<T>().eq(getClassNameProfix() + TreeEntity.F_SQL_PARENTID, parentId)
		);

	}

	@Override
	public List<T> findTop1ByParentIdOrderBySortDesc(String parentId) {

		return repository.findRelationList(
			new QueryWrapper<T>().eq(getClassNameProfix() + TreeEntity.F_SQL_PARENTID, parentId)
		);

	}

	@Override
	public List<T> findAllOrderBySort() {
		return repository.findRelationList(
			new QueryWrapper<T>()
				.orderByAsc(getClassNameProfix() + TreeEntity.F_SQL_SORT)
		);
	}

	@Override
	public List<T> findAllByIdOrParentIdsLike(String id, String likeParentIds) {
		return repository.findRelationList(
			new QueryWrapper<T>().likeRight(getClassNameProfix() + TreeEntity.F_SQL_PARENTIDS, likeParentIds).or()
				.eq(getClassNameProfix() + TreeEntity.F_SQL_ID, id)
		);
	}

	@Override
	public boolean saveOrUpdate(T entity) {
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = entity.getParentIds();
		if (entity.getParentId() != null) {
			T parent = repository.selectById(entity.getParentId());
			if (parent != null && ObjectUtil.isNotEmpty(parent.getId())) {
				parent.setLeaf(false);
				super.updateById(parent);
				entity.setParentIds(StringUtil.toAppendStr(parent.getParentIds(), parent.getId(), StringUtil.SPLIT_DEFAULT));
			}
		} else {
			entity.setParentId(TreeEntity.ROOT);
		}

		if (ObjectUtil.isNotEmpty(entity.getId())) {
			Integer count = countByParentId(entity.getId());
			entity.setLeaf(count == null || count == 0);
		} else {
			entity.setLeaf(true);
		}
//        checkSave(domain);
		boolean flag = super.saveOrUpdate(entity);
		if (ObjectUtil.isNotEmpty(oldParentIds)) {
			// 更新子节点 parentIds
			List<T> list = findAllByParentIdsLike(entity.getId());
			for (T e : list) {
				if (StringUtil.isNotEmpty(e.getParentIds())) {
					e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
				}
			}
			if (ObjectUtil.isNotEmpty(list)) {
				super.updateBatchById(list);
			}
		}
		log.debug("Save Information for T: {}", entity);
		return flag;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TreeResult> findTreeData(TreeQuery query) {
		String extId = query != null ? query.getExtId() : null, all = query != null ? query.getAll() : null;
		List<TreeResult> mapList = Lists.newArrayList();
		List<T> list = findAll();
		TreeResult treeResult;
		for (T e : list) {
			if ((StringUtil.isEmpty(extId)
				|| StringUtil.isEmpty(e.getParentIds()) || (StringUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf(StringUtil.SPLIT_DEFAULT + extId + StringUtil.SPLIT_DEFAULT) == -1))
				&& (all != null)) {
				treeResult = new TreeResult();
				treeResult.setId(e.getId());
				treeResult.setPid(StringUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
				treeResult.setLabel(e.getName());
				treeResult.setKey(e.getName());
				treeResult.setValue(e.getId());
				mapList.add(treeResult);
			}
		}
		return mapList;
	}


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public T findTopByParentId(String parentId) {
		List<T> tempList = findTop1ByParentIdOrderBySortDesc(parentId);
		return CollUtil.getObject(tempList);
	}

	/**
	 * 逻辑删除，更新子节点
	 *
	 * @param ids
	 * @return
	 */
	@Override
	public void deleteByParentIds(List<String> ids) {
		Assert.notNull(ids, "ids 信息为空，操作失败");
		ids.forEach(id -> deleteByParentIds(id));
	}

	/**
	 * 逻辑删除，更新子节点
	 *
	 * @param id
	 * @return
	 */
	@Override
	public void deleteByParentIds(String id) {
		Assert.notNull(id, "id 信息为空，操作失败");
		T entity = repository.selectById(id);
		// 查询父节点为当前节点的节点
		List<T> entityList = this.findAllByParentId(id);
		if (CollUtil.isNotEmpty(entityList)) {
			throw new RuntimeMsgException("含有下级不能删除");
		}
		operateStatusById(id, entity.getParentIds());
	}

	public int operateStatusById(String id, String likeParentIds) {
		List<T> entityList = findAllByIdOrParentIdsLike(id, StringUtil.toAppendStr(likeParentIds, id, StringUtil.SPLIT_DEFAULT, "%"));
		Assert.notNull(id, "id 信息为空，操作失败");
		for (T entity : entityList) {
			repository.deleteById(entity.getId());

		}
		return entityList != null ? entityList.size() : 0;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Integer countTopByParentId(String parentId) {
		return countByParentId(parentId);
	}
}
