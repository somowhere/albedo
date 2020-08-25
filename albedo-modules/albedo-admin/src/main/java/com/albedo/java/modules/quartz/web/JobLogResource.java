/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.quartz.domain.dto.JobLogQueryCriteria;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Set;

/**
 * 任务调度日志Controller 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@RestController
@RequestMapping(value = "${application.admin-path}/quartz/job-log")
@AllArgsConstructor
@Api(tags = "定时任务日志")
public class JobLogResource extends BaseResource {

	private final JobLogService jobLogService;

	/**
	 * GET / : get all jobLog.
	 *
	 * @param pm the pagination information
	 * @return the Result with status 200 (OK) and with body all jobLog
	 */

	@PreAuthorize("@pms.hasPermission('quartz_jobLog_view')")
	@GetMapping
	@LogOperate(value = "任务日志查看")
	public Result getPage(PageModel pm, JobLogQueryCriteria jobLogQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, jobLogQueryCriteria);
		return Result.buildOkData(jobLogService.page(pm, wrapper));
	}


	/**
	 * DELETE //:ids : delete the "ids" JobLog.
	 *
	 * @param ids the id of the jobLog to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_del')")
	@LogOperate(value = "任务日志删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete JobLog: {}", ids);
		jobLogService.removeByIds(ids);
		return Result.buildOk("删除任务调度日志成功");
	}

	@LogOperate(value = "任务日志清空")
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_clean')")
	@PostMapping("/clean")
	@ResponseBody
	public Result clean() {
		jobLogService.cleanJobLog();
		return Result.buildOk("清空任务调度日志成功");
	}

	@LogOperate(value = "任务日志导出")
	@GetMapping(value = "/download")
	@PreAuthorize("@pms.hasPermission('quartz_jobLog_export')")
	public void download(JobLogQueryCriteria jobLogQueryCriteria, HttpServletResponse response) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(jobLogQueryCriteria);
		ExcelUtil<JobLogExcelVo> util = new ExcelUtil(JobLogExcelVo.class);
		util.exportExcel(jobLogService.findExcelVo(wrapper), "任务调度日志", response);
	}
}
