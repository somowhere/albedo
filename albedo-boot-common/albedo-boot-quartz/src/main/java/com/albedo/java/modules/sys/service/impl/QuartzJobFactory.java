package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.modules.sys.util.TaskUtils;
import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * @author lijie
 * @Description: 计划任务执行处 无状态
 * @date 2014年4月24日 下午5:05:47
 */
public class QuartzJobFactory implements Job {
    public final Logger log = Logger.getLogger(this.getClass());

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        TaskScheduleJob taskScheduleJob = (TaskScheduleJob) context.getMergedJobDataMap().get("taskScheduleJob");
        TaskUtils.invokMethod(taskScheduleJob);
    }
}