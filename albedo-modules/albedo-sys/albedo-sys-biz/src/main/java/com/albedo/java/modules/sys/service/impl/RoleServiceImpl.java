
/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.cache.RoleCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.RoleDeptDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.RoleMenuDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.domain.dto.RoleQueryDto;
import com.albedo.java.modules.sys.feign.RemoteRoleService;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.RoleDeptService;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
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
public class RoleServiceImpl extends AbstractDataCacheServiceImpl<RoleRepository, RoleDo, RoleDto> implements RoleService, RemoteRoleService {

	private UserRepository userRepository;

	private RoleMenuService roleMenuService;

	private RoleDeptService roleDeptService;

	@Override
	public RoleDto getOneDto(Serializable id) {
		RoleDto oneVo = super.getOneDto(id);
		oneVo.setMenuIdList(roleMenuService.list(Wrappers.<RoleMenuDo>query().lambda().eq(RoleMenuDo::getRoleId, id))
			.stream().map(RoleMenuDo::getMenuId).collect(Collectors.toList()));
		oneVo.setDeptIdList(findDeptIdsByRoleId(id));
		return oneVo;
	}

	@Override
	public List<Long> findDeptIdsByRoleId(Serializable roleId) {
		CacheKey cacheKey = new RoleCacheKeyBuilder().key("findDeptIdsByRoleId", roleId);
		return cacheOps.get(cacheKey, (k) -> roleDeptService.list(Wrappers.<RoleDeptDo>query().lambda().eq(RoleDeptDo::getRoleId, roleId)).stream()
			.map(RoleDeptDo::getDeptId).collect(Collectors.toList()));
	}

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<RoleDo> findListByUserId(Long userId) {
		CacheKey cacheKey = new RoleCacheKeyBuilder().key("findListByUserId", userId);
		return cacheOps.get(cacheKey, (k) -> repository.findListByUserId(userId));
	}

	/**
	 * 通过角色ID，删除角色,并清空角色菜单缓存
	 *
	 * @param ids
	 * @return
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public Boolean removeRoleByIds(Set<Long> ids) {
		verification(ids);
		ids.forEach(id -> {
			SysCacheUtil.delRoleCaches(id);
			roleMenuService.remove(Wrappers.<RoleMenuDo>update().lambda().eq(RoleMenuDo::getRoleId, id));
			this.removeById(id);
		});
		return Boolean.TRUE;
	}

	public void verification(Set<Long> ids) {
		List<UserDo> userDoList = userRepository.findListByRoleIds(ids);
		ArgumentAssert.empty(userDoList, () -> new BizException("所选角色存在用户关联，请解除关联再试！"));
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveOrUpdate(RoleDto roleDto) {
		boolean add = ObjectUtil.isEmpty(roleDto.getId());
		super.saveOrUpdate(roleDto);
		if (CollUtil.isNotEmpty(roleDto.getMenuIdList())) {
			roleMenuService.remove(Wrappers.<RoleMenuDo>query().lambda().eq(RoleMenuDo::getRoleId, roleDto.getId()));

			List<RoleMenuDo> roleMenuDoList = roleDto.getMenuIdList().stream().map(menuId -> {
				RoleMenuDo roleMenuDo = new RoleMenuDo();
				roleMenuDo.setRoleId(roleDto.getId());
				roleMenuDo.setMenuId(menuId);
				return roleMenuDo;
			}).collect(Collectors.toList());

			roleMenuService.saveBatch(roleMenuDoList);
		}
		if (CollUtil.isNotEmpty(roleDto.getDeptIdList())) {
			roleDeptService.remove(Wrappers.<RoleDeptDo>query().lambda().eq(RoleDeptDo::getRoleId, roleDto.getId()));
			List<RoleDeptDo> roleDeptDoList = roleDto.getDeptIdList().stream().map(deptId -> {
				RoleDeptDo roleDeptDo = new RoleDeptDo();
				roleDeptDo.setRoleId(roleDto.getId());
				roleDeptDo.setDeptId(deptId);
				return roleDeptDo;
			}).collect(Collectors.toList());
			roleDeptService.saveBatch(roleDeptDoList);
		}
		// 清空userinfo
		if (!add) {
			SysCacheUtil.delRoleCaches(roleDto.getId());
		}
	}

	@Override
	public void lockOrUnLock(Set<Long> idList) {
		idList.forEach(id -> {
			SysCacheUtil.delRoleCaches(id);
			RoleDo roleDo = repository.selectById(id);
			roleDo.setAvailable(
				CommonConstants.YES.equals(roleDo.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
			repository.updateById(roleDo);
		});
	}

	@Override
	public Integer findLevelByUserId(Long userId) {
		List<Integer> levels = this.findListByUserId(SecurityUtil.getUser().getId()).stream().map(RoleDo::getLevel)
			.collect(Collectors.toList());
		ArgumentAssert.notEmpty(levels, () -> new BizException("权限不足，找不到可用的角色信息"));
		return Collections.min(levels);
	}

	@Override
	public PageModel<RoleDo> findPage(PageModel<RoleDo> pageModel, RoleQueryDto roleQueryDto) {
		return this.page(pageModel, QueryWrapperUtil.fillWrapperOrder(pageModel, Wraps.<RoleDo>lambdaQueryWrapperX()
			.eqIfPresent(RoleDo::getAvailable, roleQueryDto.getAvailable())
			.betweenIfPresent(RoleDo::getCreatedDate, roleQueryDto.getCreatedDate())
			.and(roleQueryDto.getBlurry() != null, roleDoLambdaQueryWrapper -> roleDoLambdaQueryWrapper
				.like(RoleDo::getName, roleQueryDto.getBlurry())
				.or()
				.like(RoleDo::getDescription, roleQueryDto.getBlurry()))));
	}

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new RoleCacheKeyBuilder();
	}

}
