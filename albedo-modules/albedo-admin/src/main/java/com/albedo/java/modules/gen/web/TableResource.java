package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.dto.TableQueryCriteria;
import com.albedo.java.modules.gen.service.TableService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
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


	@GetMapping(value = "/table-list")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public Result tableList() {
		return Result.buildOkData(CollUtil.convertSelectDataList(tableService.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public Result formData(TableFromDto tableVo) {
		Map<String, Object> map = tableService.findFormData(tableVo);
		return Result.buildOkData(map);
	}

	/**
	 * @param pageModel
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	@LogOperate(value = "业务表查看")
	public Result getPage(PageModel pageModel, TableQueryCriteria tableQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, tableQueryCriteria);
		pageModel = tableService.page(pageModel, wrapper);
		return Result.buildOkData(pageModel);
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
		tableService.refreshColumn(id);
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


}
