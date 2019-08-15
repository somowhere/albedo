/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.service.impl;

import cn.hutool.core.convert.Convert;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.exception.TaskException;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.vo.JobDataVo;
import com.albedo.java.modules.quartz.repository.JobRepository;
import com.albedo.java.modules.quartz.service.JobService;
import com.albedo.java.modules.quartz.util.CronUtils;
import com.albedo.java.modules.quartz.util.ScheduleUtils;
import org.quartz.JobDataMap;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * 任务调度ServiceImpl 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class JobServiceImpl extends DataVoServiceImpl<JobRepository, Job, String, JobDataVo> implements JobService {


	@Autowired
	private Scheduler scheduler;

	/**
	 * 项目启动时，初始化定时器
	 * 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
	 */
	@PostConstruct
	public void init() throws SchedulerException, TaskException {
		List<Job> jobList = repository.selectList(null);
		for (Job job : jobList) {
			updateSchedulerJob(job, job.getGroup());
		}
	}


	/**
	 * 暂停任务
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional
	public int pauseJob(Job job) throws SchedulerException {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setAvailable(ScheduleConstants.Status.PAUSE.getValue());
		int rows = repository.updateById(job);
		if (rows > 0) {
			scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 恢复任务
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional
	public int resumeJob(Job job) throws SchedulerException {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setAvailable(ScheduleConstants.Status.NORMAL.getValue());
		int rows = repository.updateById(job);
		if (rows > 0) {
			scheduler.resumeJob(ScheduleUtils.getJobKey(jobId, jobGroup));
		}
		return rows;
	}

	/**
	 * 删除任务后，所对应的trigger也将被删除
	 *
	 * @param job 调度信息
	 */
	@Override
	@Transactional
	public int deleteJob(Job job) throws SchedulerException {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		int rows = repository.deleteById(jobId);
		if (rows > 0) {
			scheduler.deleteJob(ScheduleUtils.getJobKey(jobId, jobGroup));
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
	@Transactional
	public void deleteJobByIds(String ids) throws SchedulerException {
		Long[] jobIds = Convert.toLongArray(ids);
		for (Long jobId : jobIds) {
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
	@Transactional
	public int changeStatus(Job job) throws SchedulerException {
		int rows = 0;
		String status = job.getAvailable();
		if (ScheduleConstants.Status.PAUSE.getValue().equals(status)) {
			rows = resumeJob(job);
		} else if (ScheduleConstants.Status.NORMAL.getValue().equals(status)) {
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
	@Transactional
	public void run(Job job) throws SchedulerException {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		Job properties = repository.selectById(job.getId());
		// 参数
		JobDataMap dataMap = new JobDataMap();
		dataMap.put(ScheduleConstants.TASK_PROPERTIES, properties);
		scheduler.triggerJob(ScheduleUtils.getJobKey(jobId, jobGroup), dataMap);
	}

	/**
	 * 新增任务
	 *
	 * @param job 调度信息 调度信息
	 */
	@Override
	@Transactional
	public boolean saveOrUpdate(Job job) {

		try {
			if (StringUtil.isEmpty(job.getId())) {
				job.setAvailable(ScheduleConstants.Status.PAUSE.getValue());
				int rows = repository.insert(job);
				if (rows > 0) {
					ScheduleUtils.createScheduleJob(scheduler, job);

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
			throw new RuntimeMsgException(e);
		}
	}

	/**
	 * 更新任务
	 *
	 * @param job      任务对象
	 * @param jobGroup 任务组名
	 */
	public void updateSchedulerJob(Job job, String jobGroup) throws SchedulerException, TaskException {
		String jobId = job.getId();
		// 判断是否存在
		JobKey jobKey = ScheduleUtils.getJobKey(jobId, jobGroup);
		if (scheduler.checkExists(jobKey)) {
			// 防止创建时存在数据问题 先移除，然后在执行创建操作
			scheduler.deleteJob(jobKey);
		}
		ScheduleUtils.createScheduleJob(scheduler, job);
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
	public void available(List<String> idList) {
		idList.forEach(id -> {
			Job job = baseMapper.selectById(id);
			try {
				changeStatus(job);
			} catch (SchedulerException e) {
				throw new RuntimeMsgException(e);
			}
		});
	}

	@Override
	public void concurrent(List<String> idList) {
		idList.forEach(id -> {
			Job job = baseMapper.selectById(id);
			job.setConcurrent(CommonConstants.STR_YES.equals(job.getAvailable()) ?
				CommonConstants.STR_NO : CommonConstants.STR_YES);
			baseMapper.updateById(job);
		});
	}

	@Override
	public void runByIds(List<String> idList) {

		idList.forEach(id -> {
			Job job = baseMapper.selectById(id);
			try {
				run(job);
			} catch (SchedulerException e) {
				throw new RuntimeMsgException(e);
			}
		});
	}
}
