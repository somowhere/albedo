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

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserEmailDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.MenuVo;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
@CacheConfig(cacheNames = CacheNameConstants.USER_DETAILS)
public class UserServiceImpl extends DataServiceImpl<UserRepository, User, UserDto> implements UserService {

	private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	private final MenuService menuService;

	private final RoleService roleService;

	private final DeptService deptService;

	private final UserRoleService userRoleService;

	/**
	 * 功能描述: 检查密码长度
	 *
	 * @param password
	 * @return boolean
	 */
	private static boolean checkPasswordLength(String password) {
		return !StringUtil.isEmpty(password) && password.length() >= UserDto.PASSWORD_MIN_LENGTH
			&& password.length() <= UserDto.PASSWORD_MAX_LENGTH;
	}

	@Override
	@Cacheable(key = "'findVoByUsername:' + #p0")
	public UserVo findVoByUsername(String username) {
		return repository.findVoByUsername(username);
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	@Cacheable(key = "'findUserVoById:' + #p0")
	public UserVo findUserVoById(String id) {
		UserVo userVo = baseMapper.findUserVoById(id);
		return userVo;
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	@Cacheable(key = "'findDtoById:' + #p0")
	public UserDto findDtoById(String id) {
		UserVo userVo = repository.findUserVoById(id);
		return new UserDto(userVo);
	}

	/**
	 * 通过查用户的全部信息
	 *
	 * @param userVo 用户
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserInfo getInfo(UserVo userVo) {
		UserInfo userInfo = new UserInfo();
		userInfo.setUser(userVo);
		List<Role> roles = roleService.findListByUserId(userVo.getId());
		// 设置角色列表 （ID）
		List<String> roleIds = roles.stream().map(Role::getId).collect(Collectors.toList());
		userInfo.setRoles(ArrayUtil.toArray(roleIds, String.class));
		// 设置权限列表（menu.permission）
		Set<String> permissions = new HashSet<>();
		roleIds.forEach(roleId -> {
			List<String> permissionList = menuService.findListByRoleId(roleId).stream()
				.filter(menuVo -> StringUtil.isNotEmpty(menuVo.getPermission())).map(MenuVo::getPermission)
				.collect(Collectors.toList());
			permissions.addAll(permissionList);
		});
		userInfo.setPermissions(ArrayUtil.toArray(permissions, String.class));
		return userInfo;
	}

	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param pageModel 分页对象
	 * @return
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public IPage<UserVo> findPage(PageModel pageModel, UserQueryCriteria userQueryCriteria, DataScope dataScope) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, userQueryCriteria);
		wrapper.eq("a.del_flag", User.FLAG_NORMAL);
		IPage<UserVo> userVosPage = repository.findUserVoPage(pageModel, wrapper, dataScope);
		return userVosPage;
	}

	@Override
	public List<UserVo> findPage(UserQueryCriteria userQueryCriteria, DataScope dataScope) {
		QueryWrapper wrapper = QueryWrapperUtil.<User>getWrapper(userQueryCriteria);
		wrapper.eq("a.del_flag", User.FLAG_NORMAL);
		wrapper.orderByDesc("a.created_date");
		return repository.findUserVoPage(wrapper, dataScope);
	}

	public Boolean exitUserByUserName(UserDto userDto) {
		return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_USERNAME, userDto.getUsername())) != null;
	}

	public Boolean exitUserByEmail(UserDto userDto) {
		return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_EMAIL, userDto.getEmail())) != null;
	}

	public Boolean exitUserByPhone(UserDto userDto) {
		return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_PHONE, userDto.getPhone())) != null;
	}

	/**
	 * 保存用户信息
	 *
	 * @param userDto DTO 对象
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	@CacheEvict(cacheNames = {CacheNameConstants.USER_DETAILS}, allEntries = true)
	public void saveOrUpdate(UserDto userDto) {
		boolean add = StringUtil.isEmpty(userDto.getId());
		if (add) {
			Assert.isTrue(StringUtil.isNotEmpty(userDto.getPassword()), "密码不能为空");
		}
		// username before comparing with database
		if (exitUserByUserName(userDto)) {
			throw new EntityExistException(UserDto.class, "username", userDto.getUsername());
		}
		// email before comparing with database
		if (StringUtil.isNotEmpty(userDto.getEmail()) && exitUserByEmail(userDto)) {
			throw new EntityExistException(UserDto.class, "email", userDto.getEmail());
		}
		// phone before comparing with database
		if (StringUtil.isNotEmpty(userDto.getPhone()) && exitUserByPhone(userDto)) {
			throw new EntityExistException(UserDto.class, "phone", userDto.getPhone());
		}
		User user = add ? new User() : repository.selectById(userDto.getId());
		BeanUtil.copyProperties(userDto, user, true);
		if (StringUtil.isNotEmpty(userDto.getPassword())) {
			user.setPassword(passwordEncoder.encode(userDto.getPassword()));
		}
		super.saveOrUpdate(user);
		userDto.setId(user.getId());
		if (add || CollUtil.isNotEmpty(userDto.getRoleIdList())) {

			Assert.isTrue(CollUtil.isNotEmpty(userDto.getRoleIdList()), "用户角色不能为空");
			if (!add) {
				SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
			}
			List<UserRole> userRoleList = userDto.getRoleIdList().stream().map(roleId -> {
				UserRole userRole = new UserRole();
				userRole.setUserId(user.getId());
				userRole.setRoleId(roleId);
				return userRole;
			}).collect(Collectors.toList());
			userRoleService.removeRoleByUserId(user.getId());
			userRoleService.saveBatch(userRoleList);
		}
	}

	@Override
	public Boolean removeByIds(List<String> idList) {
		idList.stream().forEach(id -> {
			Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(), id), "不能操作当前登录用户");
			User user = repository.selectById(id);
			SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
			userRoleService.removeRoleByUserId(user.getId());
			this.removeById(user.getId());
		});
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
		User user = this.getOne(Wrappers.<User>query().lambda().eq(User::getUsername, username));

		Dept dept = deptService.getById(user.getDeptId());
		if (dept == null) {
			return null;
		}

		String parentId = dept.getParentId();
		return this.list(Wrappers.<User>query().lambda().eq(User::getDeptId, parentId));
	}

	@Override
	public void lockOrUnLock(Set<String> idList) {
		Assert.isTrue(CollUtil.isNotEmpty(idList), "idList不能为空");
		for (String id : idList) {
			Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(), id), "不能操作当前登录用户");
			User user = repository.selectById(id);
			Assert.isTrue(user != null, "无法找到ID为" + id + "的数据");
			user.setAvailable(
				CommonConstants.YES.equals(user.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
			SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
			int i = repository.updateById(user);
			Assert.isTrue(i != 0, "无法更新ID为" + id + "的数据");
		}
	}

	@Override
	public void resetPassword(PasswordRestVo passwordRestVo) {

		Assert.isTrue(passwordRestVo.getNewPassword().equals(passwordRestVo.getConfirmPassword()), "两次输入密码不一致");
		passwordRestVo.setPasswordPlaintext(passwordRestVo.getNewPassword());
		passwordRestVo.setNewPassword(passwordEncoder.encode(passwordRestVo.getNewPassword()));

		Object tempCode = RedisUtil.getCacheString(SecurityConstants.DEFAULT_CODE_KEY + passwordRestVo.getPhone());
		Assert.isTrue(passwordRestVo.getCode().equals(tempCode), "验证码输入有误");
		User user = repository
			.selectOne(Wrappers.<User>query().lambda().eq(User::getUsername, passwordRestVo.getUsername()));
		updatePassword(user, passwordRestVo.getPasswordPlaintext(), passwordRestVo.getNewPassword());
	}

	private void updatePassword(User user, String passwordPlaintext, String newPassword) {
		user.setPassword(newPassword);
		SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
		repository.updateById(user);
		log.debug("Changed password for User: {}", user);
	}

	@Override
	public void changePassword(String username, PasswordChangeVo passwordChangeVo) {

		Assert.isTrue(passwordChangeVo != null && checkPasswordLength(passwordChangeVo.getNewPassword()), "密码格式有误");
		Assert.isTrue(!passwordChangeVo.getNewPassword().equals(passwordChangeVo.getOldPassword()), "新旧密码不能相同");
		Assert.isTrue(passwordChangeVo.getNewPassword().equals(passwordChangeVo.getConfirmPassword()), "两次输入密码不一致");
		User user = repository.selectOne(Wrappers.<User>query().lambda().eq(User::getUsername, username));
		Assert.isTrue(passwordEncoder.matches(passwordChangeVo.getOldPassword(), user.getPassword()), "输入原密码有误");

		passwordChangeVo.setNewPassword(passwordEncoder.encode(passwordChangeVo.getNewPassword()));

		updatePassword(user, passwordChangeVo.getConfirmPassword(), passwordChangeVo.getNewPassword());
	}

	@Override
	public void save(@Valid UserExcelVo userExcelVo) {
		UserDto user = new UserDto();
		BeanUtils.copyProperties(userExcelVo, user);
		Dept dept = deptService.getOne(Wrappers.<Dept>query().lambda().eq(Dept::getName, userExcelVo.getDeptName()));
		if (dept != null) {
			user.setDeptId(dept.getId());
		}
		Role role = roleService.getOne(Wrappers.<Role>query().lambda().eq(Role::getName, userExcelVo.getRoleName()));
		if (role == null) {
			throw new BizException("无法获取角色" + userExcelVo.getRoleName() + "信息");
		}
		user.setRoleIdList(Lists.newArrayList(role.getId()));
		saveOrUpdate(user);
	}

	@Override
	public List<User> findListByRoleId(String roleId) {
		return repository.findListByRoleId(roleId);
	}

	@Override
	public void updateEmail(String username, UserEmailDto userEmailDto) {
		User user = repository.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
		Assert.isTrue(user != null, "无法获取用户信息" + username);
		Assert.isTrue(passwordEncoder.matches(userEmailDto.getPassword(), user.getPassword()), "输入密码有误");
		user.setEmail(userEmailDto.getEmail());
		SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
		repository.updateById(user);
	}

	@Override
	public void updateAvatar(String username, String avatar) {
		User user = repository.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
		Assert.isTrue(user != null, "无法获取用户信息" + username);
		user.setAvatar(avatar);
		SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
		repository.updateById(user);
	}

}
