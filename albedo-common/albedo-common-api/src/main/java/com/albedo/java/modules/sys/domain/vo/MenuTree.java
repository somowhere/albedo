
/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.domain.vo;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.TreeNode;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @date 2017年11月9日23:33:27
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@Slf4j
public class MenuTree extends TreeNode<MenuTree> {

	private String name;

	private String path;

	private Boolean hidden;

	private String redirect;

	private String component;

	private Boolean iframe;

	private Boolean alwaysShow;

	private MenuMetaVo meta;

	public MenuTree(MenuVo menuVo) {
		this.id = menuVo.getId();
		this.parentId = menuVo.getParentId();
		this.name = menuVo.getName();
		this.path = menuVo.getPath();
		this.iframe = CommonConstants.YES.equals(menuVo.getIframe());
		setLabel(menuVo.getName());
		this.meta = new MenuMetaVo(menuVo.getName(), menuVo.getIcon(), CommonConstants.YES.equals(menuVo.getCache()));
		this.setHidden(CommonConstants.YES.equals(menuVo.getHidden()));
		// 如果不是外链
		this.setComponent(!CommonConstants.YES.equals(menuVo.getIframe()) && menuVo.getParentId().equals(TreeUtil.ROOT)
			&& StrUtil.isEmpty(menuVo.getComponent()) ? "Layout" : menuVo.getComponent());
		log.debug("name {}, component {}", this.getName(), this.getComponent());
	}

}
