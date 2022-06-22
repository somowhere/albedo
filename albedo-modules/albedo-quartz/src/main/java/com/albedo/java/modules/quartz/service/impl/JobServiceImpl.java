/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.core.domain.vo.ScheduleVo;
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.JobDo;
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
public class JobServiceImpl extends DataServiceImpl<JobRepository, JobDo, JobDto> implements JobService {

	/**
	 * 暂停任务
	 *
	 * @param jobDo 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int pauseJob(JobDo jobDo) {
		Long jobId = jobDo.getId();
		String jobGroup = jobDo.getGroup();
		jobDo.setStatus(JobStatus.PAUSE);
		int rows = repository.updateById(jobDo);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 恢复任务
	 *
	 * @param jobDo 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int resumeJob(JobDo jobDo) {
		Long jobId = jobDo.getId();
		String jobGroup = jobDo.getGroup();
		jobDo.setStatus(JobStatus.RUNNING);
		int rows = repository.updateById(jobDo);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createResume(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 删除任务后，所对应的trigger也将被删除
	 *
	 * @param jobDo 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteJob(JobDo jobDo) {
		Long jobId = jobDo.getId();
		String jobGroup = jobDo.getGroup();
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
			JobDo jobDo = repository.selectById(jobId);
			deleteJob(jobDo);
		}
	}

	/**
	 * 任务调度状态修改
	 *
	 * @param jobDo 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int changeStatus(JobDo jobDo) {
		int rows = 0;
		if (JobStatus.PAUSE.eq(jobDo.getStatus())) {
			rows = resumeJob(jobDo);
		} else if (JobStatus.RUNNING.eq(jobDo.getStatus())) {
			rows = pauseJob(jobDo);
		}
		return rows;
	}

	/**
	 * 立即运行任务
	 *
	 * @param jobDo 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void run(JobDo jobDo) {
		Long jobId = jobDo.getId();
		String jobGroup = jobDo.getGroup();
		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createRun(jobId, jobGroup));
	}

	/**
	 * 新增任务
	 *
	 * @param jobDo 调度信息 调度信息
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean saveOrUpdate(JobDo jobDo) {
		ArgumentAssert.isTrue(checkCronExpressionIsValid(jobDo.getCronExpression()), "cronExpression 不合法");
		try {
			if (jobDo.getId() == null) {
				jobDo.setStatus(JobStatus.PAUSE);
				int rows = repository.insert(jobDo);
				if (rows > 0) {
					RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataAdd(JSONUtil.toJsonStr(jobDo)));
				}
			} else {
				JobDo temp = repository.selectById(jobDo.getId());
				int rows = repository.updateById(jobDo);
				if (rows > 0) {
					updateSchedulerJob(jobDo, temp.getGroup());
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
	 * @param jobDo       任务对象
	 * @param jobOldGroup 任务组名
	 */
	public void updateSchedulerJob(JobDo jobDo, String jobOldGroup) {
		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataUpdate(JSONUtil.toJsonStr(jobDo), jobOldGroup));
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
			JobDo jobDo = repository.selectById(id);
			changeStatus(jobDo);
		});
	}

	@Override
	public void concurrent(Set<String> ids) {
		ids.forEach(id -> {
			JobDo jobDo = repository.selectById(id);
			jobDo.setConcurrent(JobConcurrent.YES.eq(jobDo.getConcurrent()) ? JobConcurrent.NO
				: JobConcurrent.YES);
			repository.updateById(jobDo);
		});
	}

	@Override
	public void runByIds(Set<String> ids) {

		ids.forEach(id -> {
			JobDo jobDo = repository.selectById(id);
			if (jobDo != null) {
				run(jobDo);
			}
		});
	}

	@Override
	public void runBySubIds(Set<String> ids) {

		ids.forEach(id -> {
			JobDo jobDo = repository.selectById(id);
			if (jobDo != null) {
				run(jobDo);
			}
		});
	}

}
