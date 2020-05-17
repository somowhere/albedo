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
package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.domain.dto.DeptQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.DeptVo;
import com.albedo.java.modules.sys.service.DeptService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Set;

/**
 * <p>
 * 部门管理 前端控制器
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/dept")
@AllArgsConstructor
public class DeptResource extends BaseResource {

	private final DeptService deptService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_dept_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(deptService.getOneDto(id));
	}


	/**
	 * 返回当前部门树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public R tree(DeptQueryCriteria deptQueryCriteria) {
		DataScope dataScope = SecurityUtil.getUser().getDataScope();
		if (!dataScope.isAll()) {
			deptQueryCriteria.setDeptIds(dataScope.getDeptIds());
		}
		return R.buildOkData(deptService.findTreeNode(deptQueryCriteria));
	}

	/**
	 * 部门树列表信息
	 *
	 * @return 分页对象
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_view')")
	@Log(value = "部门管理", businessType = BusinessType.VIEW)
	public R<IPage<DeptVo>> findTreeList(DeptQueryCriteria deptQueryCriteria) {
		return R.buildOkData(deptService.findTreeList(deptQueryCriteria));
	}

	/**
	 * 添加
	 *
	 * @param deptDto 实体
	 * @return success/false
	 */
	@PostMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_edit')")
	@Log(value = "部门管理", businessType = BusinessType.EDIT)
	public R save(@Valid @RequestBody DeptDto deptDto) {
		deptService.saveOrUpdate(deptDto);
		return R.buildOk("操作成功");
	}

	/**
	 * @param ids
	 * @return
	 */
	@PutMapping
	@Log(value = "用户管理", businessType = BusinessType.LOCK)
	@PreAuthorize("@pms.hasPermission('sys_dept_lock')")
	public R lockOrUnLock(@RequestBody Set<String> ids) {
		deptService.lockOrUnLock(ids);
		return R.buildOk("操作成功");
	}

	/**
	 * 删除
	 *
	 * @param ids ID
	 * @return success/false
	 */
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('sys_dept_del')")
	@Log(value = "部门管理", businessType = BusinessType.DELETE)
	public R removeById(@RequestBody Set<String> ids) {
		return R.buildOkData(deptService.removeByIds(ids));
	}


}
