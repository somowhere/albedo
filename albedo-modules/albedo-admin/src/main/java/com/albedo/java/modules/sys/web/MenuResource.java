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
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.modules.sys.vo.MenuDataSortVo;
import com.albedo.java.modules.sys.vo.MenuDataVo;
import com.albedo.java.modules.sys.vo.MenuTree;
import com.albedo.java.modules.sys.vo.MenuVo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.google.common.collect.Lists;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/menu")
public class MenuResource extends TreeVoResource<MenuService, MenuDataVo> {

	public MenuResource(MenuService service) {
		super(service);
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
	 * 返回当前用户的树形菜单集合
	 *
	 * @return 当前用户的树形菜单
	 */
	@GetMapping("/user-menu")
	public R getUserMenu() {
		// 获取符合条件的菜单
		Set<MenuVo> all = new HashSet<>();
		SecurityUtil.getRoles()
			.forEach(roleId -> all.addAll(service.getMenuByRoleId(roleId)));
		List<MenuTree> menuTreeList = all.stream()
			.filter(menuVo -> Menu.TYPE_MENU.equals(menuVo.getType()) ||
				Menu.TYPE_BUTTON_TAB.equals(menuVo.getType()))
			.map(MenuTree::new)
			.sorted(Comparator.comparingInt(MenuTree::getSort))
			.collect(Collectors.toList());
		return R.buildOkData(buildByLoop(menuTreeList, Menu.ROOT));
	}


	/**
	 * 两层循环实现建树
	 *
	 * @param treeNodes 传入的树节点列表
	 * @return
	 */
	public List<MenuTree> buildByLoop(List<MenuTree> treeNodes, Object root) {

		List<MenuTree> trees = new ArrayList<>();

		for (MenuTree treeNode : treeNodes) {

			if (root.equals(treeNode.getParentId())) {
				trees.add(treeNode);
			}

			for (MenuTree it : treeNodes) {
				if (it.getParentId().equals(treeNode.getId()) && Menu.TYPE_MENU.equals(it.getType())) {
					if (treeNode.getChildren() == null) {
						treeNode.setChildren(new ArrayList<>());
					}
					treeNode.add(it);
				}
			}
		}

		treeNodes.stream()
			.filter(item -> Menu.TYPE_BUTTON_TAB.equals(item.getType()))
			.forEach(item -> addTypeButtonTab(trees, item));

		return trees;
	}

	private void addTypeButtonTab(List<MenuTree> trees, MenuTree menuTree) {
		for (MenuTree treeNode : trees) {
			if (ObjectUtil.isNotEmpty(treeNode.getChildren())) {
				for (MenuTree childNode : treeNode.getChildren()) {
					if (childNode.getId().equals(menuTree.getParentId())) {
						treeNode.add(menuTree);
						return;
					}
				}
				addTypeButtonTab(treeNode.getChildren(), menuTree);
			}
		}
	}


	/**
	 * 返回树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public R getTree(TreeQuery treeQuery) {
		return R.buildOkData(service.listMenuTrees(treeQuery));
	}

	/**
	 * 返回角色的菜单集合
	 *
	 * @param roleId 角色ID
	 * @return 属性集合
	 */
	@GetMapping("/tree/{roleId}")
	public List getRoleTree(@PathVariable String roleId) {
		return service.getMenuByRoleId(roleId)
			.stream()
			.map(MenuVo::getId)
			.collect(Collectors.toList());
	}

	/**
	 * 新增菜单
	 *
	 * @param menuDataVo 菜单信息
	 * @return success/false
	 */
	@Log(value = "菜单管理", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public R save(@Valid @RequestBody MenuDataVo menuDataVo) {

		// permission before comparing with database
		if (StringUtil.isNotEmpty(menuDataVo.getPermission()) && !checkByProperty(ClassUtil.createObj(MenuDataVo.class,
			Lists.newArrayList(MenuDataVo.F_ID, MenuDataVo.F_PERMISSION),
			menuDataVo.getId(), menuDataVo.getPermission()))) {
			throw new RuntimeMsgException("权限已存在");
		}

		service.save(menuDataVo);
		return R.buildOk("操作成功");
	}
	/**
	 * 更新菜单序号
	 *
	 * @param menuDataSortVo 菜单信息
	 * @return success/false
	 */
	@Log(value = "菜单管理", businessType = BusinessType.EDIT)
	@PostMapping("/sort-update")
	@PreAuthorize("@pms.hasPermission('sys_menu_edit')")
	public R sortUpdate(@Valid @RequestBody MenuDataSortVo menuDataSortVo) {
		service.sortUpdate(menuDataSortVo);
		return R.buildOk("操作成功");
	}
	/**
	 * 删除菜单
	 *
	 * @param ids 菜单ID
	 * @return success/false
	 */
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_menu_del')")
	@Log(value = "菜单管理", businessType = BusinessType.DELETE)
	public R removeByIds(@PathVariable String ids) {
		service.removeMenuById(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * 分页查询菜单信息
	 *
	 * @param pm 分页对象
	 * @return 分页对象
	 */
	@GetMapping("/")
	public R<IPage> getPage(PageModel pm) {
		return R.buildOkData(service.findRelationPage(pm));
	}

}
