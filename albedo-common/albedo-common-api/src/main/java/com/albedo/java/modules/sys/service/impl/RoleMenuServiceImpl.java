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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.domain.dto.RoleMenuDto;
import com.albedo.java.modules.sys.repository.RoleMenuRepository;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.plugins.mybatis.service.impl.BaseServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 角色菜单表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class RoleMenuServiceImpl extends BaseServiceImpl<RoleMenuRepository, RoleMenu> implements RoleMenuService {

	/**
	 * @param roleMenuDto 角色菜单
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = {CacheNameConstants.ROLE_DETAILS, CacheNameConstants.MENU_DETAILS}, allEntries = true)
	public Boolean saveRoleMenus(RoleMenuDto roleMenuDto) {
		this.remove(Wrappers.<RoleMenu>query().lambda().eq(RoleMenu::getRoleId, roleMenuDto.getRoleId()));

		List<RoleMenu> roleMenuList = roleMenuDto.getMenuIdList().stream().map(menuId -> {
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setRoleId(roleMenuDto.getRoleId());
			roleMenu.setMenuId(menuId);
			return roleMenu;
		}).collect(Collectors.toList());

		return this.saveBatch(roleMenuList);
	}

}
