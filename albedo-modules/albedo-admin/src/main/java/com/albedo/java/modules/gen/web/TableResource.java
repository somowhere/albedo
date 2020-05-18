package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ResultBuilder;
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
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Set;

/**
 * 业务表Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${application.admin-path}/gen/table")
@AllArgsConstructor
public class TableResource extends BaseResource {

	private final TableService tableService;

	@GetMapping(value = "/table-list")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public ResponseEntity tableList() {
		return ResultBuilder.buildOk(CollUtil.convertSelectDataList(tableService.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public ResponseEntity formData(TableFromDto tableVo) {
		Map<String, Object> map = tableService.findFormData(tableVo);
		return ResultBuilder.buildOk(map);
	}


	/**
	 * @param pm
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	@Log(value = "业务表", businessType = BusinessType.VIEW)
	public ResponseEntity getPage(PageModel pm, TableQueryCriteria tableQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, tableQueryCriteria);
		pm = tableService.page(pm, wrapper);
		return ResultBuilder.buildOk(pm);
	}

	@Log(value = "业务表", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public ResponseEntity save(@Valid @RequestBody TableDto tableDto) {
		// 验证表是否已经存在
		if (StringUtil.isBlank(tableDto.getId()) && !tableService.checkTableName(tableDto.getName())) {
			return ResultBuilder.buildFail("保存失败！" + tableDto.getName() + " 表已经存在！");
		}
		tableService.saveOrUpdate(tableDto);
		return ResultBuilder.buildOk(StringUtil.toAppendStr("保存", tableDto.getName(), "成功"));
	}

	@DeleteMapping
	@Log(value = "业务表", businessType = BusinessType.DELETE)
	@PreAuthorize("@pms.hasPermission('gen_table_del')")
	public ResponseEntity delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete table: {}", ids);
		tableService.delete(ids);
		return ResultBuilder.buildOk("删除成功");
	}


}
