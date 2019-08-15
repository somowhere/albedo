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
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.service.RoleMenuService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.domain.vo.RoleDataVo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/role")
public class RoleResource extends DataVoResource<RoleService, RoleDataVo> {
	private final RoleMenuService roleMenuService;

	public RoleResource(RoleService service, RoleMenuService roleMenuService) {
		super(service);
		this.roleMenuService = roleMenuService;
	}

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(service.findOneVo(id));
	}

	/**
	 * 添加角色
	 *
	 * @param roleDataVo 角色信息
	 * @return success、false
	 */
	@Log(value = "角色管理", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_role_edit')")
	public R save(@Valid @RequestBody RoleDataVo roleDataVo) {
		service.save(roleDataVo);
		return R.buildOk("操作成功");
	}

	/**
	 * 删除角色
	 *
	 * @param ids
	 * @return
	 */
	@Log(value = "角色管理", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_role_del')")
	public R removeByIds(@PathVariable String ids) {
		service.removeRoleByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * 获取角色列表
	 *
	 * @return 角色列表
	 */
	@GetMapping("/combo-data")
	public R comboData() {
		return R.buildOkData(CollUtil.convertComboDataList(service.list(Wrappers.emptyWrapper()), Role.F_ID, Role.F_NAME));
	}

	/**
	 * 分页查询角色信息
	 *
	 * @param pm 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/")
	public R<IPage> getPage(PageModel pm) {
		return R.buildOkData(service.findPage(pm));
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
		Role role = service.getById(roleId);
		return new R<>(roleMenuService.saveRoleMenus(role.getCode(), roleId, menuIds));
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping(CommonConstants.URL_IDS_REGEX)
	@Log(value = "角色管理", businessType = BusinessType.LOCK)
	@PreAuthorize("@pms.hasPermission('sys_role_lock')")
	public R lockOrUnLock(@PathVariable String ids) {
		service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}
}
