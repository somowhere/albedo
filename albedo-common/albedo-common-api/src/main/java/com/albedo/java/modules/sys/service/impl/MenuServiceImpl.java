/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.plugins.mybatis.service.impl.TreeServiceImpl;
import com.albedo.java.modules.sys.domain.Menu;
import com.albedo.java.modules.sys.domain.RoleMenu;
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.domain.dto.MenuDto;
import com.albedo.java.modules.sys.domain.dto.MenuSortDto;
import com.albedo.java.modules.sys.domain.vo.MenuTree;
import com.albedo.java.modules.sys.domain.vo.MenuVo;
import com.albedo.java.modules.sys.repository.MenuRepository;
import com.albedo.java.modules.sys.repository.RoleMenuRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.service.MenuService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
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
@CacheConfig(cacheNames = CacheNameConstants.MENU_DETAILS)
public class MenuServiceImpl extends TreeServiceImpl<MenuRepository, Menu, MenuDto> implements MenuService {

	private final RoleRepository roleRepository;

	private final RoleMenuRepository roleMenuRepository;

	@Override
	@Cacheable(key = "'findTreeByUserId:' + #p0")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuTree> findTreeByUserId(String userId) {
		// 获取符合条件的菜单
		Set<MenuVo> all = new HashSet<>();
		roleRepository.findListByUserId(userId).forEach(role -> all.addAll(findListByRoleId(role.getId())));
		List<MenuTree> menuTreeList = all.stream().filter(menuVo -> !MenuDto.TYPE_BUTTON.equals(menuVo.getType()))
			.sorted(Comparator.comparingInt(MenuVo::getSort)).map(MenuTree::new).collect(Collectors.toList());
		return buildMenus(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(menuTreeList)));
	}

	/**
	 * 两层循环实现建树
	 *
	 * @param menuTreeList 传入的树节点列表
	 * @return
	 */
	public List<MenuTree> buildMenus(List<MenuTree> menuTreeList) {
		menuTreeList.forEach(menu -> {
			if (menu != null) {
				List<MenuTree> menuChildList = menu.getChildren();
				if (CollUtil.isNotEmpty(menuChildList)) {
					menu.setAlwaysShow(true);
					menu.setRedirect("noredirect");
					menu.setChildren(buildMenus(menuChildList));
					// 处理是一级菜单并且没有子菜单的情况
				} else if (menu.getParentId() == TreeUtil.ROOT) {
					MenuTree menuVo = new MenuTree();
					menuVo.setMeta(menu.getMeta());
					// 非外链
					if (!CommonConstants.YES.equals(menu.getIframe())) {
						menuVo.setPath("index");
						menuVo.setName(menu.getName());
						menuVo.setComponent(menu.getComponent());
					} else {
						menuVo.setPath(menu.getPath());
					}
					menu.setName(null);
					menu.setMeta(null);
					menu.setComponent("Layout");
					menu.setChildren(Lists.newArrayList(menuVo));
				}
			}
		});
		return menuTreeList;

	}

	@Override
	@Cacheable(key = "'findListByRoleId:' + #p0")
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuVo> findListByRoleId(String roleId) {
		List<MenuVo> menuAllList = repository.findMenuVoAllList();
		List<MenuVo> menuVoList = repository.findMenuVoListByRoleId(roleId);
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
	public void removeByIds(Set<String> ids) {
		ids.forEach(id -> {
			SysCacheUtil.delMenuCaches(id);
			// 查询父节点为当前节点的节点
			List<Menu> menuList = this.list(Wrappers.<Menu>query().lambda().eq(Menu::getParentId, id));
			if (CollUtil.isNotEmpty(menuList)) {
				throw new BizException("菜单含有下级不能删除");
			}

			roleMenuRepository.delete(Wrappers.<RoleMenu>query().lambda().eq(RoleMenu::getMenuId, id));
			// 删除当前菜单及其子菜单
			this.removeById(id);
		});
	}

	public Boolean exitMenuByPermission(MenuDto menuDto) {
		return getOne(Wrappers.<Menu>query().ne(StringUtil.isNotEmpty(menuDto.getId()), MenuDto.F_ID, menuDto.getId())
			.eq(MenuDto.F_PERMISSION, menuDto.getPermission())) != null;
	}

	@Override
	public void saveOrUpdate(MenuDto menuDto) {
		boolean add = StringUtil.isEmpty(menuDto.getId());
		// permission before comparing with database
		if (StringUtil.isNotEmpty(menuDto.getPermission()) && exitMenuByPermission(menuDto)) {
			throw new EntityExistException(MenuDto.class, "permission", menuDto.getPermission());
		}

		super.saveOrUpdate(menuDto);

		if (!add) {
			SysCacheUtil.delMenuCaches(menuDto.getId());
		}

	}

	@Override
	public boolean saveByGenScheme(GenSchemeDto schemeDto) {

		String moduleName = schemeDto.getSchemeName(), parentMenuId = schemeDto.getParentMenuId(),
			url = schemeDto.getUrl();
		String permission = StringUtil.toCamelCase(StringUtil.lowerFirst(url), CharUtil.DASHED)
			.replace(StringUtil.SLASH, "_").substring(1),
			permissionLike = permission.substring(0, permission.length() - 1);
		List<Menu> currentMenuList = repository.selectList(Wrappers.<Menu>query().lambda().eq(Menu::getName, moduleName)
			.or().likeLeft(Menu::getPermission, permissionLike));
		for (Menu currentMenu : currentMenuList) {
			if (currentMenu != null) {
				List<String> idList = repository
					.selectList(
						Wrappers.<Menu>query().lambda().likeLeft(Menu::getPermission, permissionLike)
							.or(i -> i.eq(Menu::getId, currentMenu.getId()).or().eq(Menu::getParentId,
								currentMenu.getId())))
					.stream().map(Menu::getId).collect(Collectors.toList());
				roleMenuRepository.delete(Wrappers.<RoleMenu>query().lambda().in(RoleMenu::getMenuId, idList));
				repository.deleteBatchIds(idList);
			}
		}
		Menu parentMenu = repository.selectById(parentMenuId);
		Assert.isTrue(parentMenu != null, StringUtil.toAppendStr("根据模块id[", parentMenuId, "无法查询到模块信息]"));

		Menu module = new Menu();

		module.setName(moduleName);
		module.setParentId(parentMenu.getId());
		module.setType(Menu.TYPE_MENU);
		module.setIcon("icon-right-square");
		module.setPath(StringUtil.toRevertCamelCase(StringUtil.lowerFirst(schemeDto.getClassName()), CharUtil.DASHED));
		module.setComponent(url.substring(1) + "index");
		save(module);

		Menu moduleView = new Menu();
		moduleView.setParent(module);
		moduleView.setName(moduleName + "查看");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(Menu.TYPE_BUTTON);
		moduleView.setSort(20);
		save(moduleView);
		Menu moduleEdit = new Menu();
		moduleEdit.setParent(module);
		moduleEdit.setName(moduleName + "编辑");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(Menu.TYPE_BUTTON);
		moduleEdit.setSort(40);
		save(moduleEdit);
		Menu moduleDelete = new Menu();
		moduleDelete.setParent(module);
		moduleDelete.setName(moduleName + "删除");
		moduleDelete.setPermission(permission + "del");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(Menu.TYPE_BUTTON);
		moduleDelete.setSort(80);
		save(moduleDelete);
		return true;
	}

	@Override
	public void sortUpdate(MenuSortDto menuSortDto) {
		menuSortDto.getMenuSortList().forEach(menuSortVo -> {
			Menu menu = repository.selectById(menuSortVo.getId());
			if (menu != null) {
				menu.setSort(menuSortVo.getSort());
				repository.updateById(menu);
			}
		});

	}

}
