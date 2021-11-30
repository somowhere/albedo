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
package com.albedo.java.modules.sys.web;


import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.modules.sys.domain.dto.LogLoginQueryCriteria;
import com.albedo.java.modules.sys.service.LogLoginService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Set;

/**
 * 登录日志管理Controller 登录日志
 *
 * @author admin
 * @version 2021-11-30 10:15:00
 */
@RestController
@RequestMapping(value = "${application.admin-path}/sys/log-login")
@AllArgsConstructor
@Api(tags = "登录日志")
public class LogLoginResource extends BaseResource {

	private final LogLoginService service;

	/**
	 * GET / : get all logLogin.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all logLogin
	 */

	@PreAuthorize("@pms.hasPermission('sys_logLogin_view')")
	@GetMapping
	@LogOperate(value = "登录日志管理查看")
	@ApiOperation("登录日志查看")
	public Result getPage(PageModel pm, LogLoginQueryCriteria logLoginQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, logLoginQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	@LogOperate(value = "登录日志导出")
	@ApiOperation("登录日志导出")
	@GetMapping(value = "/download")
	@PreAuthorize("@pms.hasPermission('sys_logOperate_export')")
	public void download(LogLoginQueryCriteria logOperateQueryCriteria, HttpServletResponse response) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(logOperateQueryCriteria);
		ExcelUtil<LogLogin> util = new ExcelUtil(LogLogin.class);
		util.exportExcel(service.list(wrapper), "登录日志", response);
	}

	/**
	 * DELETE //:ids : delete the "ids" LogLogin.
	 *
	 * @param ids the id of the logLogin to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('sys_logLogin_del')")
	@LogOperate(value = "登录日志管理删除")
	@ApiOperation("登录日志删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete LogLogin: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除登录日志成功");
	}
}
