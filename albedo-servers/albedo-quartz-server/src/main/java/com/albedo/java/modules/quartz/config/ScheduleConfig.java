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

package com.albedo.java.modules.quartz.config;

import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.modules.quartz.repository.JobRepository;
import com.albedo.java.modules.tenant.repository.TenantRepository;
import org.quartz.Scheduler;
import org.redisson.api.RedissonClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * 定时任务配置
 *
 * @author somewhere
 */
@Configuration
public class ScheduleConfig {

	@Bean
	public SchedulerFactoryBean schedulerFactoryBean(DataSource dataSource) {
		SchedulerFactoryBean factory = new SchedulerFactoryBean();
		factory.setDataSource(dataSource);

		// quartz参数
		Properties prop = new Properties();
		prop.put("org.quartz.scheduler.instanceName", "AlbedoQuartzScheduler");
		prop.put("org.quartz.scheduler.instanceId", "AUTO");
		// 线程池配置
		prop.put("org.quartz.threadPool.class", "org.quartz.simpl.SimpleThreadPool");
		prop.put("org.quartz.threadPool.threadCount", "20");
		prop.put("org.quartz.threadPool.threadPriority", "5");
		// JobStore配置
		prop.put("org.quartz.jobStore.class", "org.springframework.scheduling.quartz.LocalDataSourceJobStore");
		// 集群配置
		prop.put("org.quartz.jobStore.isClustered", "true");
		prop.put("org.quartz.jobStore.clusterCheckinInterval", "15000");
		prop.put("org.quartz.jobStore.maxMisfiresToHandleAtATime", "1");
		prop.put("org.quartz.jobStore.txIsolationLevelSerializable", "true");

		// sqlserver 启用
		// prop.put("org.quartz.jobStore.selectWithLockSQL", "SELECT * FROM {0}LOCKS
		// UPDLOCK WHERE LOCK_NAME = ?");
		prop.put("org.quartz.jobStore.misfireThreshold", "12000");
		prop.put("org.quartz.jobStore.tablePrefix", "QRTZ_");
		factory.setQuartzProperties(prop);

		factory.setSchedulerName("AlbedoQuartzScheduler");
		// 延时启动
		factory.setStartupDelay(10);
		factory.setApplicationContextSchedulerContextKey("applicationContextKey");
		// 可选，QuartzScheduler
		// 启动时更新己存在的Job，这样就不用每次修改targetObject后删除qrtz_job_details表对应记录了
		factory.setOverwriteExistingJobs(true);
		// 设置自动启动，默认为true
		factory.setAutoStartup(true);

		return factory;
	}

	/**
	 * 初始化监听器
	 *
	 * @param connectionFactory
	 * @param listenerAdapter
	 * @return
	 */
	@Bean
	RedisMessageListenerContainer container(RedisConnectionFactory connectionFactory,
											MessageListenerAdapter listenerAdapter) {
		RedisMessageListenerContainer container = new RedisMessageListenerContainer();
		container.setConnectionFactory(connectionFactory);
		// new PatternTopic("这里是监听的通道的名字") 通道要和发布者发布消息的通道一致
		container.addMessageListener(listenerAdapter,
			new PatternTopic(ScheduleConstants.REDIS_SCHEDULE_DEFAULT_CHANNEL));
		return container;
	}

	/**
	 * 绑定消息监听者和接收监听的方法
	 *
	 * @param scheduleReceiver
	 * @return
	 */
	@Bean
	MessageListenerAdapter listenerAdapter(ScheduleReceiver scheduleReceiver) {
		// redisReceiver 消息接收者
		// receiveMessage 消息接收后的方法
		return new MessageListenerAdapter(scheduleReceiver);
	}

	/**
	 * 注册订阅者
	 *
	 * @return
	 */
	@Bean
	ScheduleReceiver scheduleReceiver(Scheduler scheduler, JobRepository jobRepository, TenantRepository tenantRepository, RedissonClient redissonClient, RedisSerializer serializerr) {
		return new ScheduleReceiver(scheduler, jobRepository, tenantRepository, redissonClient, serializerr);
	}

}
