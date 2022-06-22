
/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.cache.UserCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.UserRoleDo;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserEmailDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.*;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.feign.RemoteUserService;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.datascope.DataScope;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.Valid;
import java.time.LocalDateTime;
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
public class UserServiceImpl extends AbstractDataCacheServiceImpl<UserRepository, UserDo, UserDto> implements UserService, RemoteUserService {

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
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new UserCacheKeyBuilder();
	}

	@Override
	public UserDo selectById(Long userId) {
		return super.getById(userId);
	}

	@Override
	public UserVo findVoByUsername(String username) {
		CacheKey cacheKey = new UserCacheKeyBuilder().key("findVoByUsername", username);
		return cacheOps.get(cacheKey, (k) -> repository.findVoByUsername(username));
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserVo findUserVoById(Long id) {
		CacheKey cacheKey = new UserCacheKeyBuilder().key("findUserVoById", id);
		return cacheOps.get(cacheKey, (k) -> repository.findUserVoById(id));
	}

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public UserDto findDtoById(Long id) {
		CacheKey cacheKey = new UserCacheKeyBuilder().key("findDtoById", id);
		return new UserDto(cacheOps.get(cacheKey, (k) -> repository.findUserVoById(id)));
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
		List<RoleDo> roleDos = roleService.findListByUserId(userVo.getId());
		// 设置角色列表 （ID）
		List<Long> roleIds = roleDos.stream().map(RoleDo::getId).collect(Collectors.toList());
		userInfo.setRoles(ArrayUtil.toArray(roleIds, Long.class));
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
	public IPage<UserPageVo> findPage(PageModel pageModel, UserQueryCriteria userQueryCriteria, DataScope dataScope) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, userQueryCriteria);
		IPage<UserPageVo> userVosPage = repository.findUserVoPage(pageModel, wrapper, dataScope);
		return userVosPage;
	}

	@Override
	public List<UserVo> findList(UserQueryCriteria userQueryCriteria, DataScope dataScope) {
		QueryWrapper wrapper = QueryWrapperUtil.<UserDo>getWrapper(userQueryCriteria);
		wrapper.orderByDesc("a.created_date");
		return repository.findUserVoList(wrapper, dataScope);
	}

	public Boolean exitUserByUserName(UserDo userDo) {
		return getOne(Wrappers.<UserDo>query().ne(ObjectUtil.isNotEmpty(userDo.getId()), UserDto.F_ID, userDo.getId())
			.eq(UserDto.F_USERNAME, userDo.getUsername())) != null;
	}

	public Boolean exitUserByUserName(UserDto userDto) {
		return getOne(Wrappers.<UserDo>query().ne(ObjectUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_USERNAME, userDto.getUsername())) != null;
	}

	public Boolean exitUserByEmail(UserDto userDto) {
		return getOne(Wrappers.<UserDo>query().ne(ObjectUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_EMAIL, userDto.getEmail())) != null;
	}

	public Boolean exitUserByPhone(UserDto userDto) {
		return getOne(Wrappers.<UserDo>query().ne(ObjectUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
			.eq(UserDto.F_PHONE, userDto.getPhone())) != null;
	}

	/**
	 * 保存用户信息
	 *
	 * @param userDto DTO 对象
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveOrUpdate(UserDto userDto) {
		boolean add = ObjectUtil.isEmpty(userDto.getId());
		if (add) {
			ArgumentAssert.notEmpty(userDto.getPassword(), "密码不能为空");
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
		UserDo userDo = add ? new UserDo() : repository.selectById(userDto.getId());
		BeanUtil.copyProperties(userDto, userDo, true);
		if (StringUtil.isNotEmpty(userDto.getPassword())) {
			userDo.setPassword(passwordEncoder.encode(userDto.getPassword()));
		}
		super.saveOrUpdate(userDo);
		userDto.setId(userDo.getId());
		if (add || CollUtil.isNotEmpty(userDto.getRoleIdList())) {
			ArgumentAssert.notEmpty(userDto.getRoleIdList(), "用户角色不能为空");
			if (!add) {
				SysCacheUtil.delUserCaches(userDo.getId(), userDo.getUsername());
			}
			List<UserRoleDo> userRoleDoList = userDto.getRoleIdList().stream()
				.map(roleId -> UserRoleDo.builder().userId(userDo.getId()).roleId(roleId).build())
				.collect(Collectors.toList());
			userRoleService.removeRoleByUserId(userDo.getId());
			userRoleService.saveBatch(userRoleDoList);
		}
	}

	@Override
	public Boolean removeByIds(List<Long> idList) {
		idList.stream().forEach(id -> {
			ArgumentAssert.notEquals(SecurityUtil.getUser().getId(), id, "不能操作当前登录用户");
			UserDo userDo = repository.selectById(id);
			SysCacheUtil.delUserCaches(userDo.getId(), userDo.getUsername());
			userRoleService.removeRoleByUserId(userDo.getId());
			this.removeById(userDo.getId());
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
	public List<UserDo> listAncestorUsersByUsername(String username) {
		UserDo userDo = this.getOne(Wrappers.<UserDo>query().lambda().eq(UserDo::getUsername, username));

		DeptDo deptDo = deptService.getById(userDo.getDeptId());
		if (deptDo == null) {
			return null;
		}

		Long parentId = deptDo.getParentId();
		return this.list(Wrappers.<UserDo>query().lambda().eq(UserDo::getDeptId, parentId));
	}

	@Override
	public void lockOrUnLock(Set<Long> idList) {
		ArgumentAssert.notEmpty(idList, "idList不能为空");
		for (Long id : idList) {
			ArgumentAssert.notEquals(SecurityUtil.getUser().getId(), id, "不能操作当前登录用户");
			UserDo userDo = repository.selectById(id);
			ArgumentAssert.notNull(userDo, "无法找到ID为" + id + "的数据");
			userDo.setAvailable(
				CommonConstants.YES.equals(userDo.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
			SysCacheUtil.delUserCaches(userDo.getId(), userDo.getUsername());
			int i = repository.updateById(userDo);
			ArgumentAssert.isTrue(i != 0, "无法更新ID为" + id + "的数据");
		}
	}

	@Override
	public void resetPassword(PasswordRestVo passwordRestVo) {

		ArgumentAssert.equals(passwordRestVo.getNewPassword(), passwordRestVo.getConfirmPassword(), "两次输入密码不一致");
		passwordRestVo.setPasswordPlaintext(passwordRestVo.getNewPassword());
		passwordRestVo.setNewPassword(passwordEncoder.encode(passwordRestVo.getNewPassword()));

		Object tempCode = RedisUtil.getCacheString(SecurityConstants.DEFAULT_CODE_KEY + passwordRestVo.getPhone());
		ArgumentAssert.equals(passwordRestVo.getCode(), tempCode, "验证码输入有误");
		UserDo userDo = repository
			.selectOne(Wrappers.<UserDo>query().lambda().eq(UserDo::getUsername, passwordRestVo.getUsername()));
		updatePassword(userDo, passwordRestVo.getPasswordPlaintext(), passwordRestVo.getNewPassword());
	}

	private void updatePassword(UserDo userDo, String passwordPlaintext, String newPassword) {
		userDo.setPassword(newPassword);
		SysCacheUtil.delBaseUserCaches(userDo.getId(), userDo.getUsername());
		repository.updateById(userDo);
		log.debug("Changed password for User: {}", userDo);
	}

	@Override
	public void changePassword(String username, PasswordChangeVo passwordChangeVo) {

		ArgumentAssert.isTrue(passwordChangeVo != null && checkPasswordLength(passwordChangeVo.getNewPassword()), "密码格式有误");
		ArgumentAssert.notEquals(passwordChangeVo.getNewPassword(), passwordChangeVo.getOldPassword(), "新旧密码不能相同");
		ArgumentAssert.equals(passwordChangeVo.getNewPassword(), passwordChangeVo.getConfirmPassword(), "两次输入密码不一致");
		UserDo userDo = repository.selectOne(Wrappers.<UserDo>query().lambda().eq(UserDo::getUsername, username));
		ArgumentAssert.isTrue(passwordEncoder.matches(passwordChangeVo.getOldPassword(), userDo.getPassword()), "输入原密码有误");

		passwordChangeVo.setNewPassword(passwordEncoder.encode(passwordChangeVo.getNewPassword()));

		updatePassword(userDo, passwordChangeVo.getConfirmPassword(), passwordChangeVo.getNewPassword());
	}

	@Override
	public void save(@Valid UserExcelVo userExcelVo) {
		UserDto user = new UserDto();
		BeanUtils.copyProperties(userExcelVo, user);
		DeptDo deptDo = deptService.getOne(Wrappers.<DeptDo>query().lambda().eq(DeptDo::getName, userExcelVo.getDeptName()));
		if (deptDo != null) {
			user.setDeptId(deptDo.getId());
		}
		RoleDo roleDo = roleService.getOne(Wrappers.<RoleDo>query().lambda().eq(RoleDo::getName, userExcelVo.getRoleName()));
		ArgumentAssert.notNull(roleDo, () -> new BizException("无法获取角色" + userExcelVo.getRoleName() + "信息"));
		user.setRoleIdList(Lists.newArrayList(roleDo.getId()));
		saveOrUpdate(user);
	}

	@Override
	@Transactional(readOnly = true)
	public List<UserDo> findListByRoleId(Long roleId) {
		return repository.findListByRoleId(roleId);
	}

	@Override
	public void updateEmail(String username, UserEmailDto userEmailDto) {
		UserDo userDo = repository.selectOne(Wrappers.<UserDo>lambdaQuery().eq(UserDo::getUsername, username));
		ArgumentAssert.notNull(userDo, "无法获取用户信息" + username);
		ArgumentAssert.isTrue(passwordEncoder.matches(userEmailDto.getPassword(), userDo.getPassword()), "输入密码有误");
		userDo.setEmail(userEmailDto.getEmail());
		SysCacheUtil.delBaseUserCaches(userDo.getId(), userDo.getUsername());
		repository.updateById(userDo);
	}

	@Override
	public void updateAvatar(String username, String avatar) {
		UserDo userDo = repository.selectOne(Wrappers.<UserDo>lambdaQuery().eq(UserDo::getUsername, username));
		ArgumentAssert.notNull(userDo, "无法获取用户信息" + username);
		userDo.setAvatar(avatar);
		SysCacheUtil.delBaseUserCaches(userDo.getId(), userDo.getUsername());
		repository.updateById(userDo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean initUser(UserDo userDo) {
		// username before comparing with database
		if (exitUserByUserName(userDo)) {
			throw new EntityExistException(UserDo.class, "username", userDo.getUsername());
		}
		if (StringUtil.isNotEmpty(userDo.getPassword())) {
			userDo.setPassword(passwordEncoder.encode(userDo.getPassword()));
		}
		super.saveOrUpdate(userDo);
		return userRoleService.initAdmin(userDo.getId());
	}

	@Override
	@Transactional(readOnly = true)
	public long todayUserCount() {
		return count(Wraps.<UserDo>lbQ().leFooter(UserDo::getCreatedDate, LocalDateTime.now()).geHeader(UserDo::getCreatedDate, LocalDateTime.now()));
	}

}
