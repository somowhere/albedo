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

import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.core.vo.TreeUtil;
import com.albedo.java.common.persistence.service.impl.TreeVoServiceImpl;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.repository.MenuRepository;
import com.albedo.java.modules.sys.repository.RoleMenuRepository;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.modules.sys.vo.*;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 菜单权限表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@AllArgsConstructor
public class MenuServiceImpl extends
	TreeVoServiceImpl<MenuRepository, Menu, MenuDataVo> implements MenuService {
	private final RoleMenuRepository roleMenuRepository;

	@Override
	@Cacheable(value = "menu_details", key = "#roleId  + '_menu'")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuVo> getMenuByRoleId(String roleId) {
		List<MenuVo> menuAllList = baseMapper.listMenuVos(CommonConstants.YES);
		List<MenuVo> menuVoList = baseMapper.listMenuVosByRoleId(roleId, CommonConstants.YES);
		List<String> parentIdList = Lists.newArrayList();
		for (MenuVo menuVo : menuVoList) {
			if (menuVo.getParentId() != null) {
				if (!parentIdList.contains(menuVo.getParentId())) {
					parentIdList.add(menuVo.getParentId());
				}
			}
			if (menuVo.getParentIds() != null) {
				String[] parentIds = menuVo.getParentIds().split(",");
				for (String parentId : parentIds) {
					if (!parentIdList.contains(parentId)) {
						parentIdList.add(parentId);
					}
				}
			}
		}
		if (ObjectUtil.isNotEmpty(parentIdList)) {
			for (String parenId : parentIdList) {
				if (!contain(parenId, menuVoList)) {
					MenuVo menuVo = get(parenId, menuAllList);
					if (menuVo != null) {
						menuVoList.add(menuVo);
					}
				}
			}
		}
		return menuVoList;

	}

	private MenuVo get(String id, List<MenuVo> resourceList) {
		for (MenuVo resource : resourceList) {
			if (resource.getId().equals(id)) {
				return resource;
			}
		}
		return null;
	}


	private boolean contain(String id, List<MenuVo> resourceList) {
		for (MenuVo resource : resourceList) {
			if (resource.getId().equals(id)) {
				return true;
			}
		}
		return false;
	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public void removeMenuById(List<String> ids) {
		ids.forEach(id -> {
			// 查询父节点为当前节点的节点
			List<Menu> menuList = this.list(Wrappers.<Menu>query()
				.lambda().eq(Menu::getParentId, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new RuntimeMsgException("菜单含有下级不能删除");
			}

			roleMenuRepository
				.delete(Wrappers.<RoleMenu>query()
					.lambda().eq(RoleMenu::getMenuId, id));
			//删除当前菜单及其子菜单
			this.removeById(id);
		});

	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public MenuDataVo save(MenuDataVo form) {
		return super.save(form);
	}

	@Override
	@CacheEvict(value = "menu_details", allEntries = true)
	public boolean saveByGenScheme(GenSchemeDataVo schemeDataVo) {

		String moduleName = schemeDataVo.getSchemeName(),
			parentMenuId = schemeDataVo.getParentMenuId(),
			url = schemeDataVo.getUrl();
		String permission = StringUtil.toCamelCase(StringUtil.lowerFirst(url), CharUtil.DASHED)
			.replace("/", "_").substring(1),
			permissionLike = permission.substring(0, permission.length() - 1);
		List<Menu> currentMenuList = baseMapper.selectList(Wrappers.<Menu>query()
			.lambda().eq(Menu::getName, moduleName).or()
			.likeLeft(Menu::getPermission, permissionLike)
		);
		for (Menu currentMenu : currentMenuList) {
			if (currentMenu != null) {
				baseMapper.delete(Wrappers.<Menu>query()
					.lambda()
					.likeLeft(Menu::getPermission, permissionLike)
					.or(i -> i.eq(Menu::getId, currentMenu.getId())
						.or().eq(Menu::getParentId, currentMenu.getId()))
				);
			}
		}
		Menu parentMenu = baseMapper.selectById(parentMenuId);
		Assert.isTrue(parentMenu != null, StringUtil.toAppendStr("根据模块id[", parentMenuId, "无法查询到模块信息]"));


		Menu module = new Menu();
//		module.setPermission(permission.substring(0, permission.length() - 1));
		module.setName(moduleName);
		module.setParentId(parentMenu.getId());
		module.setType(Menu.TYPE_MENU);
		module.setIcon("icon-right-square");
		module.setPath(StringUtil.toRevertCamelCase(StringUtil.lowerFirst(schemeDataVo.getClassName()), CharUtil.DASHED));
		module.setComponent("views" + url + "index");
		save(module);

		Menu moduleView = new Menu();
		moduleView.setParent(module);
		moduleView.setName(moduleName + "查看");
//		moduleView.setIcon("fa-info-circle");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(Menu.TYPE_BUTTON);
		moduleView.setSort(20);
//		moduleView.setPath(url);
		save(moduleView);
		Menu moduleEdit = new Menu();
		moduleEdit.setParent(module);
		moduleEdit.setName(moduleName + "编辑");
//        moduleEdit.setIconCls("icon-edit-fill");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(Menu.TYPE_BUTTON);
		moduleEdit.setSort(40);
//		moduleEdit.setPath(url);
		save(moduleEdit);
		Menu moduleDelete = new Menu();
		moduleDelete.setParent(module);
		moduleDelete.setName(moduleName + "删除");
//        moduleDelete.setIconCls("fa-trash-o");
		moduleDelete.setPermission(permission + "del");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(Menu.TYPE_BUTTON);
		moduleDelete.setSort(80);
//		moduleDelete.setPath(url);
		save(moduleDelete);
		return true;
	}

	@Override
	public List<MenuTree> listMenuTrees(TreeQuery treeQuery) {
		List<Menu> menuEntities = baseMapper.selectList(Wrappers.emptyWrapper());
		String extId = treeQuery.getExtId();
		List<MenuTree> treeList = menuEntities.stream().filter(item ->
			(ObjectUtil.isEmpty(extId) || ObjectUtil.isEmpty(item.getParentIds()) ||
				(ObjectUtil.isNotEmpty(extId) && !extId.equals(item.getId()) && item.getParentIds() != null
					&& item.getParentIds().indexOf("," + extId + ",") == -1))
		)
			.sorted(Comparator.comparingInt(Menu::getSort))
			.map(menu -> {
				MenuTree node = new MenuTree();
				node.setId(menu.getId());
				node.setParentId(menu.getParentId());
				node.setName(menu.getName());
				node.setPath(menu.getPath());
				node.setCode(menu.getPermission());
				node.setLabel(menu.getName());
				node.setComponent(menu.getComponent());
				node.setIcon(menu.getIcon());
				node.setKeepAlive(menu.getKeepAlive());
				return node;
			}).collect(Collectors.toList());
		return TreeUtil.buildByLoop(treeList, Menu.ROOT);
	}

	@Override
	public void sortUpdate(MenuDataSortVo menuDataSortVo) {

		menuDataSortVo.getMenuSortVoList().forEach(menuSortVo -> {
			Menu menu = repository.selectById(menuSortVo.getId());
			if (menu != null) {
				menu.setSort(menuSortVo.getSort());
				repository.updateById(menu);
			}
		});

	}
}
