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

import com.albedo.java.common.core.vo.TreeEntityVo;
import lombok.Data;

/**
 * <p>
 * 菜单权限表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
public class MenuVo extends TreeEntityVo {

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
	private String type;
	/**
	 * 是否缓冲
	 */
	private String keepAlive;


	@Override
	public int hashCode() {
		return getId().hashCode();
	}

	/**
	 * menuId 相同则相同
	 *
	 * @param obj
	 * @return
	 */
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof MenuVo) {
			String targetMenuId = ((MenuVo) obj).getId();
			return getId().equals(targetMenuId);
		}
		return super.equals(obj);
	}
}
