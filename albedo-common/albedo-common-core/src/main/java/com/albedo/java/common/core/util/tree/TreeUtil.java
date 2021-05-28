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

package com.albedo.java.common.core.util.tree;

import com.albedo.java.common.core.util.StringUtil;
import com.google.common.collect.Lists;
import lombok.experimental.UtilityClass;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2017年11月9日23:34:11
 */
@UtilityClass
public class TreeUtil {

	public static final String ROOT = "-1";

	public <T extends TreeNodeAware> List<T> buildByLoopAutoRoot(List<T> treeNodes) {

		List<String> deptParentIds = treeNodes.stream().map(T::getParentId).collect(Collectors.toList());
		if (deptParentIds.contains(ROOT)) {
			return buildByRecursive(treeNodes, ROOT);
		}
		List<String> deptIds = treeNodes.stream().map(T::getId).collect(Collectors.toList());
		List<T> trees = Lists.newArrayList();
		for (T item : treeNodes) {
			if (!deptIds.contains(item.getParentId())) {
				trees.add(findChildren(item, treeNodes));
			}
		}

		return trees;
	}

	public <T extends TreeNodeAware> List<T> buildByLoop(Collection<T> treeNodes) {
		return buildByLoop(treeNodes, ROOT);
	}

	/**
	 * 两层循环实现建树
	 *
	 * @param treeNodes 传入的树节点列表
	 * @return
	 */
	public <T extends TreeNodeAware> List<T> buildByLoop(Collection<T> treeNodes, Object root) {
		List<T> trees = Lists.newArrayList();

		for (T treeNode : treeNodes) {

			if (root.equals(treeNode.getParentId())) {
				trees.add(treeNode);
			}

			for (T it : treeNodes) {
				if (it.getParentId().equals(treeNode.getId())) {
					if (treeNode.getChildren() == null) {
						treeNode.setChildren(Lists.newArrayList());
					}
					treeNode.getChildren().add(it);
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
	public <T extends TreeNodeAware> List<T> buildByRecursive(List<T> treeNodes, Object root) {
		List<T> trees = Lists.newArrayList();
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
	public <T extends TreeNodeAware> T findChildren(T treeNode, List<T> treeNodes) {
		for (T it : treeNodes) {
			if (StringUtil.equals(treeNode.getId(), it.getParentId())) {
				if (treeNode.getChildren() == null) {
					treeNode.setChildren(Lists.newArrayList());
				}
				treeNode.getChildren().add(findChildren(it, treeNodes));
			}
		}
		return treeNode;
	}

}
