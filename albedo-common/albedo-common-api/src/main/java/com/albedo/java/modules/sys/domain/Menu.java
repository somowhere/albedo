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

package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.SearchField;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.baomidou.mybatisplus.annotation.TableField;
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

	public static final String TYPE_MENU = "0";
	public static final String TYPE_BUTTON = "1";
	public static final String TYPE_BUTTON_TAB = "2";
	public static final String F_SHOW = "show";
	public static final String F_SQL_SHOW = "show";
	private static final long serialVersionUID = 1L;

	/**
	 * 菜单权限标识
	 */
	@SearchField
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
	 * 菜单类型 （0菜单 1按钮）
	 */
	@NotNull(message = "菜单类型不能为空")
	@DictType("sys_menu_type")
	private String type;
	/**
	 * 路由缓冲
	 */
	@DictType("sys_flag")
	private String keepAlive;
	/**
	 * 是否显示1 是0否
	 */
	@NotNull
	@TableField("`show`")
	@DictType("sys_flag")
	private Integer show = 1;

	/**
	 * 前端URL
	 */
	private String path;


}
