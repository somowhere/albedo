/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfDto;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfQueryCriteria;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Set;

/**
 * 数据源Controller 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
@RestController
@RequestMapping(value = "${application.admin-path}/gen/datasource-conf")
@AllArgsConstructor
@Api(tags = "表数据源")
public class DatasourceConfResource extends BaseResource {

	private final DatasourceConfService service;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		DatasourceConfDto datasourceConfDto = service.getOneDto(id);
		datasourceConfDto.setPassword(null);
		return Result.buildOkData(datasourceConfDto);
	}

	/**
	 * GET / : get all datasourceConf.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all datasourceConf
	 */

	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_view')")
	@GetMapping
	@LogOperate(value = "数据源查看")
	public Result getPage(PageModel pm, DatasourceConfQueryCriteria datasourceConfQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, datasourceConfQueryCriteria);
		return Result.buildOkData(service.page(pm, wrapper));
	}

	/**
	 * POST / : Save a datasourceConfDto.
	 *
	 * @param datasourceConfDto the HTTP datasourceConf
	 */
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_edit')")
	@LogOperate(value = "数据源编辑")
	@PostMapping
	public Result save(@Valid @RequestBody DatasourceConfDto datasourceConfDto) {
		log.debug("REST request to save DatasourceConfDto : {}", datasourceConfDto);
		service.saveOrUpdate(datasourceConfDto);
		return Result.buildOk("保存数据源成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" DatasourceConf.
	 *
	 * @param ids the id of the datasourceConf to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('gen_datasourceConf_del')")
	@LogOperate(value = "数据源删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete DatasourceConf: {}", ids);
		service.removeByIds(ids);
		return Result.buildOk("删除数据源成功");
	}

}
