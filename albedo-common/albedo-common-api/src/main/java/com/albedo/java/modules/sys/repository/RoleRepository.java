
/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Mapper
public interface RoleRepository extends BaseRepository<RoleDo> {

	/**
	 * 通过用户ID，查询角色信息
	 *
	 * @param userId
	 * @return
	 */
	List<RoleDo> findListByUserId(Long userId);

	/**
	 * 通过部门ID，查询角色信息
	 *
	 * @param deptId
	 * @return
	 */
	List<RoleDo> findListByDeptId(Long deptId);

	/**
	 * 通过菜单ID，查询角色信息
	 *
	 * @param menuId
	 * @return
	 */
	List<RoleDo> findListByMenuId(Long menuId);

}
