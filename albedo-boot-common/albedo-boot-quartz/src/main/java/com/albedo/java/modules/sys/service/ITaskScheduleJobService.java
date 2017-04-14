package com.albedo.java.modules.sys.service;

import java.util.List;

import com.albedo.java.util.domain.QueryCondition;
import org.quartz.SchedulerException;
import org.springframework.data.domain.Page;

import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.util.domain.PageModel;

public interface ITaskScheduleJobService {

	void init() throws Exception;

	/**
	 * 逻辑删除
	 * 
	 * @param taskTaskScheduleJobId
	 *            主键Id
	 * @return
	 */
	void delete(String taskTaskScheduleJobId, String currentUserId);

	/**
	 * 锁定
	 * 
	 * @param taskTaskScheduleJobId
	 *            主键Id
	 * @return
	 */
	void lockOrUnLock(String taskTaskScheduleJobId, String currentUserId);

	/**
	 * 根据业务编号删除job,删除数据库基本数据
	 * @param sourceId
	 */
	void removeBySourceId(String sourceId);
	
	TaskScheduleJob findOneBySourceId(String soruceId);
	
	TaskScheduleJob findOne(String id);

	Page<TaskScheduleJob> findAll(PageModel<TaskScheduleJob> pm, List<QueryCondition> queryConditions);

	/**
	 * 从数据库中取 区别于getAllJob
	 * 
	 * @return
	 */
	List<TaskScheduleJob> getAllTask();

	/**
	 * 保存任务调度
	 * 
	 * @param taskTaskScheduleJob
	 *            实体任务调度
	 * @return
	 */
	TaskScheduleJob save(TaskScheduleJob taskTaskScheduleJob);
	TaskScheduleJob save(TaskScheduleJob scheduleJob, boolean isAddJob);
	/**
	 * 从数据库中查询job
	 */
	TaskScheduleJob getTaskById(String jobId);

	/**
	 * 更改任务状态
	 * 
	 * @throws SchedulerException
	 */
	void changeStatus(String jobId, String cmd);

	/**
	 * 更改任务 cron表达式
	 * 
	 * @throws SchedulerException
	 */
	void updateCron(String jobId, String cron);

	/**
	 * 添加任务
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void addJob(TaskScheduleJob scheduleJob);

	/**
	 * 获取所有计划中的任务列表
	 * 
	 * @return
	 * @throws SchedulerException
	 */
	List<TaskScheduleJob> getAllJob();

	/**
	 * 所有正在运行的job
	 * 
	 * @return
	 * @throws SchedulerException
	 */
	List<TaskScheduleJob> getRunningJob();
	
	/**
	 * 暂停一个job
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void pauseJob(TaskScheduleJob scheduleJob);

	/**
	 * 恢复一个job
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void resumeJob(TaskScheduleJob scheduleJob);

	/**
	 * 删除一个job
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void deleteJob(TaskScheduleJob scheduleJob);

	/**
	 * 立即执行job
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void runAJobNow(TaskScheduleJob scheduleJob);

	/**
	 * 更新job时间表达式
	 * 
	 * @param scheduleJob
	 * @throws SchedulerException
	 */
	void updateJobCron(TaskScheduleJob scheduleJob);

}