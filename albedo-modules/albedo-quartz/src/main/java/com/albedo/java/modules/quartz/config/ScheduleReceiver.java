package com.albedo.java.modules.quartz.config;

import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.exception.TaskException;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.repository.JobRepository;
import com.albedo.java.modules.quartz.util.ScheduleUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.redisson.api.RedissonClient;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.util.Assert;

import java.util.List;
import java.util.concurrent.locks.Lock;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:11
 */
@Slf4j
@AllArgsConstructor
@BaseInit(method = "refresh")
public class ScheduleReceiver implements MessageListener {
	public final static String DEFAULT_QUARTZ_REGISTRY_KEY = "albedo-quartz-message-lock";
	private final Scheduler scheduler;
	private final JobRepository jobRepository;
	private final RedissonClient redissonClient;

	/**
	 * 项目启动时，初始化定时器
	 * 主要是防止手动修改数据库导致未同步到定时任务处理（注：不能手动修改数据库ID和任务组名，否则会导致脏数据）
	 */
	public void refresh() throws TaskException, SchedulerException {
		List<Job> jobList = jobRepository.selectList(null);
		for (Job job : jobList) {
			updateSchedulerJob(job, job.getGroup());
		}
	}

	/**
	 * 更新任务
	 *
	 * @param job         任务对象
	 * @param jobOldGroup 任务组名
	 */
	public void updateSchedulerJob(Job job, String jobOldGroup) throws SchedulerException, TaskException {
		Integer jobId = job.getId();
		// 判断是否存在
		JobKey jobKey = ScheduleUtils.getJobKey(jobId, jobOldGroup);
		if (scheduler.checkExists(jobKey)) {
			// 防止创建时存在数据问题 先移除，然后在执行创建操作
			scheduler.deleteJob(jobKey);
		}
		ScheduleUtils.createScheduleJob(scheduler, job);
	}

	/**
	 * 收到通道的消息之后执行的方法
	 *
	 * @param message
	 */
	@Override
	public void onMessage(Message message, byte[] pattern) {
		if (log.isInfoEnabled()) {
			log.info("receiveMessage===>" + message);
		}

		Lock lock = redissonClient.getLock(DEFAULT_QUARTZ_REGISTRY_KEY);
		try{
			lock.lock();
			RedisSerializer serializer=new GenericJackson2JsonRedisSerializer();
			ScheduleVo scheduleVo = (ScheduleVo) serializer.deserialize(message.getBody());
			Assert.isTrue(scheduleVo != null, "scheduleVo cannot be null");
			Assert.isTrue(scheduleVo.getMessageType() != null, "scheduleVo cannot be null");
			Integer jobId = scheduleVo.getJobId();
			String jobGroup = scheduleVo.getJobGroup();
			switch (scheduleVo.getMessageType()) {
				case ADD:
					ScheduleUtils.createScheduleJob(scheduler, Json.parseObject(scheduleVo.getData(), Job.class));
					break;
				case UPDATE:
					updateSchedulerJob(Json.parseObject(scheduleVo.getData(), Job.class), jobGroup);
					break;
				case PAUSE:
					scheduler.pauseJob(ScheduleUtils.getJobKey(jobId, jobGroup));
					break;
				case RESUME:
					scheduler.resumeJob(ScheduleUtils.getJobKey(jobId, jobGroup));
					break;
				case DELETE:
					scheduler.deleteJob(ScheduleUtils.getJobKey(jobId, jobGroup));
					break;
				case RUN:
					scheduler.triggerJob(ScheduleUtils.getJobKey(jobId, jobGroup));
					break;
				default:
					log.warn("unkown message type :" + message);
					break;
			}
		} catch (Exception e) {
			log.warn("error message type {}", e);
		} finally {
			lock.unlock();
		}
	}
}
