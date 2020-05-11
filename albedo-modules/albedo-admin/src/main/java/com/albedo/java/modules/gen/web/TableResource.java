package com.albedo.java.modules.gen.web;

import cn.hutool.core.util.EscapeUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.domain.vo.TableFormVo;
import com.albedo.java.modules.gen.service.TableService;
import com.google.common.collect.Lists;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * 业务表Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${application.admin-path}/gen/table")
public class TableResource extends DataVoResource<TableService, TableDataVo> {

	public TableResource(TableService service) {
		super(service);
	}

	@GetMapping(value = "/table-list")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public ResponseEntity tableList() {
		return ResultBuilder.buildOk(CollUtil.convertSelectDataList(service.findTableListFormDb(null), Table.F_NAME, Table.F_NAMESANDTITLE));
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public ResponseEntity formData(TableFormVo tableVo) {
		Map<String, Object> map = service.findFormData(tableVo);
		return ResultBuilder.buildOk(map);
	}


	/**
	 * @param pm
	 * @return
	 */
	@GetMapping(value = "/")
	@PreAuthorize("@pms.hasPermission('gen_table_view')")
	public ResponseEntity getPage(PageModel pm) {
		pm = service.findPage(pm);
		return ResultBuilder.buildOk(pm);
	}

	@Log(value = "业务表", businessType = BusinessType.EDIT)
	@PostMapping("/")
	@PreAuthorize("@pms.hasPermission('gen_table_edit')")
	public ResponseEntity save(@Valid @RequestBody TableDataVo tableDataVo) {
		// 验证表是否已经存在
		if (StringUtil.isBlank(tableDataVo.getId()) && !service.checkTableName(tableDataVo.getName())) {
			return ResultBuilder.buildFail("保存失败！" + tableDataVo.getName() + " 表已经存在！");
		}
		service.save(tableDataVo);
		return ResultBuilder.buildOk(StringUtil.toAppendStr("保存", tableDataVo.getName(), "成功"));
	}

	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	@Log(value = "业务表", businessType = BusinessType.DELETE)
	@PreAuthorize("@pms.hasPermission('gen_table_del')")
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete table: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return ResultBuilder.buildOk("删除成功");
	}


}
