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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BadRequestException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.domain.dto.RoleMenuDto;
import com.albedo.java.modules.sys.domain.dto.RoleQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.RoleComboVo;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/role")
@AllArgsConstructor
public class RoleResource extends BaseResource {
	private final RoleService roleService;
	private final RoleMenuService roleMenuService;
	private final UserService userService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(roleService.getOneDto(id));
	}

	/**
	 * 添加角色
	 *
	 * @param roleDto 角色信息
	 * @return success、false
	 */
	@Log(value = "角色管理编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_role_edit')")
	public R save(@Valid @RequestBody RoleDto roleDto) {
		checkLevel(roleDto.getLevel());
		roleService.saveOrUpdate(roleDto);
		return R.buildOk("操作成功");
	}


	@ApiOperation("获取用户级别")
	@GetMapping(value = "/level")
	public R findLevel() {
		return R.buildOkData(roleService.findLevelByUserId(SecurityUtil.getUser().getId()));
	}

	/**
	 * 获取角色列表
	 *
	 * @return 角色列表
	 */
	@GetMapping("/all")
	public R all() {
		return R.buildOkData(roleService.list().stream().map(RoleComboVo::new).collect(Collectors.toList()));
	}

	/**
	 * 分页查询角色信息
	 *
	 * @param pm 分页对象
	 * @return 分页对象
	 */
	@GetMapping
	@Log(value = "角色管理查看")
	public R<IPage> getPage(PageModel pm, RoleQueryCriteria roleQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, roleQueryCriteria);
		return R.buildOkData(roleService.page(pm, wrapper));
	}

	/**
	 * 更新角色菜单
	 *
	 * @param roleMenuDto 角色菜单
	 * @return success、false
	 */
	@PutMapping("/menu")
	@Log(value = "角色管理编辑")
	@PreAuthorize("@pms.hasPermission('sys_role_edit')")
	public R saveRoleMenus(@Valid @RequestBody RoleMenuDto roleMenuDto) {
		Role role = roleService.getById(roleMenuDto.getRoleId());
		checkLevel(role.getLevel());
		roleMenuService.saveRoleMenus(roleMenuDto);
		return R.buildOk("操作成功");
	}

	/**
	 * 删除角色
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "角色管理删除")
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_role_del')")
	public R removeByIds(@RequestBody Set<String> ids) {
		roleService.listByIds(ids).stream().forEach(item -> {
			checkLevel(item.getLevel());
			checkRole(item.getId(), item.getName());
		});
		roleService.removeRoleByIds(ids);
		return R.buildOk("操作成功");
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@Log(value = "角色管理锁定/解锁")
	@PreAuthorize("@pms.hasPermission('sys_role_lock')")
	public R lockOrUnLock(@RequestBody Set<String> ids) {
		roleService.listByIds(ids).stream().forEach(item -> {
			checkLevel(item.getLevel());
			checkRole(item.getId(), item.getName());
		});
		roleService.lockOrUnLock(ids);
		return R.buildOk("操作成功");
	}

	/**
	 * 获取用户的角色级别
	 *
	 * @return /
	 */
	private int checkLevel(Integer level) {
		Integer min = roleService.findLevelByUserId(SecurityUtil.getUser().getId());
		if (level != null) {
			if (level < min) {
				throw new BadRequestException("权限不足，你的角色级别：" + min + "，低于操作的角色级别：" + level);
			}
		}
		return min;
	}

	/**
	 * 检查角色是否有用户信息
	 *
	 * @return /
	 */
	private void checkRole(String roleId, String roleName) {
		List<User> userList = userService.findListByRoleId(roleId);
		if (CollUtil.isNotEmpty(userList)) {
			throw new BadRequestException("操作失败！用户：" + CollUtil.convertToString(userList, User.F_USERNAME, StringUtil.COMMA)
				+ "所属要操作的角色：" + roleName);
		}
	}
}
