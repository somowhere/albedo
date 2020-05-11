/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.core.vo;


import lombok.experimental.UtilityClass;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2017年11月9日23:34:11
 */
@UtilityClass
public class TreeUtil {
	public static final String ROOT = "-1";
	public <T extends TreeNode> Set<T> buildByLoopAutoRoot(Collection<T> treeNodes){
		Set<T> trees = new LinkedHashSet<>();
		Set<T> depts= new LinkedHashSet<>();
		List<String> deptIds = treeNodes.stream().map(T::getId).collect(Collectors.toList());
		boolean isChild;
		for (T deptDTO : treeNodes) {
			isChild = false;
			if (ROOT.equals(deptDTO.getParentId())) {
				trees.add(deptDTO);
			}
			for (T it : treeNodes) {
				if (it.getParentId().equals(deptDTO.getId())) {
					isChild = true;
					if (deptDTO.getChildren() == null) {
						deptDTO.setChildren(new ArrayList<>());
					}
					deptDTO.getChildren().add(it);
				}
			}
			if(isChild) {
				depts.add(deptDTO);
			} else if(!deptIds.contains(deptDTO.getParentId())) {
				depts.add(deptDTO);
			}
		}

		if (CollectionUtils.isEmpty(trees)) {
			trees = depts;
		}
		return trees;
	}
	public <T extends TreeNode> Set<T> buildByLoop(Collection<T> treeNodes){
		return buildByLoop(treeNodes, ROOT);
	}
	/**
	 * 两层循环实现建树
	 *
	 * @param treeNodes 传入的树节点列表
	 * @return
	 */
	public <T extends TreeNode> Set<T> buildByLoop(Collection<T> treeNodes, Object root) {

		Set<T> trees = new LinkedHashSet<>();

		for (T treeNode : treeNodes) {

			if (root.equals(treeNode.getParentId())) {
				trees.add(treeNode);
			}

			for (T it : treeNodes) {
				if (it.getParentId().equals(treeNode.getId())) {
					if (treeNode.getChildren() == null) {
						treeNode.setChildren(new ArrayList<>());
					}
					treeNode.add(it);
				}
			}
		}
		return trees;
	}


	/**
	 * 使用递归方法建树
	 *
	 * @param treeNodes
	 * @return
	 */
	public <T extends TreeNode> Set<T> buildByRecursive(Collection<T> treeNodes, Object root) {
		Set<T> trees = new LinkedHashSet<>();
		for (T treeNode : treeNodes) {
			if (root.equals(treeNode.getParentId())) {
				trees.add(findChildren(treeNode, treeNodes));
			}
		}
		return trees;
	}

	/**
	 * 递归查找子节点
	 *
	 * @param treeNodes
	 * @return
	 */
	public <T extends TreeNode> T findChildren(T treeNode, Collection<T> treeNodes) {
		for (T it : treeNodes) {
			if (treeNode.getId() == it.getParentId()) {
				if (treeNode.getChildren() == null) {
					treeNode.setChildren(new ArrayList<>());
				}
				treeNode.add(findChildren(it, treeNodes));
			}
		}
		return treeNode;
	}



}
