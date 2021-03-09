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

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.RoleDept;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.RoleDeptService;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
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
@CacheConfig(cacheNames = CacheNameConstants.ROLE_DETAILS)
public class RoleServiceImpl extends
	DataServiceImpl<RoleRepository, Role, RoleDto, String> implements RoleService {
	private UserRepository userRepository;
	private RoleMenuService roleMenuService;
	private RoleDeptService roleDeptService;

	@Override
	public RoleDto getOneDto(String id) {
		RoleDto oneVo = super.getOneDto(id);
		oneVo.setMenuIdList(roleMenuService.list(Wrappers
			.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, id)).stream().map(RoleMenu::getMenuId).collect(Collectors.toList()));
		oneVo.setDeptIdList(findDeptIdsByRoleId(id));
		return oneVo;
	}

	@Override
	@Cacheable(key = "'findDeptIdsByRoleId:' + #p0")
	public List<String> findDeptIdsByRoleId(String roleId) {
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
	@Cacheable(key = "'findListByUserId:' + #p0")
	public List<Role> findListByUserId(String userId) {
		return repository.findListByUserId(userId);
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param ids
	 * @return
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleByIds(Set<String> ids) {
		verification(ids);
		ids.forEach(id -> {
			SysCacheUtil.delRoleCaches(id);
			roleMenuService.remove(Wrappers
				.<RoleMenu>update().lambda()
				.eq(RoleMenu::getRoleId, id));
			this.removeById(id);
		});
		return Boolean.TRUE;
	}

	public void verification(Set<String> ids) {
		List<User> userList = userRepository.findListByRoleIds(ids);
		if (CollUtil.isNotEmpty(userList)) {
			throw new BadRequestException("所选角色存在用户关联，请解除关联再试！");
		}
	}


	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveOrUpdate(RoleDto roleDto) {
		boolean add = StringUtil.isEmpty(roleDto.getId());
		super.saveOrUpdate(roleDto);
		if (CollUtil.isNotEmpty(roleDto.getMenuIdList())) {
			roleMenuService.remove(Wrappers.<RoleMenu>query().lambda()
				.eq(RoleMenu::getRoleId, roleDto.getId()));

			List<RoleMenu> roleMenuList = roleDto.getMenuIdList().stream().map(menuId -> {
				RoleMenu roleMenu = new RoleMenu();
				roleMenu.setRoleId(roleDto.getId());
				roleMenu.setMenuId(menuId);
				return roleMenu;
			}).collect(Collectors.toList());

			roleMenuService.saveBatch(roleMenuList);
		}
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
		if (!add) {
			SysCacheUtil.delRoleCaches(roleDto.getId());
		}
	}

	@Override
	@CacheEvict(allEntries = true)
	public void lockOrUnLock(Set<String> idList) {
		idList.forEach(id -> {
			SysCacheUtil.delRoleCaches(id);
			Role role = repository.selectById(id);
			role.setAvailable(CommonConstants.YES.equals(role.getAvailable()) ?
				CommonConstants.NO : CommonConstants.YES);
			repository.updateById(role);
		});
	}

	@Override
	public Integer findLevelByUserId(String userId) {
		List<Integer> levels = this.findListByUserId(SecurityUtil.getUser().getId()).stream()
			.map(Role::getLevel).collect(Collectors.toList());
		if (CollUtil.isEmpty(levels)) {
			throw new BadRequestException("权限不足，找不到可用的角色信息");
		}
		int min = Collections.min(levels);
		return min;
	}


}
