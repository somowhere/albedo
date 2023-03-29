
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

package com.albedo.java.modules.sys.service;

import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryDto;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.plugins.database.mybatis.service.TreeService;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 部门管理 服务类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
public interface DeptService extends TreeService<DeptDo, DeptDto> {

	/**
	 * 获取祖先后代节点
	 *
	 * @param deptId
	 * @return
	 */
	List<Long> findDescendantIdList(Long deptId);

	/**
	 * 批量删除
	 *
	 * @param ids
	 * @return
	 */
	boolean removeByIds(Set<Long> ids);

	/**
	 * 添加信息部门
	 *
	 * @param deptDto
	 * @return
	 */
	@Override
	void saveOrUpdate(DeptDto deptDto);

	/**
	 * 查询部门树集合
	 *
	 * @param deptQueryDto
	 * @return
	 */
	IPage<DeptVo> findTreeList(DeptQueryDto deptQueryDto);

	/**
	 * 锁定、解锁
	 *
	 * @param ids
	 */
	void lockOrUnLock(Set<Long> ids);

}
