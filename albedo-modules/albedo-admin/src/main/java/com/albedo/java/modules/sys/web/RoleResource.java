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
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.domain.vo.RoleComboVo;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collections;
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
public class RoleResource  extends BaseResource {
	private final RoleService roleService;
	private final RoleMenuService roleMenuService;

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
	@Log(value = "角色管理", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_role_edit')")
	public R save(@Valid @RequestBody RoleDto roleDto) {
		getLevels(roleDto.getLevel());
		roleService.saveOrUpdate(roleDto);
		return R.buildOk("操作成功");
	}

	/**
	 * 删除角色
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "角色管理", businessType = BusinessType.DELETE)
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_role_del')")
	public R removeByIds(@RequestBody Set<String> ids) {
		roleService.listByIds(ids).stream().forEach(item->getLevels(item.getLevel()));
		roleService.removeRoleByIds(ids);
		return R.buildOk("操作成功");
	}
	@ApiOperation("获取用户级别")
	@GetMapping(value = "/level")
	public R getLevel(){
		return R.buildOkData(getLevels(null));
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
	public R<IPage> getPage(PageModel pm) {
		return R.buildOkData(roleService.page(pm));
	}

	/**
	 * 更新角色菜单
	 *
	 * @param roleId  角色ID
	 * @param menuIds 菜单ID拼成的字符串，每个id之间根据逗号分隔
	 * @return success、false
	 */
	@PutMapping("/menu")
	@Log(value = "角色管理", businessType = BusinessType.EDIT)
	@PreAuthorize("@pms.hasPermission('sys_role_perm')")
	public R saveRoleMenus(String roleId, @RequestParam(value = "menuIds", required = false) String menuIds) {
		Role role = roleService.getById(roleId);
		getLevels(role.getLevel());
		return new R<>(roleMenuService.saveRoleMenus(roleId, menuIds));
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@Log(value = "角色管理", businessType = BusinessType.LOCK)
	@PreAuthorize("@pms.hasPermission('sys_role_lock')")
	public R lockOrUnLock(@RequestBody Set<String> ids) {
		roleService.listByIds(ids).stream().forEach(item->getLevels(item.getLevel()));
		roleService.lockOrUnLock(ids);
		return R.buildOk("操作成功");
	}
	/**
	 * 获取用户的角色级别
	 * @return /
	 */
	private int getLevels(Integer level){
		List<Integer> levels = roleService.findRolesByUserIdList(SecurityUtil.getUser().getId()).stream().map(Role::getLevel).collect(Collectors.toList());
		int min = Collections.min(levels);
		if(level != null){
			if(level < min){
				throw new BadRequestException("权限不足，你的角色级别：" + min + "，低于操作的角色级别：" + level);
			}
		}
		return min;
	}
}
