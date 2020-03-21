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

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.BeanVoUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.domain.*;
import com.albedo.java.modules.sys.domain.vo.*;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.validation.Valid;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserServiceImpl extends DataVoServiceImpl<UserRepository, User, String, UserDataVo> implements UserService {
	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	private final MenuService menuService;
	private final RoleService roleService;
	private final DeptService deptService;
	private final UserRoleService userRoleService;
	private final DeptRelationService deptRelationService;

	/**
	 * 保存用户信息
	 *
	 * @param userDataVo DTO 对象
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(value = "user_details", key = "#userDataVo.username")
	public void save(UserDataVo userDataVo) {
		User user = StringUtil.isNotEmpty(userDataVo.getId()) ? baseMapper.selectById(userDataVo.getId()) : new User();
		if (StringUtil.isEmpty(userDataVo.getPassword())) {
			userDataVo.setPassword(null);
		}
		BeanVoUtil.copyProperties(userDataVo, user, true);
		if (StringUtil.isNotEmpty(userDataVo.getPassword())) {
			user.setPassword(passwordEncoder.encode(userDataVo.getPassword()));
		}
		super.saveOrUpdate(user);
		userDataVo.setId(user.getId());
		List<UserRole> userRoleList = userDataVo.getRoleIdList()
			.stream().map(roleId -> {
				UserRole userRole = new UserRole();
				userRole.setUserId(user.getId());
				userRole.setRoleId(roleId);
				return userRole;
			}).collect(Collectors.toList());
		userRoleService.removeRoleByUserId(user.getId());
		userRoleService.saveBatch(userRoleList);
	}

	/**
	 * 通过查用户的全部信息
	 *
	 * @param userVo 用户
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserInfo getUserInfo(UserVo userVo) {
		UserInfo userInfo = new UserInfo();
		userInfo.setUser(userVo);
		List<Role> roles = roleService.findRolesByUserIdList(userVo.getId());
		//设置角色列表  （ID）
		List<String> roleIds = roles.stream()
			.map(Role::getId)
			.collect(Collectors.toList());
		userInfo.setRoles(ArrayUtil.toArray(roleIds, String.class));
		//设置权限列表（menu.permission）
		Set<String> permissions = new HashSet<>();
		roleIds.forEach(roleId -> {
			List<String> permissionList = menuService.getMenuByRoleId(roleId)
				.stream()
				.filter(menuVo -> StringUtil.isNotEmpty(menuVo.getPermission()))
				.map(MenuVo::getPermission)
				.collect(Collectors.toList());
			permissions.addAll(permissionList);
		});
		userInfo.setPermissions(ArrayUtil.toArray(permissions, String.class));
		return userInfo;
	}

	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param pm 分页对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage getUserPage(PageModel pm, DataScope dataScope) {
		Wrapper wrapper = QueryWrapperUtil.getWrapperByPage(pm, getPersistentClass());
		pm.addOrder(OrderItem.desc("a." + User.F_SQL_CREATEDDATE));
		IPage<List<UserVo>> userVosPage = baseMapper.getUserVoPage(pm, wrapper, dataScope);
		return userVosPage;
	}

	@Override
	public Boolean removeByIds(List<String> idList) {
		idList.stream().forEach(id -> {
			Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(),id),"不能操作当前登录用户");
			removeUserById(baseMapper.selectById(id));
		});
		return Boolean.TRUE;
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserVo getUserVoById(String id) {
		UserVo userVo = baseMapper.getUserVoById(id);
		return userVo;
	}

	/**
	 * 删除用户
	 *
	 * @param user 用户
	 * @return Boolean
	 */
	@CacheEvict(value = "user_details", key = "#user.username")
	public Boolean removeUserById(User user) {
//		userRoleService.removeRoleByUserId(user.getId());
		this.removeById(user.getId());
		return Boolean.TRUE;
	}

	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<User> listAncestorUsersByUsername(String username) {
		User user = this.getOne(Wrappers.<User>query().lambda()
			.eq(User::getUsername, username));

		Dept dept = deptService.getById(user.getDeptId());
		if (dept == null) {
			return null;
		}

		String parentId = dept.getParentId();
		return this.list(Wrappers.<User>query().lambda()
			.eq(User::getDeptId, parentId));
	}

	@Override
	public void lockOrUnLock(List<String> idList) {
		idList.forEach(id -> {
			Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(),id),"不能操作当前登录用户");
			User user = baseMapper.selectById(id);
			user.setAvailable(CommonConstants.STR_YES.equals(user.getAvailable()) ?
				CommonConstants.STR_NO : CommonConstants.STR_YES);
			baseMapper.updateById(user);
		});
	}

	@Override
	public void resetPassword(PasswordRestVo passwordRestVo) {
		Object tempCode = RedisUtil.getCacheString(SecurityConstants.DEFAULT_CODE_KEY + passwordRestVo.getPhone());
		Assert.isTrue(passwordRestVo.getCode().equals(tempCode), "验证码输入有误");
		User user = repository.selectOne(Wrappers.<User>query().lambda()
			.eq(User::getUsername, passwordRestVo.getUsername()));
		updatePassword(user, passwordRestVo.getPasswordPlaintext(), passwordRestVo.getNewPassword());
	}

	private void updatePassword(User user, String passwordPlaintext, String newPassword) {
		user.setPassword(newPassword);
//        user.setPasswordPlaintext(passwordPlaintext);
		repository.updateById(user);
//        cacheManager.getCache(UserRepository.USERS_BY_LOGIN_CACHE).evict(user.getLoginId());
		log.debug("Changed password for User: {}", user);
	}

	public void changePassword(String username, PasswordChangeVo passwordChangeVo) {
		User user = repository.selectOne(Wrappers.<User>query().lambda()
			.eq(User::getUsername, username));
		updatePassword(user, passwordChangeVo.getConfirmPassword(), passwordChangeVo.getNewPassword());
	}

	@Override
	public UserVo findOneVoByUserName(String username) {
		return repository.getUserVoByUsername(username);
	}

	public void save(@Valid UserExcelVo userExcelVo) {
		UserDataVo user = new UserDataVo();
		BeanUtils.copyProperties(userExcelVo, user);
		Dept dept = deptService.findOne(
			Wrappers.<Dept>query().lambda().eq(Dept::getName, userExcelVo.getDeptName()));
		if (dept != null) {
			user.setDeptId(dept.getId());
		}
		Role role = roleService.findOne(
			Wrappers.<Role>query().lambda().eq(Role::getName, userExcelVo.getRoleName()));
		if (role == null) {
			throw new RuntimeMsgException("无法获取角色" + userExcelVo.getRoleName() + "信息");
		}
		user.setRoleIdList(Lists.newArrayList(role.getId()));
		save(user);
	}

	/**
	 * 获取当前用户的子部门信息
	 *
	 * @return 子部门列表
	 */
	private List<String> getChildDepts() {
		String deptId = SecurityUtil.getUser().getDeptId();
		//获取当前部门的子部门
		return deptRelationService
			.list(Wrappers.<DeptRelation>query().lambda()
				.eq(DeptRelation::getAncestor, deptId))
			.stream()
			.map(DeptRelation::getDescendant)
			.collect(Collectors.toList());
	}
}
