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
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.RoleDept;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.domain.vo.RoleDataVo;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.service.RoleDeptService;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
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
	DataVoServiceImpl<RoleRepository, Role, String, RoleDataVo> implements RoleService {
	private final CacheManager cacheManager;
	private RoleMenuService roleMenuService;
	private RoleDeptService roleDeptService;

	@Override
	public RoleDataVo findOneVo(String id) {
		RoleDataVo oneVo = super.findOneVo(id);
		oneVo.setMenuIdList(roleMenuService.list(Wrappers
			.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, id)).stream().map(RoleMenu::getMenuId).collect(Collectors.toList()));
		oneVo.setDeptIdList(roleDeptService.list(Wrappers
			.<RoleDept>query().lambda()
			.eq(RoleDept::getRoleId, id)).stream().map(RoleDept::getDeptId).collect(Collectors.toList()));
		return oneVo;
	}

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List listRolesByUserId(String userId) {
		return baseMapper.listRolesByUserId(userId);
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param ids
	 * @return
	 */
	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleByIds(List<String> ids) {
		ids.forEach(id -> {
			roleMenuService.remove(Wrappers
				.<RoleMenu>update().lambda()
				.eq(RoleMenu::getRoleId, id));
			this.removeById(id);
		});
		return Boolean.TRUE;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "menu_details", key = "#roleDataVo.id  + '_menu'")
	public void save(RoleDataVo roleDataVo) {
		super.save(roleDataVo);
		roleMenuService.remove(Wrappers.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, roleDataVo.getId()));
		List<RoleMenu> roleMenuList = roleDataVo.getMenuIdList().stream().map(menuId -> {
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setRoleId(roleDataVo.getId());
			roleMenu.setMenuId(menuId);
			return roleMenu;
		}).collect(Collectors.toList());

		roleMenuService.saveBatch(roleMenuList);
		if (CollUtil.isNotEmpty(roleDataVo.getDeptIdList())) {
			roleDeptService.remove(Wrappers.<RoleDept>query().lambda()
				.eq(RoleDept::getRoleId, roleDataVo.getId()));
			List<RoleDept> roleDeptList = roleDataVo.getDeptIdList().stream().map(deptId -> {
				RoleDept roleDept = new RoleDept();
				roleDept.setRoleId(roleDataVo.getId());
				roleDept.setDeptId(deptId);
				return roleDept;
			}).collect(Collectors.toList());
			roleDeptService.saveBatch(roleDeptList);
		}
		//清空userinfo
		cacheManager.getCache("user_details").clear();
	}

	@Override
	public void lockOrUnLock(List<String> idList) {
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
