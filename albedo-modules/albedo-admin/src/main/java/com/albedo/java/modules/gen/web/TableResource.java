package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.dto.TableQueryCriteria;
import com.albedo.java.modules.gen.service.TableService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
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
public class TableResource extends BaseResource {

	private final TableService tableService;


	@GetMapping(value = "/table-list")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public R tableList() {
		return R.buildOkData(CollUtil.convertSelectDataList(tableService.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public R formData(TableFromDto tableVo) {
		Map<String, Object> map = tableService.findFormData(tableVo);
		return R.buildOkData(map);
	}

	/**
	 * @param pm
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	@Log(value = "业务表查看")
	public R getPage(PageModel pm, TableQueryCriteria tableQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tableQueryCriteria);
		pm = tableService.page(pm, wrapper);
		return R.buildOkData(pm);
	}

	@Log(value = "业务表编辑")
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public R save(@Valid @RequestBody TableDto tableDto) {
		// 验证表是否已经存在
		if (StringUtil.isBlank(tableDto.getId()) && !tableService.checkTableName(tableDto.getName())) {
			return R.buildFail("保存失败！" + tableDto.getName() + " 表已经存在！");
		}
		tableService.saveOrUpdate(tableDto);
		return R.buildOk(StringUtil.toAppendStr("保存", tableDto.getName(), "成功"));
	}
	/**
	 * @param id
	 * @return
	 */
	@PutMapping("refresh-column"+CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public R refreshColumn(@PathVariable String id) {
		log.debug("REST request to refreshColumn Entity : {}", id);
		tableService.refreshColumn(id);
		return R.buildOk("操作成功");
	}

	@DeleteMapping
	@Log(value = "业务表删除")
	@PreAuthorize("@pms.hasPermission('gen_table_del')")
	public R delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete table: {}", ids);
		tableService.delete(ids);
		return R.buildOk("删除成功");
	}


}
