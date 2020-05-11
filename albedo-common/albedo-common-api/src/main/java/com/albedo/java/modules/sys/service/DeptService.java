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

import com.albedo.java.common.core.vo.TreeNode;
import com.albedo.java.common.persistence.service.TreeService;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryCriteria;
import com.albedo.java.modules.sys.repository.DeptRepository;

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
public interface DeptService extends TreeService<DeptRepository, Dept, DeptDto> {


	/**
	 * 查询用户部门树
	 *
	 * @return
	 */
	Set<TreeNode> findDeptTrees(DeptQueryCriteria deptQueryCriteria, String deptId);

	List<String> findDescendantIdList(String deptId);

	/**
	 * 添加信息部门
	 *
	 * @param deptDto
	 * @return
	 */
	void saveOrUpdate(DeptDto deptDto);

	/**
	 * 删除部门
	 *
	 * @param ids 部门 ID
	 * @return 成功、失败
	 */
	Boolean removeDeptByIds(Set<String> ids);

}
