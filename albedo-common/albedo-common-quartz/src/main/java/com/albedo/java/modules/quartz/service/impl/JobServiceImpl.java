/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.modules.quartz.service.impl;

import cn.hutool.json.JSONUtil;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.dto.JobDto;
import com.albedo.java.modules.quartz.domain.enums.JobConcurrent;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
import com.albedo.java.modules.quartz.repository.JobRepository;
import com.albedo.java.modules.quartz.service.JobService;
import com.albedo.java.modules.quartz.util.CronUtils;
import com.albedo.java.plugins.database.mybatis.service.impl.DataServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

/**
 * 任务调度ServiceImpl 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class JobServiceImpl extends DataServiceImpl<JobRepository, Job, JobDto> implements JobService {

	/**
	 * 暂停任务
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int pauseJob(Job job) {
		Long jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setStatus(JobStatus.PAUSE);
		int rows = repository.updateById(job);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 恢复任务
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int resumeJob(Job job) {
		Long jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setStatus(JobStatus.RUNNING);
		int rows = repository.updateById(job);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createResume(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 删除任务后，所对应的trigger也将被删除
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteJob(Job job) {
		Long jobId = job.getId();
		String jobGroup = job.getGroup();
		int rows = repository.deleteById(jobId);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDelete(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 批量删除调度信息
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteJobByIds(Set<String> ids) {
		for (String jobId : ids) {
			Job job = repository.selectById(jobId);
			deleteJob(job);
		}
	}

	/**
	 * 任务调度状态修改
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int changeStatus(Job job) {
		int rows = 0;
		if (JobStatus.PAUSE.eq(job.getStatus())) {
			rows = resumeJob(job);
		} else if (JobStatus.RUNNING.eq(job.getStatus())) {
			rows = pauseJob(job);
		}
		return rows;
	}

	/**
	 * 立即运行任务
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void run(Job job) {
		Long jobId = job.getId();
		String jobGroup = job.getGroup();
		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createRun(jobId, jobGroup));
	}

	/**
	 * 新增任务
	 *
	 * @param job 调度信息 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveOrUpdate(Job job) {
		ArgumentAssert.isTrue(checkCronExpressionIsValid(job.getCronExpression()), "cronExpression 不合法");
		try {
			if (job.getId() == null) {
				job.setStatus(JobStatus.PAUSE);
				int rows = repository.insert(job);
				if (rows > 0) {
					RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataAdd(JSONUtil.toJsonStr(job)));
				}
			} else {
				Job temp = repository.selectById(job.getId());
				int rows = repository.updateById(job);
				if (rows > 0) {
					updateSchedulerJob(job, temp.getGroup());
				}
			}
			return true;
		} catch (Exception e) {
			throw new BizException(e);
		}
	}

	/**
	 * 更新任务
	 *
	 * @param job         任务对象
	 * @param jobOldGroup 任务组名
	 */
	public void updateSchedulerJob(Job job, String jobOldGroup) {
		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataUpdate(JSONUtil.toJsonStr(job), jobOldGroup));
	}

	/**
	 * 校验cron表达式是否有效
	 *
	 * @param cronExpression 表达式
	 * @return 结果
	 */
	@Override
	public boolean checkCronExpressionIsValid(String cronExpression) {
		return CronUtils.isValid(cronExpression);
	}

	@Override
	public void updateStatus(Set<String> ids) {
		ids.forEach(id -> {
			Job job = repository.selectById(id);
			changeStatus(job);
		});
	}

	@Override
	public void concurrent(Set<String> ids) {
		ids.forEach(id -> {
			Job job = repository.selectById(id);
			job.setConcurrent(JobConcurrent.YES.eq(job.getConcurrent()) ? JobConcurrent.NO
				: JobConcurrent.YES);
			repository.updateById(job);
		});
	}

	@Override
	public void runByIds(Set<String> ids) {

		ids.forEach(id -> {
			Job job = repository.selectById(id);
			if (job != null) {
				run(job);
			}
		});
	}

	@Override
	public void runBySubIds(Set<String> ids) {

		ids.forEach(id -> {
			Job job = repository.selectById(id);
			if (job != null) {
				run(job);
			}
		});
	}

}
