/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.exception.TaskException;
import com.albedo.java.modules.quartz.domain.JobDo;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
import org.quartz.*;

/**
 * 定时任务工具类
 *
 * @author somewhere
 */
public class ScheduleUtils {

	/**
	 * 得到quartz任务类
	 *
	 * @param jobDo 执行计划
	 * @return 具体执行任务类
	 */
	private static Class<? extends org.quartz.Job> getQuartzJobClass(JobDo jobDo) {
		boolean isConcurrent = "0".equals(jobDo.getConcurrent());
		return isConcurrent ? QuartzJobExecution.class : QuartzDisallowConcurrentExecution.class;
	}

	/**
	 * 构建任务触发对象
	 */
	public static TriggerKey getTriggerKey(Long jobId, String jobGroup) {
		return TriggerKey.triggerKey(ScheduleConstants.TASK_CLASS_NAME + jobId, jobGroup + ContextUtil.getTenant());
	}

	/**
	 * 构建任务键对象
	 */
	public static JobKey getJobKey(Long jobId, String jobGroup) {
		return JobKey.jobKey(ScheduleConstants.TASK_CLASS_NAME + jobId, jobGroup + ContextUtil.getTenant());
	}

	/**
	 * 创建定时任务
	 */
	public static void createScheduleJob(Scheduler scheduler, JobDo jobDo) throws SchedulerException, TaskException {
		Class<? extends org.quartz.Job> jobClass = getQuartzJobClass(jobDo);
		// 构建job信息
		Long jobId = jobDo.getId();
		String jobGroup = jobDo.getGroup();
		JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(getJobKey(jobId, jobGroup)).build();

		// 表达式调度构建器
		CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(jobDo.getCronExpression());
		cronScheduleBuilder = handleCronScheduleMisfirePolicy(jobDo, cronScheduleBuilder);

		// 按新的cronExpression表达式构建一个新的trigger
		CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(getTriggerKey(jobId, jobGroup))
			.withSchedule(cronScheduleBuilder).build();

		// 放入参数，运行时的方法可以获取
		jobDetail.getJobDataMap().put(ScheduleConstants.TASK_PROPERTIES, jobDo);

		// 判断是否存在
		if (scheduler.checkExists(getJobKey(jobId, jobGroup))) {
			// 防止创建时存在数据问题 先移除，然后在执行创建操作
			scheduler.deleteJob(getJobKey(jobId, jobGroup));
		}

		scheduler.scheduleJob(jobDetail, trigger);

		// 暂停任务
		if (JobStatus.PAUSE.equals(jobDo.getStatus())) {
			scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
		}
	}

	/**
	 * 设置定时任务策略
	 */
	public static CronScheduleBuilder handleCronScheduleMisfirePolicy(JobDo jobDo, CronScheduleBuilder cb)
		throws TaskException {
		switch (jobDo.getMisfirePolicy()) {
			case EXECUTE_DEFAULT:
				return cb;
			case IGNORE_MISFIRES:
				return cb.withMisfireHandlingInstructionIgnoreMisfires();
			case FIRE_PROCEED:
				return cb.withMisfireHandlingInstructionFireAndProceed();
			case EXECUTE_STOP:
				return cb.withMisfireHandlingInstructionDoNothing();
			default:
				throw new TaskException(
					"The task misfire policy '" + jobDo.getMisfirePolicy() + "' cannot be used in cron schedule tasks",
					TaskException.Code.CONFIG_ERROR);
		}
	}

}
