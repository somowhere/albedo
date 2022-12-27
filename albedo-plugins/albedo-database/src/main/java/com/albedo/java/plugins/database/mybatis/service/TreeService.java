/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.plugins.database.mybatis.service;

import com.albedo.java.common.core.domain.TreeDo;
import com.albedo.java.common.core.domain.vo.TreeDto;
import com.albedo.java.common.core.domain.vo.TreeNode;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import lombok.SneakyThrows;
import org.springframework.transaction.annotation.Transactional;

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
public interface TreeService<T extends TreeDo, D extends TreeDto> extends DataService<T, D> {

	/**
	 * 构建树
	 *
	 * @param trees
	 * @return
	 */
	default List<TreeNode<?>> getNodeTree(List<T> trees) {
		List<TreeNode<?>> treeList = trees.stream().map(tree -> {
			TreeNode<?> node = new TreeNode<>();
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
	 * @param queryCriteria
	 * @return 树
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default <Q> List<TreeNode<?>> findTreeNode(Q queryCriteria) {
		return getNodeTree(findTreeList(queryCriteria));
	}

	/**
	 * findTreeList
	 *
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default <Q> List<T> findTreeList(Q queryCriteria) {
		return getRepository().selectList(QueryWrapperUtil.<T>getWrapper(queryCriteria).orderByAsc(TreeDo.F_SQL_SORT));
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
			wrapper.eq(TreeDo.F_SQL_PARENT_ID, TreeUtil.ROOT);
		}
		wrapper.eq(TreeDo.F_SQL_DEL_FLAG, TreeDo.FLAG_NORMAL).orderByAsc(TreeDo.F_SQL_SORT);
		return wrapper;
	}

	/**
	 * countByParentId
	 *
	 * @param parentId
	 * @return Long
	 */
	default Long countByParentId(String parentId) {
		return getRepository().selectCount(Wrappers.<T>query().eq(TreeDo.F_SQL_PARENT_ID, parentId));
	}

	/**
	 * findAllByParentIdsLike
	 *
	 * @param parentIds
	 * @return List<T>
	 */
	default List<T> findAllByParentIdsLike(String parentIds) {
		return getRepository().selectList(Wrappers.<T>query().like(TreeDo.F_SQL_PARENT_IDS, parentIds));
	}

	/**
	 * saveOrUpdate
	 *
	 * @param entityDto 实体对象
	 * @return boolean
	 */
	@SneakyThrows
	default void saveOrUpdate(D entityDto) {
		T entity;
		entity = ObjectUtil.isNotEmpty(entityDto.getId()) ? getById(entityDto.getId())
			: getEntityClass().newInstance();
		copyDtoToBean(entityDto, entity);
		// 获取修改前的parentIds，用于更新子节点的parentIds
		String oldParentIds = entity.getParentIds();
		if (entity.getParentId() != null) {
			T parent = getRepository().selectById(entity.getParentId());
			if (parent != null && ObjectUtil.isNotEmpty(parent.getId())) {
				parent.setLeaf(false);
				getRepository().updateById(parent);
				entity.setParentIds(
					StringUtil.toAppendStr(parent.getParentIds(), parent.getId(), StringUtil.SPLIT_DEFAULT));
			}
		} else {
			entity.setParentId(TreeUtil.ROOT);
		}
		String id = entity.getId() != null ? String.valueOf(entity.getId()) : null;
		if (ObjectUtil.isNotEmpty(entity.getId())) {
			Long count = countByParentId(id);
			entity.setLeaf(count == null || count == 0);
		} else {
			entity.setLeaf(true);
		}
		if (StringUtil.isNotEmpty(id)) {
			this.updateById(entity);
		} else {
			this.save(entity);
		}
		if (ObjectUtil.isNotEmpty(oldParentIds)) {
			// 更新子节点 parentIds
			List<T> list = findAllByParentIdsLike(id);
			for (T e : list) {
				if (StringUtil.isNotEmpty(e.getParentIds())) {
					e.setParentIds(e.getParentIds().replace(oldParentIds, entity.getParentIds()));
				}
			}
			if (ObjectUtil.isNotEmpty(list)) {
				updateBatchById(list);
			}
		}
		entityDto.setId((Long) entity.getId());
	}

	/**
	 * removeByIds
	 *
	 * @param idList 主键ID或实体列表
	 * @return boolean
	 */
	@Override
	default boolean removeByIds(Collection<?> idList) {
		idList.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<T> menuList = this.list(Wrappers.<T>query().eq(TreeDo.F_SQL_PARENT_ID, id));
			ArgumentAssert.notEmpty(menuList, () -> new BizException("含有下级不能删除"));
		});
		return CollectionUtils.isEmpty(idList) ? false : SqlHelper.retBool(this.getBaseMapper().deleteBatchIds(idList));
	}

}
