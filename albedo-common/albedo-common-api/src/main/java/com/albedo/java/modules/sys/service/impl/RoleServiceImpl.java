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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.RoleDept;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.service.RoleDeptService;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class RoleServiceImpl extends
	DataServiceImpl<RoleRepository, Role, RoleDto, String> implements RoleService {
	private final CacheManager cacheManager;
	private RoleMenuService roleMenuService;
	private RoleDeptService roleDeptService;

	@Override
	public RoleDto getOneDto(String id) {
		RoleDto oneVo = super.getOneDto(id);
		oneVo.setMenuIdList(roleMenuService.list(Wrappers
			.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, id)).stream().map(RoleMenu::getMenuId).collect(Collectors.toList()));
		oneVo.setDeptIdList(findRoleDeptIdList(id));
		return oneVo;
	}

	@Override
	public List<String> findRoleDeptIdList(String roleId) {
		return roleDeptService.list(Wrappers
			.<RoleDept>query().lambda()
			.eq(RoleDept::getRoleId, roleId)).stream().map(RoleDept::getDeptId).collect(Collectors.toList());
	}

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	@Cacheable(value = "role_details", key = "#userId  + '_role'")
	public List findRolesByUserIdList(String userId) {
		return baseMapper.findRolesByUserIdList(userId);
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param ids
	 * @return
	 */
	@Override
	@CacheEvict(allEntries = true)
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleByIds(Set<String> ids) {
		ids.forEach(id -> {
			roleMenuService.remove(Wrappers
				.<RoleMenu>update().lambda()
				.eq(RoleMenu::getRoleId, id));
			this.removeById(id);
		});
		//清空userinfo
		cacheManager.getCache("user_details").clear();
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(allEntries = true)
	public void saveOrUpdate(RoleDto roleDto) {
		super.saveOrUpdate(roleDto);
		roleMenuService.remove(Wrappers.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, roleDto.getId()));
		List<RoleMenu> roleMenuList = roleDto.getMenuIdList().stream().map(menuId -> {
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setRoleId(roleDto.getId());
			roleMenu.setMenuId(menuId);
			return roleMenu;
		}).collect(Collectors.toList());

		roleMenuService.saveBatch(roleMenuList);
		if (CollUtil.isNotEmpty(roleDto.getDeptIdList())) {
			roleDeptService.remove(Wrappers.<RoleDept>query().lambda()
				.eq(RoleDept::getRoleId, roleDto.getId()));
			List<RoleDept> roleDeptList = roleDto.getDeptIdList().stream().map(deptId -> {
				RoleDept roleDept = new RoleDept();
				roleDept.setRoleId(roleDto.getId());
				roleDept.setDeptId(deptId);
				return roleDept;
			}).collect(Collectors.toList());
			roleDeptService.saveBatch(roleDeptList);
		}
		//清空userinfo
		cacheManager.getCache("user_details").clear();
	}

	@Override
	@CacheEvict(allEntries = true)
	public void lockOrUnLock(Set<String> idList) {
		idList.forEach(id -> {
			Role role = baseMapper.selectById(id);
			role.setAvailable(CommonConstants.STR_YES.equals(role.getAvailable()) ?
				CommonConstants.STR_NO : CommonConstants.STR_YES);
			baseMapper.updateById(role);
		});

		//清空userinfo
		cacheManager.getCache("user_details").clear();
	}


}
