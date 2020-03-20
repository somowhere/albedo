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
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.TreeQuery;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.TreeVoResource;
import com.albedo.java.modules.sys.domain.vo.DeptDataVo;
import com.albedo.java.modules.sys.service.DeptService;
import com.google.common.collect.Lists;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

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
public class DeptResource extends TreeVoResource<DeptService, DeptDataVo> {

	public DeptResource(DeptService service) {
		super(service);
	}

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(service.findOneVo(id));
	}

	/**
	 * 返回树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/tree")
	public R listDeptTrees(TreeQuery treeQuery) {
		return R.buildOkData(service.listTrees(treeQuery));
	}

	/**
	 * 返回当前用户树形菜单集合
	 *
	 * @return 树形菜单
	 */
	@GetMapping(value = "/user-tree")
	public R findCurrentUserDeptTrees() {
		String parentDeptId = SecurityUtil.getUser().getParentDeptId();
		String deptId = SecurityUtil.getUser().getDeptId();
		return new R<>(service.findCurrentUserDeptTrees(parentDeptId, deptId));
	}

	/**
	 * 添加
	 *
	 * @param deptDataVo 实体
	 * @return success/false
	 */
	@PostMapping("/")
	@PreAuthorize("@pms.hasPermission('sys_dept_edit')")
	@Log(value = "部门管理", businessType = BusinessType.EDIT)
	public R save(@Valid @RequestBody DeptDataVo deptDataVo) {
		return new R<>(service.saveDept(deptDataVo));
	}

	/**
	 * 删除
	 *
	 * @param ids ID
	 * @return success/false
	 */
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@PreAuthorize("@pms.hasPermission('sys_dept_del')")
	@Log(value = "部门管理", businessType = BusinessType.DELETE)
	public R removeById(@PathVariable String ids) {
		return new R<>(service.removeDeptByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT))));
	}

}
