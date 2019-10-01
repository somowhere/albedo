/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.service.impl;

import cn.hutool.core.convert.Convert;
import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.vo.JobDataVo;
import com.albedo.java.modules.quartz.repository.JobRepository;
import com.albedo.java.modules.quartz.service.JobService;
import com.albedo.java.modules.quartz.util.CronUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
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
@BaseInit(method = "refresh")
@Transactional(rollbackFor = Exception.class)
public class JobServiceImpl extends DataVoServiceImpl<JobRepository, Job, String, JobDataVo> implements JobService {

	/**
	 * 项目启动时，初始化定时器
	 * 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
	 */
	public void refresh() {
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
	public int pauseJob(Job job) {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setAvailable(ScheduleConstants.Status.PAUSE.getValue());
		int rows = repository.updateById(job);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
//			scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
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
	public int resumeJob(Job job) {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		job.setAvailable(ScheduleConstants.Status.NORMAL.getValue());
		int rows = repository.updateById(job);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
//			scheduler.resumeJob(ScheduleUtils.getJobKey(jobId, jobGroup));
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
	public int deleteJob(Job job) {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
		int rows = repository.deleteById(jobId);
		if (rows > 0) {
			RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
//			scheduler.deleteJob(ScheduleUtils.getJobKey(jobId, jobGroup));
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
	public void deleteJobByIds(String ids) {
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
	public int changeStatus(Job job) {
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
	public void run(Job job) {
		String jobId = job.getId();
		String jobGroup = job.getGroup();
//		scheduler.triggerJob(ScheduleUtils.getJobKey(jobId, jobGroup), dataMap);
		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobId, jobGroup));
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
					RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataAdd(Json.toJsonString(job)));
//					ScheduleUtils.createScheduleJob(scheduler, job);
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
	public void updateSchedulerJob(Job job, String jobGroup) {
//		String jobId = job.getId();
//		// 判断是否存在
//		JobKey jobKey = ScheduleUtils.getJobKey(jobId, jobGroup);
//		if (scheduler.checkExists(jobKey)) {
//			// 防止创建时存在数据问题 先移除，然后在执行创建操作
//			scheduler.deleteJob(jobKey);
//		}
//		ScheduleUtils.createScheduleJob(scheduler, job);

		RedisUtil.sendScheduleChannelMessage(ScheduleVo.createDataUpdate(Json.toJsonString(job), jobGroup));
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
				changeStatus(job);
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
			run(job);
		});
	}
}
