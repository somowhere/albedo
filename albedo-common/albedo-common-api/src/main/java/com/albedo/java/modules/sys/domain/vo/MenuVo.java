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

package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.vo.TreeVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 菜单权限表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class MenuVo extends TreeVo<MenuVo> {

	private static final long serialVersionUID = 1L;

	/**
	 * 菜单权限标识
	 */
	private String permission;

	/**
	 * 图标
	 */
	private String icon;

	/**
	 * 一个路径
	 */
	private String path;

	/**
	 * VUE页面
	 */
	private String component;

	/**
	 * 菜单类型 （0菜单 1按钮）
	 */
	@DictType(DictNameConstants.SYS_MENU_TYPE)
	private String type;

	/**
	 * 是否隐藏 1是 0否
	 */
	@DictType(DictNameConstants.SYS_FLAG)
	private Integer hidden;

	@DictType(DictNameConstants.SYS_FLAG)
	private Integer cache;

	@DictType(DictNameConstants.SYS_FLAG)
	private Integer iframe;

}
