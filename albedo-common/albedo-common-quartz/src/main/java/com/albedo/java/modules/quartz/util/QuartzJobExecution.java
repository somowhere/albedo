package com.albedo.java.modules.quartz.util;

import com.albedo.java.modules.quartz.domain.Job;
import org.quartz.JobExecutionContext;

/**
 * 定时任务处理（允许并发执行）
 *
 * @author somewhere
 */
public class QuartzJobExecution extends AbstractQuartzJob {
	@Override
	protected void doExecute(JobExecutionContext context, Job job) throws Exception {
		JobInvokeUtil.invokeMethod(job);
	}
}
