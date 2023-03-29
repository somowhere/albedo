
/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.plugins.database.mybatis.repository.TreeRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 部门管理 Mapper 接口
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Mapper
public interface DeptRepository extends TreeRepository<DeptDo> {

	/**
	 * 部门树数据集合
	 *
	 * @param wrapper
	 * @return
	 */
	List<DeptVo> findVoList(@Param(Constants.WRAPPER) QueryWrapper<DeptDo> wrapper);

	/**
	 * 获取集合根据roleId
	 *
	 * @param roleId
	 * @return
	 */
	List<DeptDo> findListByRoleId(String roleId);

}
