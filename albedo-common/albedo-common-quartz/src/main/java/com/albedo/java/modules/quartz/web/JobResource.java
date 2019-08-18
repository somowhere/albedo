/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.R;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.web.resource.DataVoResource;
import com.albedo.java.modules.quartz.domain.vo.JobDataVo;
import com.albedo.java.modules.quartz.service.JobService;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;

import javax.validation.Valid;

/**
 * 任务调度Controller 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@RestController
@RequestMapping(value = "${application.admin-path}/quartz/job")
public class JobResource extends DataVoResource<JobService, JobDataVo> {

	public JobResource(JobService service) {
		super(service);
	}

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('quartz_job_view')")
	public R get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return R.buildOkData(service.findOneVo(id));
	}

	/**
	 * GET / : get all job.
	 *
	 * @param pm the pagination information
	 * @return the R with status 200 (OK) and with body all job
	 */

	@PreAuthorize("@pms.hasPermission('quartz_job_view')")
	@GetMapping("/")
	public R getPage(PageModel pm) {
		return R.buildOkData(service.findPage(pm));
	}

	/**
	 * POST / : Save a jobVo.
	 *
	 * @param jobVo the HTTP job
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@Log(value = "任务调度", businessType = BusinessType.EDIT)
	@PostMapping(value = "/", produces = MediaType.APPLICATION_JSON_VALUE)
	public R save(@Valid @RequestBody JobDataVo jobVo) {
		log.debug("REST request to save JobForm : {}", jobVo);
		service.save(jobVo);
		return R.buildOk("保存任务调度成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_del')")
	@Log(value = "任务调度", businessType = BusinessType.DELETE)
	@DeleteMapping(CommonConstants.URL_IDS_REGEX)
	public R delete(@PathVariable String ids) {
		log.debug("REST request to delete Job: {}", ids);
		service.deleteBatchIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("删除任务调度成功");
	}

	/**
	 * available //:ids : available the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@Log(value = "任务调度", businessType = BusinessType.EDIT)
	@PostMapping("/available" + CommonConstants.URL_IDS_REGEX)
	public R available(@PathVariable String ids) {
		log.debug("REST request to available Job: {}", ids);
		service.available(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * concurrent //:ids : concurrent the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@Log(value = "任务调度", businessType = BusinessType.EDIT)
	@PostMapping("/run" + CommonConstants.URL_IDS_REGEX)
	public R run(@PathVariable String ids) {
		log.debug("REST request to available Job: {}", ids);
		service.runByIds(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * concurrent //:ids : concurrent the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the R with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@Log(value = "任务调度", businessType = BusinessType.EDIT)
	@PostMapping("/concurrent" + CommonConstants.URL_IDS_REGEX)
	public R concurrent(@PathVariable String ids) {
		log.debug("REST request to available Job: {}", ids);
		service.concurrent(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
		return R.buildOk("操作成功");
	}

	/**
	 * 校验cron表达式是否有效
	 */
	@GetMapping("/check-cron-expression")
	public boolean checkCronExpressionIsValid(JobDataVo jobDataVo) {
		return service.checkCronExpressionIsValid(jobDataVo.getCronExpression());
	}

}
