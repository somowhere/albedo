/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.common.core.util.R;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * 任务调度日志Controller 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@RestController
@RequestMapping(value = "${application.admin-path}/quartz/job-log")
@AllArgsConstructor
public class JobLogResource extends BaseResource {

	private final JobLogService service;

	/**
	 * GET / : get all jobLog.
	 *
	 * @param pm the pagination information
	 * @return the R with status 200 (OK) and with body all jobLog
	 */

	@PreAuthorize("@pms.hasPermission('quartz_jobLog_view')")
	@GetMapping("/")
	public R getPage(PageModel pm) {
		return R.buildOkData(service.findPage(pm));
	}


	/**
	 * DELETE //:ids : delete the "ids" JobLog.
	 *
	 * @param ids the id of the jobLog to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_del')")
	@Log(value = "任务调度日志", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R delete(@PathVariable String ids) {
		log.debug("REST request to delete JobLog: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("删除任务调度日志成功");
	}

	@Log(value = "调度日志", businessType = BusinessType.CLEAN)
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_del')")
	@PostMapping("/clean")
	@ResponseBody
	public R clean() {
		service.cleanJobLog();
		return R.buildOk("清空任务调度日志成功");
	}

	@GetMapping(value = "/export")
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_export')")
	public R export() {
		ExcelUtil<JobLogExcelVo> util = new ExcelUtil(JobLogExcelVo.class);
		return util.exportExcel(Lists.newArrayList(new JobLogExcelVo()), "任务调度日志");
	}
}
