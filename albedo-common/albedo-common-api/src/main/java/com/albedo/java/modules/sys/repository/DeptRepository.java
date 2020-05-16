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

package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.persistence.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
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
public interface DeptRepository extends TreeRepository<Dept> {

	/**
	 * 关联dept——relation
	 *
	 * @return 数据列表
	 */
	List<Dept> findList();

	List<DeptVo> findDeptVoList(@Param(Constants.WRAPPER) QueryWrapper<Dept> wrapper);

}
