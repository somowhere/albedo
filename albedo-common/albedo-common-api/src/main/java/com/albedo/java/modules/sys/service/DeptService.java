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

import com.albedo.java.common.persistence.service.TreeService;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
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
public interface DeptService extends TreeService<Dept, DeptDto> {


	List<String> findDescendantIdList(String deptId);

	/**
	 * 添加信息部门
	 *
	 * @param deptDto
	 * @return
	 */
	void saveOrUpdate(DeptDto deptDto);

	IPage<DeptVo> findTreeList(DeptQueryCriteria deptQueryCriteria);

	void lockOrUnLock(Set<String> ids);
}
