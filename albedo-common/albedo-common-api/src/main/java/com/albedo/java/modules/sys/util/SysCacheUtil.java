package com.albedo.java.modules.sys.util;

import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;

import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:15
 */
@Slf4j
public class SysCacheUtil {

	public static UserRepository userRepository = SpringContextHolder.getBean(UserRepository.class);

	public static RoleRepository roleRepository = SpringContextHolder.getBean(RoleRepository.class);

	/**
	 * 清理用户缓存
	 *
	 * @param userId   /
	 * @param username /
	 */
	public static void delBaseUserCaches(String userId, String username) {
		RedisUtil.delete(CacheNameConstants.USER_DETAILS + "::findVoByUsername:" + username);
		RedisUtil.delete(CacheNameConstants.USER_DETAILS + "::findUserVoById:" + userId);
		RedisUtil.delete(CacheNameConstants.USER_DETAILS + "::findDtoById:" + userId);
	}

	/**
	 * 清理用户缓存
	 *
	 * @param userId   /
	 * @param username /
	 */
	public static void delUserCaches(String userId, String username) {
		delBaseUserCaches(userId, username);
		RedisUtil.delete(CacheNameConstants.ROLE_DETAILS + "::findListByUserId:" + userId);
		RedisUtil.delete(CacheNameConstants.MENU_DETAILS + "::findTreeByUserId:" + userId);
	}

	/**
	 * 清理角色缓存
	 *
	 * @param roleId /
	 */
	public static void delRoleCaches(String roleId) {
		RedisUtil.delete(CacheNameConstants.ROLE_DETAILS + "::findDeptIdsByRoleId:" + roleId);
		RedisUtil.delete(CacheNameConstants.MENU_DETAILS + "::findListByRoleId:" + roleId);
		userRepository.findListByRoleId(roleId).forEach(user -> {
			delUserCaches(user.getId(), user.getUsername());
		});

	}

	/**
	 * 清理菜单缓存
	 *
	 * @param menuId /
	 */
	public static void delMenuCaches(String menuId) {
		Set<String> roleIds = roleRepository.findListByMenuId(menuId).stream().map(Role::getId)
			.collect(Collectors.toSet());
		RedisUtil.deleteLike(CacheNameConstants.MENU_DETAILS + "::findListByRoleId:", roleIds);
		Set<String> userIds = userRepository.findListByMenuId(menuId).stream().map(User::getId)
			.collect(Collectors.toSet());
		RedisUtil.deleteLike(CacheNameConstants.MENU_DETAILS + "::findTreeByUserId:", userIds);
	}

	/**
	 * 清理字典缓存
	 *
	 * @param deptId /
	 */
	public static void delDeptCaches(String deptId) {
		RedisUtil.deleteLike(CacheNameConstants.DEPT_DETAILS + "::findTreeNode*");
		RedisUtil.delete(CacheNameConstants.DEPT_DETAILS + "::findDescendantIdList:" + deptId);
		Set<String> roleIds = roleRepository.findListByDeptId(deptId).stream().map(Role::getId)
			.collect(Collectors.toSet());
		RedisUtil.deleteLike(CacheNameConstants.ROLE_DETAILS + "::findDeptIdsByRoleId:", roleIds);
		userRepository.selectList(Wrappers.<User>lambdaQuery().eq(User::getDeptId, deptId)).forEach(user -> {
			delUserCaches(user.getId(), user.getUsername());
		});
	}

}
