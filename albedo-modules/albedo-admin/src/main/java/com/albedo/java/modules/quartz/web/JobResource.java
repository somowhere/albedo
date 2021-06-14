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

package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.quartz.domain.dto.JobDto;
import com.albedo.java.modules.quartz.domain.dto.JobQueryCriteria;
import com.albedo.java.modules.quartz.service.JobService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Set;

/**
 * 任务调度Controller 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@RestController
@RequestMapping(value = "${application.admin-path}/quartz/job")
@AllArgsConstructor
@Api(tags = "定时任务")
public class JobResource extends BaseResource {

	private final JobService jobService;

	/**
	 * @param id
	 * @return
	 */
	@GetMapping(CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('quartz_job_view')")
	public Result get(@PathVariable String id) {
		log.debug("REST request to get Entity : {}", id);
		return Result.buildOkData(jobService.getOneDto(id));
	}

	/**
	 * GET / : get all job.
	 *
	 * @param pageModel the pagination information
	 * @return the Result with status 200 (OK) and with body all job
	 */

	@PreAuthorize("@pms.hasPermission('quartz_job_view')")
	@GetMapping
	@LogOperate(value = "任务调度查看")
	public Result<IPage> getPage(PageModel pageModel, JobQueryCriteria jobQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, jobQueryCriteria);
		return Result.buildOkData(jobService.page(pageModel, wrapper));
	}

	/**
	 * POST / : Save a jobVo.
	 *
	 * @param jobVo the HTTP job
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@LogOperate(value = "任务调度编辑")
	@PostMapping
	public Result save(@Valid @RequestBody JobDto jobVo) {
		log.debug("REST request to save JobForm : {}", jobVo);
		jobService.saveOrUpdate(jobVo);
		return Result.buildOk("保存任务调度成功");

	}

	/**
	 * DELETE //:ids : delete the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_del')")
	@LogOperate(value = "任务调度删除")
	@DeleteMapping
	public Result delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete Job: {}", ids);
		jobService.deleteJobByIds(ids);
		return Result.buildOk("删除任务调度成功");
	}

	/**
	 * available //:ids : available the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@LogOperate(value = "任务调度编辑")
	@PutMapping("/update-status")
	public Result updateStatus(@RequestBody Set<String> ids) {
		log.debug("REST request to available Job: {}", ids);
		jobService.updateStatus(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * concurrent //:ids : concurrent the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@LogOperate(value = "任务调度编辑")
	@PutMapping("/run")
	public Result run(@RequestBody Set<String> ids) {
		log.debug("REST request to available Job: {}", ids);
		jobService.runByIds(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * concurrent //:ids : concurrent the "ids" Job.
	 *
	 * @param ids the id of the job to delete
	 * @return the Result with status 200 (OK)
	 */
	@PreAuthorize("@pms.hasPermission('quartz_job_edit')")
	@LogOperate(value = "任务调度编辑")
	@PutMapping("/concurrent")
	public Result concurrent(@RequestBody Set<String> ids) {
		log.debug("REST request to available Job: {}", ids);
		jobService.concurrent(ids);
		return Result.buildOk("操作成功");
	}

	/**
	 * 校验cron表达式是否有效
	 */
	@GetMapping("/check-cron-expression")
	public boolean checkCronExpressionIsValid(JobDto jobDto) {
		return jobService.checkCronExpressionIsValid(jobDto.getCronExpression());
	}

}
