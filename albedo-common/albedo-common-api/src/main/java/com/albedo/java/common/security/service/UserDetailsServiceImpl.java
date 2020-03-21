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

package com.albedo.java.common.security.service;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * 用户详细信息
 *
 * @author somewhere
 */
@Slf4j
@Service
@AllArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {
	private final UserService userService;
	private final RoleService roleService;
	private final DeptService deptService;
	private final CacheManager cacheManager;


	/**
	 * 用户密码登录
	 *
	 * @param username 用户名
	 * @return
	 */
	@Override
	@SneakyThrows
	public UserDetails loadUserByUsername(String username) {
		Cache cache = cacheManager.getCache("user_details");
		if (cache != null && cache.get(username) != null) {
			return (UserDetail) cache.get(username).get();
		}
		UserVo userVo = userService.findOneVoByUserName(username);
		if (userVo == null) {
			throw new UsernameNotFoundException("用户不存在");
		}
		Assert.isTrue(userVo.isAvailable(),"用户【"+username+"】已被锁定，无法登录");
		UserDetails userDetails = getUserDetails(userService.getUserInfo(userVo));
		cache.put(username, userDetails);
		return userDetails;
	}

	/**
	 * 构建userdetails
	 *
	 * @param userInfo 用户信息
	 * @return
	 */
	private UserDetails getUserDetails(UserInfo userInfo) {
		if (userInfo == null) {
			throw new UsernameNotFoundException("用户不存在");
		}

		Set<String> dbAuthsSet = new HashSet<>();
		if (ArrayUtil.isNotEmpty(userInfo.getRoles())) {
			// 获取角色
			Arrays.stream(userInfo.getRoles()).forEach(role -> dbAuthsSet.add(SecurityConstants.ROLE + role));
			// 获取资源
			dbAuthsSet.addAll(Arrays.asList(userInfo.getPermissions()));

		}
		Collection<? extends GrantedAuthority> authorities
			= AuthorityUtils.createAuthorityList(dbAuthsSet.toArray(new String[0]));
		UserVo userVo = userInfo.getUser();
		DataScope dataScope = new DataScope();
		if(CollUtil.isNotEmpty(userVo.getRoleList())){
			for(Role role: userVo.getRoleList()){
				if(SecurityConstants.ROLE_DATA_SCOPE_ALL.equals(role.getDataScope())){
					dataScope.setAll(true);
					break;
				}else if(SecurityConstants.ROLE_DATA_SCOPE_DEPT_ALL.equals(role.getDataScope())){
					dataScope.getDeptIds().addAll(deptService.findDescendantIdList(userVo.getDeptId()));
				}else if(SecurityConstants.ROLE_DATA_SCOPE_DEPT.equals(role.getDataScope())){
					dataScope.getDeptIds().add(userVo.getDeptId());
				}else if(SecurityConstants.ROLE_DATA_SCOPE_SELF.equals(role.getDataScope())){
					dataScope.setSelf(true);
					dataScope.setUserId(userVo.getId());
				}else if(SecurityConstants.ROLE_DATA_SCOPE_CUSTOM.equals(role.getDataScope())){
					dataScope.getDeptIds().addAll(roleService.findRoleDeptIdList(role.getId()));
				}
			}
		}
		// 构造security用户
		return new UserDetail(userVo.getId(), userVo.getDeptId(), userVo.getParentDeptId(), userVo.getDeptName(), userVo.getUsername(), SecurityConstants.BCRYPT + userVo.getPassword(),
			userVo.isAvailable(), true, true, true, authorities, dataScope);
	}
}
