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

package com.albedo.java.modules.quartz.util;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.domain.enums.JobLogStatus;
import com.albedo.java.modules.quartz.domain.enums.JobMisfirePolicy;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
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
		if (log.isDebugEnabled()) {
			log.debug("start Task===>" + job.getName() + job.getGroup());
		}
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
		ContextUtil.setTenant(job.getTenantCode());
		final JobLog jobLog = new JobLog();
		jobLog.setJobName(job.getName());
		jobLog.setJobGroup(job.getGroup());
		jobLog.setCronExpression(job.getCronExpression());
		jobLog.setInvokeTarget(job.getInvokeTarget());
		jobLog.setStartTime(startTime);
		jobLog.setEndTime(new Date());
		long runMs = jobLog.getEndTime().getTime() - jobLog.getStartTime().getTime();
		jobLog.setJobMessage(jobLog.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (log.isDebugEnabled()) {
			log.debug("end Task===>" + jobLog.getJobMessage());
		}
		if (e != null) {
			jobLog.setStatus(JobLogStatus.FAILURE);
			jobLog.setExceptionInfo(ExceptionUtil.stacktraceToString(e));
			// 任务如果失败了则暂停
			if (JobMisfirePolicy.EXECUTE_STOP.equals(job.getMisfirePolicy())) {
				// 更新状态
				job.setStatus(JobStatus.PAUSE);
				RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(job.getId(), job.getGroup()));
			}
			if (job.getEmail() != null) {
				EmailService emailService = SpringContextHolder.getBean(EmailService.class);
				// 邮箱报警
				EmailVo emailVo = taskAlarm(job, jobLog.getExceptionInfo());
				emailService.send(emailVo, emailService.find());
			}
		} else {
			jobLog.setStatus(JobLogStatus.SUCCESS);
		}

		jobLog.setCreatedDate(new Date());
		// 写入数据库当中
		SpringContextHolder.getBean(JobLogService.class).saveOrUpdate(jobLog);
		ContextUtil.setTenant(null);
	}

	private EmailVo taskAlarm(Job quartzJob, String msg) {
		EmailVo emailVo = new EmailVo();
		emailVo.setSubject("定时任务【" + quartzJob.getName() + "】执行失败，请尽快处理！");
		Map<String, Object> data = new HashMap<>(4);
		data.put("task", quartzJob);
		data.put("msg", msg);
		TemplateEngine engine = TemplateUtil
			.createEngine(new TemplateConfig("templates/codet/templates", TemplateConfig.ResourceMode.CLASSPATH));
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
