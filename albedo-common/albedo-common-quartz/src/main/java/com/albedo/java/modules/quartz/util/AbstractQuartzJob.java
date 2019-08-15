package com.albedo.java.modules.quartz.util;

import cn.hutool.core.exceptions.ExceptionUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.service.JobLogService;
import org.apache.commons.lang.StringUtils;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

import java.util.Date;

/**
 * 抽象quartz调用
 *
 * @author somewhere
 */
public abstract class AbstractQuartzJob implements org.quartz.Job {
	private static final Logger log = LoggerFactory.getLogger(AbstractQuartzJob.class);

	/**
	 * 线程本地变量
	 */
	private static ThreadLocal<Date> threadLocal = new ThreadLocal<>();

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		Job job = new Job();
		BeanUtils.copyProperties(context.getMergedJobDataMap().get(ScheduleConstants.TASK_PROPERTIES), job);
		try {
			before(context, job);
			if (job != null) {
				doExecute(context, job);
			}
			after(context, job, null);
		} catch (Exception e) {
			log.error("任务执行异常  - ：", e);
			after(context, job, e);
		}
	}

	/**
	 * 执行前
	 *
	 * @param context 工作执行上下文对象
	 * @param job     系统计划任务
	 */
	protected void before(JobExecutionContext context, Job job) {
		threadLocal.set(new Date());
	}

	/**
	 * 执行后
	 *
	 * @param context 工作执行上下文对象
	 * @param job     系统计划任务
	 */
	protected void after(JobExecutionContext context, Job job, Exception e) {
		Date startTime = threadLocal.get();
		threadLocal.remove();

		final JobLog jobLog = new JobLog();
		jobLog.setJobName(job.getName());
		jobLog.setJobGroup(job.getGroup());
		jobLog.setInvokeTarget(job.getInvokeTarget());
		jobLog.setStartTime(startTime);
		jobLog.setEndTime(new Date());
		long runMs = jobLog.getEndTime().getTime() - jobLog.getStartTime().getTime();
		jobLog.setJobMessage(jobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (e != null) {
			jobLog.setStatus(CommonConstants.STR_FAIL);
			String errorMsg = StringUtils.substring(ExceptionUtil.getMessage(e), 0, 2000);
			jobLog.setExceptionInfo(errorMsg);
		} else {
			jobLog.setStatus(CommonConstants.STR_SUCCESS);
		}

		jobLog.setCreateTime(new Date());
		// 写入数据库当中
		SpringContextHolder.getBean(JobLogService.class).save(jobLog);
	}

	/**
	 * 执行方法，由子类重载
	 *
	 * @param context 工作执行上下文对象
	 * @param job     系统计划任务
	 * @throws Exception 执行过程中的异常
	 */
	protected abstract void doExecute(JobExecutionContext context, Job job) throws Exception;
}
