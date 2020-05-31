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

package com.albedo.java.modules.sys.service;


import com.albedo.java.common.persistence.service.TreeService;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.domain.dto.MenuDto;
import com.albedo.java.modules.sys.domain.dto.MenuSortDto;
import com.albedo.java.modules.sys.domain.vo.MenuVo;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 菜单权限表 服务类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface MenuService extends TreeService<Menu, MenuDto> {
	/**
	 * 通过角色编号查询URL 权限
	 *
	 * @param roleId 角色ID
	 * @return 菜单列表
	 */
	List<MenuVo> findListByRoleId(String roleId);

	/**
	 * 级联删除菜单
	 *
	 * @param ids 菜单ID
	 * @return 成功、失败
	 */
	void removeByIds(Set<String> ids);

	/**
	 * saveByGenScheme
	 *
	 * @param schemeDto
	 * @return boolean
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	boolean saveByGenScheme(GenSchemeDto schemeDto);

	/**
	 * sortUpdate
	 *
	 * @param menuSortDto
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	void sortUpdate(MenuSortDto menuSortDto);

	/**
	 * findTreeByUserId
	 *
	 * @param userId
	 * @return java.lang.Object
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	Object findTreeByUserId(String userId);
}
