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

package com.albedo.java.modules.sys.util;

import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.modules.sys.cache.DeptCacheKeyBuilder;
import com.albedo.java.modules.sys.cache.MenuCacheKeyBuilder;
import com.albedo.java.modules.sys.cache.RoleCacheKeyBuilder;
import com.albedo.java.modules.sys.cache.UserCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.plugins.cache.repository.CacheOps;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:15
 */
@Slf4j
public class SysCacheUtil {

	public static UserRepository userRepository = SpringContextHolder.getBean(UserRepository.class);

	public static RoleRepository roleRepository = SpringContextHolder.getBean(RoleRepository.class);


	public static CacheOps cacheOps = SpringContextHolder.getBean("cacheOps");

	/**
	 * 清理用户缓存
	 *
	 * @param userId   /
	 * @param username /
	 */
	public static void delBaseUserCaches(Long userId, String username) {
		cacheOps.del(new UserCacheKeyBuilder().key(username));
		cacheOps.del(new UserCacheKeyBuilder().key("findUserVoById", userId));
		cacheOps.del(new UserCacheKeyBuilder().key("findDtoById", userId));
	}

	/**
	 * 清理用户缓存
	 *
	 * @param userId   /
	 * @param username /
	 */
	public static void delUserCaches(Long userId, String username) {
		delBaseUserCaches(userId, username);
		cacheOps.del(new RoleCacheKeyBuilder().key("findListByUserId", userId));
		cacheOps.del(new MenuCacheKeyBuilder().key("findTreeByUserId", userId));
	}

	/**
	 * 清理角色缓存
	 *
	 * @param roleId /
	 */
	public static void delRoleCaches(Long roleId) {
		cacheOps.del(new RoleCacheKeyBuilder().key("findDeptIdsByRoleId", roleId));
		cacheOps.del(new MenuCacheKeyBuilder().key("findListByRoleId", roleId));
		userRepository.findListByRoleId(roleId).forEach(user -> {
			delUserCaches(user.getId(), user.getUsername());
		});

	}

	/**
	 * 清理菜单缓存
	 *
	 * @param menuId /
	 */
	public static void delMenuCaches(Long menuId) {
		cacheOps.del(roleRepository.findListByMenuId(menuId).stream().map(k -> new MenuCacheKeyBuilder().key("findListByRoleId", k.getId())).toArray(CacheKey[]::new));
		cacheOps.del(userRepository.findListByMenuId(menuId).stream().map(k -> new MenuCacheKeyBuilder().key("findTreeByUserId", k.getId())).toArray(CacheKey[]::new));
	}

	/**
	 * 清理部门缓存
	 *
	 * @param deptId /
	 */
	public static void delDeptCaches(Long deptId) {
		cacheOps.del(new DeptCacheKeyBuilder().key("findDescendantIdList", deptId));
		cacheOps.del(roleRepository.findListByDeptId(deptId).stream().map(k -> new RoleCacheKeyBuilder().key("findDeptIdsByRoleId", k.getId())).toArray(CacheKey[]::new));
		userRepository.selectList(Wrappers.<User>lambdaQuery().eq(User::getDeptId, deptId)).forEach(user -> {
			delUserCaches(user.getId(), user.getUsername());
		});
	}

}
