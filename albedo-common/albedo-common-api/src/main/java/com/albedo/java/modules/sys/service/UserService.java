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
import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.vo.UserDataVo;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
public interface UserService extends DataVoService<UserRepository, User, String, UserDataVo> {
	/**
	 * 查询用户信息
	 *
	 * @param userVo 用户
	 * @return userInfo
	 */
	UserInfo getUserInfo(UserVo userVo);

	/**
	 * 分页查询用户信息（含有角色信息）
	 *
	 * @param pm 分页对象
	 * @return
	 */
	IPage getUserPage(PageModel pm);

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
	UserVo getUserVoById(String id);

	/**
	 * 查询上级部门的用户信息
	 *
	 * @param username 用户名
	 * @return R
	 */
	List<User> listAncestorUsersByUsername(String username);

	void lockOrUnLock(List<String> idList);

	void resetPassword(PasswordRestVo passwordRestVo);

	void changePassword(String username, PasswordChangeVo passwordChangeVo);

	UserVo findOneVoByUserName(String username);

	void save(UserExcelVo userExcelVo);
}
