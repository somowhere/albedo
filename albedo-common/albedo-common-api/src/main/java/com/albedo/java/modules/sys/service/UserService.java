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

package com.albedo.java.modules.sys.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserEmailDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 * @date 2019/2/1
 */
public interface UserService extends DataService<User, UserDto, String> {
	/**
	 * 查询用户信息
	 *
	 * @param userVo 用户
	 * @return userInfo
	 */
	UserInfo getInfo(UserVo userVo);

	/**
	 * findPage 分页查询用户信息（含有角色信息）
	 *
	 * @param pm
	 * @param userQueryCriteria
	 * @param dataScope
	 * @return com.baomidou.mybatisplus.core.metadata.IPage<com.albedo.java.modules.sys.domain.vo.UserVo>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	IPage<UserVo> findPage(PageModel pm, UserQueryCriteria userQueryCriteria, DataScope dataScope);

	/**
	 * findPage
	 *
	 * @param userQueryCriteria
	 * @param dataScope
	 * @return java.util.List<com.albedo.java.modules.sys.domain.vo.UserVo>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	List<UserVo> findPage(UserQueryCriteria userQueryCriteria, DataScope dataScope);

	/**
	 * 删除用户
	 *
	 * @param idList 用户
	 * @return boolean
	 */
	Boolean removeByIds(List<String> idList);

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	UserVo findUserVoById(String id);

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return 用户信息
	 */
	UserDto findDtoById(String id);

	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	List<User> listAncestorUsersByUsername(String username);

	/**
	 * lockOrUnLock
	 *
	 * @param idList
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void lockOrUnLock(Set<String> idList);

	/**
	 * resetPassword
	 *
	 * @param passwordRestVo
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void resetPassword(PasswordRestVo passwordRestVo);

	/**
	 * changePassword
	 *
	 * @param username
	 * @param passwordChangeVo
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void changePassword(String username, PasswordChangeVo passwordChangeVo);

	/**
	 * findVoByUsername
	 *
	 * @param username
	 * @return com.albedo.java.modules.sys.domain.vo.UserVo
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	UserVo findVoByUsername(String username);

	/**
	 * save
	 *
	 * @param userExcelVo
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	void save(UserExcelVo userExcelVo);

	/**
	 * findListByRoleId
	 *
	 * @param roleId
	 * @return java.util.List<com.albedo.java.modules.sys.domain.User>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	List<User> findListByRoleId(String roleId);

	/**
	 * updateEmail
	 *
	 * @param username
	 * @param userEmailDto
	 * @author somewhere
	 * @updateTime 2020/5/31 17:36
	 */
	void updateEmail(String username, UserEmailDto userEmailDto);

	/**
	 * updateAvatar
	 *
	 * @param username
	 * @param avatar
	 * @author somewhere
	 * @updateTime 2020/5/31 17:36
	 */
	void updateAvatar(String username, String avatar);
}
