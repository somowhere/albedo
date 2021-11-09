/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.plugins.mybatis.service;

import com.albedo.java.common.core.basic.domain.TreeEntity;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.plugins.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * TreeService
 *
 * @param <T>
 * @param <D>
 * @author somewhere
 */
public interface TreeService<T extends TreeEntity, D extends TreeDto> extends DataService<T, D> {

	/**
	 * 构建树
	 *
	 * @param trees
	 * @return
	 */
	default List<TreeNode> getNodeTree(List<T> trees) {
		List<TreeNode> treeList = trees.stream().map(tree -> {
			TreeNode node = new TreeNode();
			node.setId((Long) tree.getId());
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
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default <Q> List<TreeNode> findTreeNode(Q queryCriteria) {
		return getNodeTree(findTreeList(queryCriteria));
	}

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default <Q> List<T> findTreeList(Q queryCriteria) {
		return getRepository().selectList(QueryWrapperUtil.<T>getWrapper(queryCriteria).orderByAsc(TreeEntity.F_SQL_SORT));
	}

	/**
	 * 构建树Wrapper
	 *
	 * @param query
	 * @return
	 */
	default <Q> QueryWrapper<T> getTreeWrapper(Q query) {
		QueryWrapper<T> wrapper = QueryWrapperUtil.getWrapper(query);
		boolean emptyWrapper = wrapper.isEmptyOfWhere();
		if (emptyWrapper) {
			wrapper.eq(TreeEntity.F_SQL_PARENT_ID, TreeUtil.ROOT);
		}
		wrapper.eq(TreeEntity.F_SQL_DEL_FLAG, TreeEntity.FLAG_NORMAL).orderByAsc(TreeEntity.F_SQL_SORT);
		return wrapper;
	}

	default Long countByParentId(String parentId) {
		return getRepository().selectCount(Wrappers.<T>query().eq(TreeEntity.F_SQL_PARENT_ID, parentId));
	}

	default List<T> findAllByParentIdsLike(String parentIds) {
		return getRepository().selectList(Wrappers.<T>query().like(TreeEntity.F_SQL_PARENT_IDS, parentIds));
	}

	@Override
	default boolean saveOrUpdate(T entityDto) {
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = entityDto.getParentIds();
		if (entityDto.getParentId() != null) {
			T parent = getRepository().selectById(entityDto.getParentId());
			if (parent != null && ObjectUtil.isNotEmpty(parent.getId())) {
				parent.setLeaf(false);
				getRepository().updateById(parent);
				entityDto.setParentIds(
					StringUtil.toAppendStr(parent.getParentIds(), parent.getId(), StringUtil.SPLIT_DEFAULT));
			}
		} else {
			entityDto.setParentId(TreeUtil.ROOT);
		}

		if (ObjectUtil.isNotEmpty(entityDto.getId())) {
			Long count = countByParentId((String) entityDto.getId());
			entityDto.setLeaf(count == null || count == 0);
		} else {
			entityDto.setLeaf(true);
		}
		boolean flag = StringUtil.isNotEmpty((String) entityDto.getId()) ? this.updateById(entityDto) : this.save(entityDto);
		if (ObjectUtil.isNotEmpty(oldParentIds)) {
			// 更新子节点 parentIds
			List<T> list = findAllByParentIdsLike((String) entityDto.getId());
			for (T e : list) {
				if (StringUtil.isNotEmpty(e.getParentIds())) {
					e.setParentIds(e.getParentIds().replace(oldParentIds, entityDto.getParentIds()));
				}
			}
			if (ObjectUtil.isNotEmpty(list)) {
				updateBatchById(list);
			}
		}
		return flag;
	}

	@Override
	default boolean removeByIds(Collection<? extends Serializable> idList) {
		idList.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<T> menuList = this.list(Wrappers.<T>query().eq(TreeEntity.F_SQL_PARENT_ID, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new BizException("含有下级不能删除");
			}
			Assert.isTrue(this.removeById(id), "删除失败");
		});
		return true;
	}

}
