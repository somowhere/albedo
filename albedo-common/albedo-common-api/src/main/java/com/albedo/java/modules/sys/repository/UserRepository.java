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

package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface UserRepository extends BaseRepository<User> {

	/**
	 * 通过用户名查询用户信息（含有角色信息）
	 *
	 * @param username 用户名
	 * @return userVo
	 */
	UserVo findVoByUsername(String username);

	/**
	 * 分页查询用户信息（含角色）
	 *
	 * @param page      分页
	 * @param wrapper   查询参数
	 * @param dataScope 数据权限
	 * @return list
	 */
	IPage<UserVo> findUserVoPage(IPage page, @Param(Constants.WRAPPER) Wrapper<User> wrapper, DataScope dataScope);

	/**
	 * 分页查询用户信息（含角色）
	 *
	 * @param wrapper   查询参数
	 * @param dataScope 数据权限
	 * @return list
	 */
	List<UserVo> findUserVoPage(@Param(Constants.WRAPPER) Wrapper<User> wrapper, DataScope dataScope);

	/**
	 * 通过ID查询用户信息
	 *
	 * @param id 用户ID
	 * @return userVo
	 */
	UserVo findUserVoById(String id);

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
	 * findListByRoleIds
	 *
	 * @param roleIds
	 * @return java.util.List<com.albedo.java.modules.sys.domain.User>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	List<User> findListByRoleIds(@Param("roleIds") Set<String> roleIds);

	/**
	 * findListByMenuId
	 *
	 * @param menuId
	 * @return java.util.List<com.albedo.java.modules.sys.domain.User>
	 * @author somewhere
	 * @updateTime 2020/5/31 17:35
	 */
	List<User> findListByMenuId(String menuId);

}
