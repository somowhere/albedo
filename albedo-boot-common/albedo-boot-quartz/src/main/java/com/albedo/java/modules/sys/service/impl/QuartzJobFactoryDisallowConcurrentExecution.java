package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.modules.sys.util.TaskUtils;
import org.apache.log4j.Logger;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * @author lijie
 * @Description: 若一个方法一次执行不完下次轮转时则等待改方法执行完后才执行下一次操作
 * @date 2014年4月24日 下午5:05:47
 */
@DisallowConcurrentExecution
public class QuartzJobFactoryDisallowConcurrentExecution implements Job {
    public final Logger log = Logger.getLogger(this.getClass());

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        TaskScheduleJob taskScheduleJob = (TaskScheduleJob) context.getMergedJobDataMap().get("taskScheduleJob");
        TaskUtils.invokMethod(taskScheduleJob);

    }
}