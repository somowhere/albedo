
/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.MenuQueryCriteria;
import com.albedo.java.modules.sys.domain.dto.MenuSortDto;
import com.albedo.java.modules.sys.domain.vo.MenuVo;
import com.albedo.java.modules.sys.service.MenuService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import io.swagger.annotations.Api;
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
@RequestMapping("${application.admin-path}/sys/menu")
@AllArgsConstructor
@Api(tags = "菜单管理")
public class MenuResource extends BaseResource {

	private final MenuService menuService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return Result.buildOkData(menuService.getOneDto(id));
	}

	/**
	 * 返回当前用户的树形菜单集合
	 *
	 * @return 当前用户的树形菜单
	 */
	@GetMapping("/user-menu")
	public Result findTreeByUserId() {
		return Result.buildOkData(menuService.findTreeByUserId(SecurityUtil.getUser().getId()));
	}

	/**
	 * 返回树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public Result tree(MenuQueryCriteria menuQueryCriteria) {
		return Result.buildOkData(menuService.findTreeNode(menuQueryCriteria));
	}

	/**
	 * 返回角色的菜单集合
	 *
	 * @param roleId 角色ID
	 * @return 属性集合
	 */
	@GetMapping("/role/{roleId}")
	public Result findByRoleId(@PathVariable Long roleId) {
		return Result.buildOkData(
			menuService.findListByRoleId(roleId).stream().map(MenuVo::getId).collect(Collectors.toList()));
	}

	/**
	 * 新增菜单
	 *
	 * @param menuDto 菜单信息
	 * @return success/false
	 */
	@LogOperate(value = "菜单管理编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public Result save(@Valid @RequestBody com.albedo.java.modules.sys.domain.dto.MenuDto menuDto) {
		menuService.saveOrUpdate(menuDto);
		return Result.buildOk("操作成功");
	}

	/**
	 * 更新菜单序号
	 *
	 * @param menuSortDto 菜单信息
	 * @return success/false
	 */
	@LogOperate(value = "菜单管理编辑")
	@PostMapping("/sort-update")
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public Result sortUpdate(@Valid @RequestBody MenuSortDto menuSortDto) {
		menuService.sortUpdate(menuSortDto);
		return Result.buildOk("操作成功");
	}

	/**
	 * 删除菜单
	 *
	 * @param ids 菜单ID
	 * @return success/false
	 */
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_del')")
	@LogOperate(value = "菜单管理删除")
	public Result removeByIds(@RequestBody Set<Long> ids) {
		menuService.removeByIds(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * 查询菜单信息
	 *
	 * @return 分页对象
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_view')")
	@LogOperate(value = "菜单管理查看")
	public Result<IPage<MenuVo>> findTreeList(MenuQueryCriteria menuQueryCriteria) {
		List<MenuVo> menuVoList = menuService.findTreeList(menuQueryCriteria).stream()
			.map(item -> BeanUtil.copyPropertiesByClass(item, MenuVo.class)).collect(Collectors.toList());
		return Result.buildOkData(
			new PageModel<>(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(menuVoList)), menuVoList.size()));
	}

}
