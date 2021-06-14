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

package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import java.util.List;

/**
 * TreeService
 *
 * @param <T>
 * @param <D>
 * @author somewhere
 */
public interface TreeService<T extends TreeEntity, D extends TreeDto> extends DataService<T, D, String> {
	/**
	 * countByParentId
	 *
	 * @param parentId
	 * @return
	 */
	Integer countByParentId(String parentId);

	/**
	 * getTreeWrapper
	 *
	 * @param query
	 * @param <Q>
	 * @return
	 */
	<Q> QueryWrapper<T> getTreeWrapper(Q query);

	/**
	 * findTreeNode
	 *
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	<Q> List<TreeNode> findTreeNode(Q queryCriteria);

	/**
	 * findTreeList
	 *
	 * @param queryCriteria
	 * @param <Q>
	 * @return
	 */
	<Q> List<T> findTreeList(Q queryCriteria);

	/**
	 * findAllByParentIdsLike
	 *
	 * @param parentIds
	 * @return
	 */
	List<T> findAllByParentIdsLike(String parentIds);

}
