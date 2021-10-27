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

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.mybatis.service.impl.BaseServiceImpl;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.repository.UserRoleRepository;
import com.albedo.java.modules.sys.service.UserRoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户角色表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@RequiredArgsConstructor
public class UserRoleServiceImpl extends BaseServiceImpl<UserRoleRepository, UserRole> implements UserRoleService {

	private final RoleRepository roleRepository;
	/**
	 * 根据用户Id删除该用户的角色关系
	 *
	 * @param userId 用户ID
	 * @return boolean
	 * @author 寻欢·李
	 * @date 2017年12月7日 16:31:38
	 */
	@Override
	public Boolean removeRoleByUserId(Long userId) {
		return repository.deleteByUserId(userId);
	}

	@Override
	public boolean initAdmin(Long userId) {
		Role role = roleRepository.selectOne(Wraps.<Role>lbQ().eq(Role::getCode, CommonConstants.ADMIN_ROLE_CODE));
		if (role == null) {
			throw BizException.wrap("初始化用户角色失败, 无法查询到内置角色:%s",  CommonConstants.ADMIN_ROLE_CODE);
		}
		UserRole userRole = UserRole.builder()
			.userId(userId).roleId(role.getId())
			.build();

		return super.save(userRole);
	}

}
