package com.albedo.java.modules.quartz.util;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.albedo.java.modules.tool.domain.vo.EmailVo;
import com.albedo.java.modules.tool.service.EmailService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

import java.util.*;

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
		jobLog.setCronExpression(job.getCronExpression());
		jobLog.setInvokeTarget(job.getInvokeTarget());
		jobLog.setStartTime(startTime);
		jobLog.setEndTime(new Date());
		long runMs = jobLog.getEndTime().getTime() - jobLog.getStartTime().getTime();
		jobLog.setJobMessage(jobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (e != null) {
			jobLog.setStatus(CommonConstants.STR_FAIL);
			jobLog.setExceptionInfo(ExceptionUtil.stacktraceToString(e));
			// 任务如果失败了则暂停
			if (ScheduleConstants.MISFIRE_DO_NOTHING.equals(job.getMisfirePolicy())) {
				//更新状态
				job.setStatus(ScheduleConstants.Status.PAUSE.getValue());
				RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(job.getId(), job.getGroup()));
			}
			if (job.getEmail() != null) {
				EmailService emailService = SpringContextHolder.getBean(EmailService.class);
				// 邮箱报警
				EmailVo emailVo = taskAlarm(job, jobLog.getExceptionInfo());
				emailService.send(emailVo, emailService.find());
			}
		} else {
			jobLog.setStatus(CommonConstants.STR_SUCCESS);
		}

		jobLog.setCreatedDate(new Date());
		// 写入数据库当中
		SpringContextHolder.getBean(JobLogService.class).saveOrUpdate(jobLog);
	}


	private EmailVo taskAlarm(Job quartzJob, String msg) {
		EmailVo emailVo = new EmailVo();
		emailVo.setSubject("定时任务【" + quartzJob.getName() + "】执行失败，请尽快处理！");
		Map<String, Object> data = new HashMap<>(4);
		data.put("task", quartzJob);
		data.put("msg", msg);
		TemplateEngine engine = TemplateUtil.createEngine(new TemplateConfig("templates", TemplateConfig.ResourceMode.CLASSPATH));
		Template template = engine.getTemplate("email/taskAlarm.ftl");
		emailVo.setContent(template.render(data));
		List<String> emails = Arrays.asList(quartzJob.getEmail().split("[,，]"));
		emailVo.setTos(emails);
		return emailVo;
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
