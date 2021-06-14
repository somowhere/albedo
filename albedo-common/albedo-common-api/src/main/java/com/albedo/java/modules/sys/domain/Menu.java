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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotNull;

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
@TableName("sys_menu")
public class Menu extends TreeEntity<Menu> {

	public static final String TYPE_CATALOG = "0";
	public static final String TYPE_MENU = "1";
	public static final String TYPE_BUTTON = "2";
	public static final String F_SHOW = "show";
	public static final String F_SQL_SHOW = "show";
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
	 * VUE页面
	 */
	private String component;
	/**
	 * 菜单类型 （0目录 1菜单 2按钮）
	 */
	@NotNull(message = "菜单类型不能为空")
	@DictType(DictNameConstants.SYS_MENU_TYPE)
	private String type;
	/**
	 * 是否缓存
	 */
	@DictType(DictNameConstants.SYS_FLAG)
	private Integer cache = 0;
	/**
	 * 是否外链
	 */
	@DictType(DictNameConstants.SYS_FLAG)
	private Integer iframe;
	/**
	 * 是否显示1 是0否
	 */
	@NotNull
	@DictType(DictNameConstants.SYS_FLAG)
	private Integer hidden = 0;

	/**
	 * 前端URL
	 */
	private String path;


}
