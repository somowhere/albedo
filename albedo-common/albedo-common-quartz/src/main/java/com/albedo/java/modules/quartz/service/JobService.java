/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.service;

import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.vo.JobDataVo;
import com.albedo.java.modules.quartz.repository.JobRepository;
import org.quartz.SchedulerException;

import java.util.List;

/**
 * 任务调度Service 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
public interface JobService extends DataVoService<JobRepository, Job, String, JobDataVo> {


	/**
	 * 暂停任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int pauseJob(Job job) throws SchedulerException;

	/**
	 * 恢复任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int resumeJob(Job job) throws SchedulerException;

	/**
	 * 删除任务后，所对应的trigger也将被删除
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int deleteJob(Job job) throws SchedulerException;

	/**
	 * 批量删除调度信息
	 *
	 * @param ids 需要删除的数据ID
	 * @return 结果
	 */
	void deleteJobByIds(String ids) throws SchedulerException;

	/**
	 * 任务调度状态修改
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	int changeStatus(Job job) throws SchedulerException;

	/**
	 * 立即运行任务
	 *
	 * @param job 调度信息
	 * @return 结果
	 */
	void run(Job job) throws SchedulerException;


	/**
	 * 校验cron表达式是否有效
	 *
	 * @param cronExpression 表达式
	 * @return 结果
	 */
	boolean checkCronExpressionIsValid(String cronExpression);

	void available(List<String> idList);

	void concurrent(List<String> idList);

	void runByIds(List<String> idList);
}
