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

package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.plugins.mybatis.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.DatasourceConf;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.dto.TableQueryCriteria;
import com.albedo.java.modules.gen.domain.vo.TableFormDataVo;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.albedo.java.modules.gen.service.TableService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Set;

/**
 * 业务表Controller
 *
 * @author somewhere
 */
@RestController
@RequestMapping("${application.admin-path}/gen/table")
@AllArgsConstructor
@Api(tags = "代码表")
public class TableResource extends BaseResource {

	private final TableService tableService;

	private final DatasourceConfService datasourceConfService;

	@GetMapping(value = "/ds-list")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public Result<SelectVo> dsList() {
		return Result.buildOkData(CollUtil.convertSelectVoList(datasourceConfService.list(), DatasourceConf.F_NAME,
			DatasourceConf.F_NAME));
	}

	@GetMapping(value = "/ds-table-list/{dsName:^[a-zA-Z0-9]+$}")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public Result<SelectVo> tableList(@PathVariable String dsName) {
		TableDto tableDto = new TableDto();
		tableDto.setDsName(dsName);
		return Result.buildOkData(CollUtil.convertSelectVoList(tableService.findTableListFormDb(tableDto), Table.F_NAME,
			Table.F_NAMESANDTITLE));
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public Result<TableFormDataVo> formData(TableFromDto tableVo) {
		TableFormDataVo tableFormDataVo = tableService.findFormData(tableVo);
		return Result.buildOkData(tableFormDataVo);
	}

	/**
	 * @param pm
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	@LogOperate(value = "业务表查看")
	public Result getPage(PageModel pm, TableQueryCriteria tableQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tableQueryCriteria);
		pm = tableService.page(pm, wrapper);
		return Result.buildOkData(pm);
	}

	@LogOperate(value = "业务表编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public Result save(@Valid @RequestBody TableDto tableDto) {
		// 验证表是否已经存在
		if (StringUtil.isBlank(tableDto.getId()) && !tableService.checkTableName(tableDto.getName())) {
			return Result.buildFail("保存失败！" + tableDto.getName() + " 表已经存在！");
		}
		tableService.saveOrUpdate(tableDto);
		return Result.buildOk(StringUtil.toAppendStr("保存", tableDto.getName(), "成功"));
	}

	/**
	 * @param id
	 * @return
	 */
	@PutMapping("refresh-column" + CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public Result refreshColumn(@PathVariable String id) {
		log.debug("REST request to refreshColumn Entity : {}", id);
		TableDto tableDto = tableService.getOneDto(id);
		Assert.notNull(tableDto, "对象 " + id + " 信息为空，操作失败");
		tableService.getTableFormDb(tableDto);
		tableService.refreshColumn(tableDto);
		return Result.buildOk("操作成功");
	}

	@DeleteMapping
	@LogOperate(value = "业务表删除")
	@PreAuthorize("@pms.hasPermission('gen_table_del')")
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete table: {}", ids);
		tableService.delete(ids);
		return Result.buildOk("删除成功");
	}

	/**
	 * 刷新缓存
	 *
	 * @return 是否成功
	 */
	@ApiOperation(value = "刷新缓存", notes = "刷新缓存")
	@PostMapping("refresh-cache")
	@LogOperate("业务表刷新缓存")
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public Result refreshCache() {
		tableService.refreshCache();
		return Result.buildOk("刷新缓存成功");
	}

	/**
	 * 清理缓存
	 *
	 * @return 是否成功
	 */
	@ApiOperation(value = "清理缓存", notes = "清理缓存")
	@PostMapping("clearCache")
	@LogOperate("'业务表清理缓存'")
	@PreAuthorize("hasAnyPermission('gen_table_edit')")
	public Result clearCache() {
		tableService.clearCache();
		return Result.buildOk("清理缓存成功");
	}

}
