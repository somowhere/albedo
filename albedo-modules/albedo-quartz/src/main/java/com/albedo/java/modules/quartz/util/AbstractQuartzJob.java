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

package com.albedo.java.modules.quartz.util;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.extra.template.Template;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.TemplateUtil;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.domain.vo.ScheduleVo;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.quartz.domain.JobDo;
import com.albedo.java.modules.quartz.domain.JobLogDo;
import com.albedo.java.modules.quartz.domain.enums.JobLogStatus;
import com.albedo.java.modules.quartz.domain.enums.JobMisfirePolicy;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.albedo.java.modules.tool.domain.vo.EmailVo;
import com.albedo.java.modules.tool.feign.RemoteEmailService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	private static ThreadLocal<LocalDateTime> threadLocal = new ThreadLocal<>();

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		JobDo jobDo = new JobDo();
		BeanUtils.copyProperties(context.getMergedJobDataMap().get(ScheduleConstants.TASK_PROPERTIES), jobDo);
		try {
			before(context, jobDo);
			doExecute(context, jobDo);
			after(context, jobDo, null);
		} catch (Exception e) {
			log.error("任务执行异常  - ：", e);
			after(context, jobDo, e);
		}
	}

	/**
	 * 执行前
	 *
	 * @param context 工作执行上下文对象
	 * @param jobDo   系统计划任务
	 */
	protected void before(JobExecutionContext context, JobDo jobDo) {
		if (log.isDebugEnabled()) {
			log.debug("start Task===> {} {}", jobDo.getName(), jobDo.getGroup());
		}
		threadLocal.set(LocalDateTime.now());
	}

	/**
	 * 执行后
	 *
	 * @param context 工作执行上下文对象
	 * @param jobDo   系统计划任务
	 */
	protected void after(JobExecutionContext context, JobDo jobDo, Exception e) {
		LocalDateTime startTime = threadLocal.get();
		threadLocal.remove();
		ContextUtil.setTenant(jobDo.getTenantCode());
		final JobLogDo jobLogDo = new JobLogDo();
		jobLogDo.setJobName(jobDo.getName());
		jobLogDo.setJobGroup(jobDo.getGroup());
		jobLogDo.setCronExpression(jobDo.getCronExpression());
		jobLogDo.setInvokeTarget(jobDo.getInvokeTarget());
		jobLogDo.setStartTime(startTime);
		jobLogDo.setEndTime(LocalDateTime.now());
		int runMs = jobLogDo.getEndTime().getNano() - jobLogDo.getStartTime().getNano();
		jobLogDo.setJobMessage(jobLogDo.getJobName() + " 总共耗时：" + runMs + "毫秒");
		if (log.isDebugEnabled()) {
			log.debug("end Task===> {}", jobLogDo.getJobMessage());
		}
		if (e != null) {
			jobLogDo.setStatus(JobLogStatus.FAILURE);
			jobLogDo.setExceptionInfo(ExceptionUtil.stacktraceToString(e));
			// 任务如果失败了则暂停
			if (JobMisfirePolicy.EXECUTE_STOP.equals(jobDo.getMisfirePolicy())) {
				// 更新状态
				jobDo.setStatus(JobStatus.PAUSE);
				RedisUtil.sendScheduleChannelMessage(ScheduleVo.createPause(jobDo.getId(), jobDo.getGroup()));
			}
			if (jobDo.getEmail() != null) {
				RemoteEmailService emailService = SpringContextHolder.getBean(RemoteEmailService.class);
				// 邮箱报警
				EmailVo emailVo = taskAlarm(jobDo, jobLogDo.getExceptionInfo());
				emailService.send(emailVo);
			}
		} else {
			jobLogDo.setStatus(JobLogStatus.SUCCESS);
		}

		jobLogDo.setCreatedDate(LocalDateTime.now());
		// 写入数据库当中
		SpringContextHolder.getBean(JobLogService.class).saveOrUpdate(jobLogDo);
		ContextUtil.setTenant(null);
	}

	private EmailVo taskAlarm(JobDo quartzJobDo, String msg) {
		EmailVo emailVo = new EmailVo();
		emailVo.setSubject("定时任务【" + quartzJobDo.getName() + "】执行失败，请尽快处理！");
		Map<String, Object> data = new HashMap<>(4);
		data.put("task", quartzJobDo);
		data.put("msg", msg);
		TemplateEngine engine = TemplateUtil
			.createEngine(new TemplateConfig("templates/codet/templates", TemplateConfig.ResourceMode.CLASSPATH));
		Template template = engine.getTemplate("email/taskAlarm.ftl");
		emailVo.setContent(template.render(data));
		List<String> emails = Arrays.asList(quartzJobDo.getEmail().split("[,，]"));
		emailVo.setTos(emails);
		return emailVo;
	}

	/**
	 * 执行方法，由子类重载
	 *
	 * @param context 工作执行上下文对象
	 * @param jobDo   系统计划任务
	 * @throws Exception 执行过程中的异常
	 */
	protected abstract void doExecute(JobExecutionContext context, JobDo jobDo)
		throws Exception;

}
