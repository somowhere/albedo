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

package com.albedo.java.modules.sys.vo;

import com.albedo.java.common.core.vo.TreeNode;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author somewhere
 * @date 2017年11月9日23:33:27
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MenuTree extends TreeNode<MenuTree> {
	private String icon;
	private String name;
	private boolean spread = false;
	private String path;
	private String component;
	private String authority;
	private String redirect;
	private String keepAlive;
	private String code;
	private String type;
	private Integer sort;

	public MenuTree() {
	}

	public MenuTree(String id, String name, String parentId) {
		this.id = id;
		this.parentId = parentId;
		this.name = name;
		setLabel(name);
	}

	public MenuTree(String id, String name, MenuTree parent) {
		this.id = id;
		this.parentId = parent.getId();
		this.name = name;
		setLabel(name);
	}

	public MenuTree(MenuVo menuVo) {
		this.id = menuVo.getId();
		this.parentId = menuVo.getParentId();
		this.icon = menuVo.getIcon();
		this.name = menuVo.getName();
		this.path = menuVo.getPath();
		this.component = menuVo.getComponent();
		this.type = menuVo.getType();
		setLabel(menuVo.getName());
		this.sort = menuVo.getSort();
		this.keepAlive = menuVo.getKeepAlive();
	}
}
