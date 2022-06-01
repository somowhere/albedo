
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

package com.albedo.java.modules.sys.service.impl;

import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.util.tree.TreeUtil;
import com.albedo.java.modules.sys.cache.MenuCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.MenuDo;
import com.albedo.java.modules.sys.domain.RoleMenuDo;
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
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractTreeCacheServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
public class MenuServiceImpl extends AbstractTreeCacheServiceImpl<MenuRepository, MenuDo, MenuDto> implements MenuService {

	private final RoleRepository roleRepository;

	private final RoleMenuRepository roleMenuRepository;

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuTree> findTreeByUserId(Long userId) {
		CacheKey cacheKey = new MenuCacheKeyBuilder().key("findTreeByUserId", userId);
		return cacheOps.get(cacheKey, (k) -> {
			// 获取符合条件的菜单
			Set<MenuVo> all = new HashSet<>();
			roleRepository.findListByUserId(userId).forEach(role -> all.addAll(findListByRoleId(role.getId())));
			List<MenuTree> menuTreeList = all.stream().filter(menuVo -> !MenuDto.TYPE_BUTTON.equals(menuVo.getType()))
				.sorted(Comparator.comparingInt(MenuVo::getSort)).map(MenuTree::new).collect(Collectors.toList());
			return buildMenus(Lists.newArrayList(TreeUtil.buildByLoopAutoRoot(menuTreeList)));

		});
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
				} else if (TreeUtil.ROOT.equals(menu.getParentId())) {
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
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<MenuVo> findListByRoleId(Long roleId) {
		CacheKey cacheKey = new MenuCacheKeyBuilder().key("findListByRoleId", roleId);
		return cacheOps.get(cacheKey, (k) -> {
			List<MenuVo> menuAllList = repository.findMenuVoAllList();
			List<MenuVo> menuVoList = repository.findMenuVoListByRoleId(roleId);
			List<Long> parentIdList = Lists.newArrayList();
			for (MenuVo menuVo : menuVoList) {
				if (menuVo.getParentId() != null) {
					if (!parentIdList.contains(menuVo.getParentId())) {
						parentIdList.add(menuVo.getParentId());
					}
				}
				if (menuVo.getParentIds() != null) {
					String[] parentIds = menuVo.getParentIds().split(",");
					for (String parentId : parentIds) {
						if (StringUtil.isNotEmpty(parentId) && !parentIdList.contains(parentId)) {
							parentIdList.add(Long.parseLong(parentId));
						}
					}
				}
			}
			if (ObjectUtil.isNotEmpty(parentIdList)) {
				for (Long parenId : parentIdList) {
					if (!contain(parenId, menuVoList)) {
						MenuVo menuVo = get(parenId, menuAllList);
						if (menuVo != null) {
							menuVoList.add(menuVo);
						}
					}
				}
			}
			return menuVoList;
		});
	}

	private MenuVo get(Long id, List<MenuVo> resourceList) {
		for (MenuVo resource : resourceList) {
			if (resource.getId().equals(id)) {
				return resource;
			}
		}
		return null;
	}

	private boolean contain(Long id, List<MenuVo> resourceList) {
		for (MenuVo resource : resourceList) {
			if (resource.getId().equals(id)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void removeByIds(Set<Long> ids) {
		ids.forEach(id -> {
			SysCacheUtil.delMenuCaches(id);
			// 查询父节点为当前节点的节点
			List<MenuDo> menuDoList = this.list(Wrappers.<MenuDo>query().lambda().eq(MenuDo::getParentId, id));
			ArgumentAssert.notEmpty(menuDoList, () -> new BizException("菜单含有下级不能删除"));

			roleMenuRepository.delete(Wrappers.<RoleMenuDo>query().lambda().eq(RoleMenuDo::getMenuId, id));
			// 删除当前菜单及其子菜单
			this.removeById(id);
		});
	}

	public Boolean exitMenuByPermission(MenuDto menuDto) {
		return getOne(Wrappers.<MenuDo>query().ne(ObjectUtil.isNotEmpty(menuDto.getId()), MenuDto.F_ID, menuDto.getId())
			.eq(MenuDto.F_PERMISSION, menuDto.getPermission())) != null;
	}

	@Override
	public void saveOrUpdate(MenuDto menuDto) {
		boolean add = ObjectUtil.isEmpty(menuDto.getId());
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
		List<MenuDo> currentMenuListDo = repository.selectList(Wrappers.<MenuDo>query().lambda().eq(MenuDo::getName, moduleName)
			.or().likeLeft(MenuDo::getPermission, permissionLike));
		for (MenuDo currentMenuDo : currentMenuListDo) {
			if (currentMenuDo != null) {
				List<Long> idList = repository
					.selectList(
						Wrappers.<MenuDo>query().lambda().likeLeft(MenuDo::getPermission, permissionLike)
							.or(i -> i.eq(MenuDo::getId, currentMenuDo.getId()).or().eq(MenuDo::getParentId,
								currentMenuDo.getId())))
					.stream().map(MenuDo::getId).collect(Collectors.toList());
				roleMenuRepository.delete(Wrappers.<RoleMenuDo>query().lambda().in(RoleMenuDo::getMenuId, idList));
				repository.deleteBatchIds(idList);
			}
		}
		MenuDo parentMenuDo = repository.selectById(parentMenuId);
		ArgumentAssert.notNull(parentMenuDo, StringUtil.toAppendStr("根据模块id[", parentMenuId, "无法查询到模块信息]"));

		MenuDo module = new MenuDo();

		module.setName(moduleName);
		module.setParentId(parentMenuDo.getId());
		module.setType(MenuDo.TYPE_MENU);
		module.setIcon("app");
		module.setPath(StringUtil.toRevertCamelCase(StringUtil.lowerFirst(schemeDto.getClassName()), CharUtil.DASHED));
		module.setComponent(url.substring(1) + "index");
		save(module);

		MenuDo moduleView = new MenuDo();
		moduleView.setParent(module);
		moduleView.setName(moduleName + "查看");
		moduleView.setPermission(permission + "view");
		moduleView.setParentId(module.getId());
		moduleView.setType(MenuDo.TYPE_BUTTON);
		moduleView.setSort(20);
		save(moduleView);
		MenuDo moduleEdit = new MenuDo();
		moduleEdit.setParent(module);
		moduleEdit.setName(moduleName + "编辑");
		moduleEdit.setPermission(permission + "edit");
		moduleEdit.setParentId(module.getId());
		moduleEdit.setType(MenuDo.TYPE_BUTTON);
		moduleEdit.setSort(40);
		save(moduleEdit);
		MenuDo moduleDelete = new MenuDo();
		moduleDelete.setParent(module);
		moduleDelete.setName(moduleName + "删除");
		moduleDelete.setPermission(permission + "del");
		moduleDelete.setParentId(module.getId());
		moduleDelete.setType(MenuDo.TYPE_BUTTON);
		moduleDelete.setSort(80);
		save(moduleDelete);
		return true;
	}

	@Override
	public void sortUpdate(MenuSortDto menuSortDto) {
		menuSortDto.getMenuSortList().forEach(menuSortVo -> {
			MenuDo menuDo = repository.selectById(menuSortVo.getId());
			if (menuDo != null) {
				menuDo.setSort(menuSortVo.getSort());
				repository.updateById(menuDo);
			}
		});

	}

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new MenuCacheKeyBuilder();
	}
}
