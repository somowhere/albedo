/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.vo.JobDataVo;
import com.albedo.java.modules.quartz.service.JobService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the JobResource REST controller.
 *
 * @see JobResource
 */
@SpringBootTest(classes = com.albedo.java.modules.AlbedoAdminApplication.class)
@Slf4j
public class JobResourceIntTest {

	/**
	 * DEFAULT_NAME name  :  任务名称
	 */
	private static final String DEFAULT_NAME = "A";
	/**
	 * UPDATED_NAME name  :  任务名称
	 */
	private static final String UPDATED_NAME = "B";
	/**
	 * DEFAULT_GROUP group  :  任务组名
	 */
	private static final String DEFAULT_GROUP = "A";
	/**
	 * UPDATED_GROUP group  :  任务组名
	 */
	private static final String UPDATED_GROUP = "B";
	/**
	 * DEFAULT_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	private static final String DEFAULT_INVOKETARGET = "A";
	/**
	 * UPDATED_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	private static final String UPDATED_INVOKETARGET = "B";
	/**
	 * DEFAULT_CRONEXPRESSION cron_expression  :  cron执行表达式
	 */
	private static final String DEFAULT_CRONEXPRESSION = "A";
	/**
	 * UPDATED_CRONEXPRESSION cron_expression  :  cron执行表达式
	 */
	private static final String UPDATED_CRONEXPRESSION = "B";
	/**
	 * DEFAULT_MISFIREPOLICY misfire_policy  :  计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final String DEFAULT_MISFIREPOLICY = "A";
	/**
	 * UPDATED_MISFIREPOLICY misfire_policy  :  计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final String UPDATED_MISFIREPOLICY = "B";
	/**
	 * DEFAULT_CONCURRENT concurrent  :  是否并发执行（1允许 0禁止）
	 */
	private static final String DEFAULT_CONCURRENT = "A";
	/**
	 * UPDATED_CONCURRENT concurrent  :  是否并发执行（1允许 0禁止）
	 */
	private static final String UPDATED_CONCURRENT = "B";
	/**
	 * DEFAULT_AVAILABLE available  :  状态(1-正常，0-锁定)
	 */
	private static final String DEFAULT_AVAILABLE = "A";
	/**
	 * UPDATED_AVAILABLE available  :  状态(1-正常，0-锁定)
	 */
	private static final String UPDATED_AVAILABLE = "B";
	/**
	 * DEFAULT_DESCRIPTION description  :  备注
	 */
	private static final String DEFAULT_DESCRIPTION = "A";
	/**
	 * UPDATED_DESCRIPTION description  :  备注
	 */
	private static final String UPDATED_DESCRIPTION = "B";
	private String DEFAULT_API_URL;
	@Autowired
	private JobService jobService;

	private MockMvc restJobMockMvc;
	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;
	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;
	@Autowired
	private ApplicationProperties applicationProperties;

	private JobDataVo jobDataVo;

	private JobDataVo anotherJobDataVo = new JobDataVo();

	/**
	 * Create an entity for this test.
	 * <p>
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an entity which requires the current entity.
	 */
	public static JobDataVo createEntity() {
		JobDataVo jobDataVo = ClassUtil.createObj(JobDataVo.class, Lists.newArrayList(
			JobDataVo.F_NAME
			, JobDataVo.F_GROUP
			, JobDataVo.F_INVOKETARGET
			, JobDataVo.F_CRONEXPRESSION
			, JobDataVo.F_MISFIREPOLICY
			, JobDataVo.F_CONCURRENT
			, JobDataVo.F_AVAILABLE
			, JobDataVo.F_DESCRIPTION
			),

			DEFAULT_NAME

			, DEFAULT_GROUP

			, DEFAULT_INVOKETARGET

			, DEFAULT_CRONEXPRESSION

			, DEFAULT_MISFIREPOLICY

			, DEFAULT_CONCURRENT

			, DEFAULT_AVAILABLE


			, DEFAULT_DESCRIPTION


		);
		return jobDataVo;
	}

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/quartz/job/");
		MockitoAnnotations.initMocks(this);
		final JobResource jobResource = new JobResource(jobService);
		this.restJobMockMvc = MockMvcBuilders.standaloneSetup(jobResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(TestUtil.createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	@BeforeEach
	public void initTest() {
		jobDataVo = createEntity();
	}

	@Test
	@Transactional
	public void createJob() throws Exception {
		int databaseSizeBeforeCreate = jobService.findAll().size();
		// Create the Job
		restJobMockMvc.perform(post(DEFAULT_API_URL)
			.param(PageModel.F_DESC, Job.F_SQL_CREATEDDATE)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDataVo)))
			.andExpect(status().isOk());
		;
		// Validate the Job in the database
		List<Job> jobList = jobService.findAll(
			Wrappers.<Job>query().lambda().orderByAsc(
				Job::getCreatedDate
			)
		);
		assertThat(jobList).hasSize(databaseSizeBeforeCreate + 1);
		Job testJob = jobList.get(jobList.size() - 1);
		assertThat(testJob.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testJob.getGroup()).isEqualTo(DEFAULT_GROUP);
		assertThat(testJob.getInvokeTarget()).isEqualTo(DEFAULT_INVOKETARGET);
		assertThat(testJob.getCronExpression()).isEqualTo(DEFAULT_CRONEXPRESSION);
		assertThat(testJob.getMisfirePolicy()).isEqualTo(DEFAULT_MISFIREPOLICY);
		assertThat(testJob.getConcurrent()).isEqualTo(DEFAULT_CONCURRENT);
		assertThat(testJob.getAvailable()).isEqualTo(DEFAULT_AVAILABLE);
		assertThat(testJob.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
	}

	@Test
	@Transactional
	public void checkNameIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.findAll().size();
		// set the field null
		jobDataVo.setName(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDataVo)))
			.andExpect(status().isBadRequest());

		List<Job> jobList = jobService.findAll();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional
	public void checkGroupIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.findAll().size();
		// set the field null
		jobDataVo.setGroup(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDataVo)))
			.andExpect(status().isBadRequest());

		List<Job> jobList = jobService.findAll();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional
	public void checkInvokeTargetIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.findAll().size();
		// set the field null
		jobDataVo.setInvokeTarget(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDataVo)))
			.andExpect(status().isBadRequest());

		List<Job> jobList = jobService.findAll();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}


	@Test
	@Transactional
	public void getAllJobs() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList
		restJobMockMvc.perform(get(DEFAULT_API_URL))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(jobDataVo.getId())))
			.andExpect(jsonPath("$.data.records.[*].cronExpression").value(hasItem(DEFAULT_CRONEXPRESSION)))
			.andExpect(jsonPath("$.data.records.[*].misfirePolicy").value(hasItem(DEFAULT_MISFIREPOLICY)))
			.andExpect(jsonPath("$.data.records.[*].concurrent").value(hasItem(DEFAULT_CONCURRENT)))
			.andExpect(jsonPath("$.data.records.[*].available").value(hasItem(DEFAULT_AVAILABLE)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	@Test
	@Transactional
	public void getJob() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get the job
		restJobMockMvc.perform(get(DEFAULT_API_URL + "{id}", jobDataVo.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.id").value(jobDataVo.getId()))
			.andExpect(jsonPath("$.data.cronExpression").value(DEFAULT_CRONEXPRESSION))
			.andExpect(jsonPath("$.data.misfirePolicy").value(DEFAULT_MISFIREPOLICY))
			.andExpect(jsonPath("$.data.concurrent").value(DEFAULT_CONCURRENT))
			.andExpect(jsonPath("$.data.available").value(DEFAULT_AVAILABLE))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION))
		;
	}

	@Test
	@Transactional
	public void getAllJobsByCronExpressionIsEqualToSomething() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where cronExpression equals to DEFAULT_CRONEXPRESSION
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_CRONEXPRESSION, DEFAULT_CRONEXPRESSION)
		);

		// Get all the jobList where cronExpression equals to UPDATED_CRONEXPRESSION
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_CRONEXPRESSION, UPDATED_CRONEXPRESSION)
		);
	}

	@Test
	@Transactional
	public void getAllJobsByCronExpressionIsInShouldWork() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where cronExpression in DEFAULT_CRONEXPRESSION or UPDATED_CRONEXPRESSION
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_CRONEXPRESSION, Lists.newArrayList(DEFAULT_CRONEXPRESSION, DEFAULT_CRONEXPRESSION))
		);

		// Get all the jobList where cronExpression equals to UPDATED_CRONEXPRESSION
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_CRONEXPRESSION, Lists.newArrayList(UPDATED_CRONEXPRESSION))
		);
	}

	@Test
	@Transactional
	public void getAllJobsByCronExpressionIsNullOrNotNull() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where cronExpression is not null
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNotNull(Job.F_CRONEXPRESSION));

		// Get all the jobList where cronExpression is null
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNull(Job.F_CRONEXPRESSION));
	}

	@Test
	@Transactional
	public void getAllJobsByMisfirePolicyIsEqualToSomething() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where misfirePolicy equals to DEFAULT_MISFIREPOLICY
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_MISFIREPOLICY, DEFAULT_MISFIREPOLICY)
		);

		// Get all the jobList where misfirePolicy equals to UPDATED_MISFIREPOLICY
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_MISFIREPOLICY, UPDATED_MISFIREPOLICY)
		);
	}

	@Test
	@Transactional
	public void getAllJobsByMisfirePolicyIsInShouldWork() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where misfirePolicy in DEFAULT_MISFIREPOLICY or UPDATED_MISFIREPOLICY
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_MISFIREPOLICY, Lists.newArrayList(DEFAULT_MISFIREPOLICY, DEFAULT_MISFIREPOLICY))
		);

		// Get all the jobList where misfirePolicy equals to UPDATED_MISFIREPOLICY
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_MISFIREPOLICY, Lists.newArrayList(UPDATED_MISFIREPOLICY))
		);
	}

	@Test
	@Transactional
	public void getAllJobsByMisfirePolicyIsNullOrNotNull() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where misfirePolicy is not null
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNotNull(Job.F_MISFIREPOLICY));

		// Get all the jobList where misfirePolicy is null
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNull(Job.F_MISFIREPOLICY));
	}

	@Test
	@Transactional
	public void getAllJobsByConcurrentIsEqualToSomething() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where concurrent equals to DEFAULT_CONCURRENT
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_CONCURRENT, DEFAULT_CONCURRENT)
		);

		// Get all the jobList where concurrent equals to UPDATED_CONCURRENT
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_CONCURRENT, UPDATED_CONCURRENT)
		);
	}

	@Test
	@Transactional
	public void getAllJobsByConcurrentIsInShouldWork() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where concurrent in DEFAULT_CONCURRENT or UPDATED_CONCURRENT
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_CONCURRENT, Lists.newArrayList(DEFAULT_CONCURRENT, DEFAULT_CONCURRENT))
		);

		// Get all the jobList where concurrent equals to UPDATED_CONCURRENT
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_CONCURRENT, Lists.newArrayList(UPDATED_CONCURRENT))
		);
	}

	@Test
	@Transactional
	public void getAllJobsByConcurrentIsNullOrNotNull() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where concurrent is not null
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNotNull(Job.F_CONCURRENT));

		// Get all the jobList where concurrent is null
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNull(Job.F_CONCURRENT));
	}

	@Test
	@Transactional
	public void getAllJobsByAvailableIsEqualToSomething() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where available equals to DEFAULT_AVAILABLE
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_AVAILABLE, DEFAULT_AVAILABLE)
		);

		// Get all the jobList where available equals to UPDATED_AVAILABLE
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_AVAILABLE, UPDATED_AVAILABLE)
		);
	}

	@Test
	@Transactional
	public void getAllJobsByAvailableIsInShouldWork() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where available in DEFAULT_AVAILABLE or UPDATED_AVAILABLE
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_AVAILABLE, Lists.newArrayList(DEFAULT_AVAILABLE, DEFAULT_AVAILABLE))
		);

		// Get all the jobList where available equals to UPDATED_AVAILABLE
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_AVAILABLE, Lists.newArrayList(UPDATED_AVAILABLE))
		);
	}

	@Test
	@Transactional
	public void getAllJobsByAvailableIsNullOrNotNull() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where available is not null
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNotNull(Job.F_AVAILABLE));

		// Get all the jobList where available is null
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNull(Job.F_AVAILABLE));
	}

	@Test
	@Transactional
	public void getAllJobsByDescriptionIsEqualToSomething() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where description equals to DEFAULT_DESCRIPTION
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_DESCRIPTION, DEFAULT_DESCRIPTION)
		);

		// Get all the jobList where description equals to UPDATED_DESCRIPTION
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.eq(Job.F_DESCRIPTION, UPDATED_DESCRIPTION)
		);
	}

	@Test
	@Transactional
	public void getAllJobsByDescriptionIsInShouldWork() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where description in DEFAULT_DESCRIPTION or UPDATED_DESCRIPTION
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_DESCRIPTION, Lists.newArrayList(DEFAULT_DESCRIPTION, DEFAULT_DESCRIPTION))
		);

		// Get all the jobList where description equals to UPDATED_DESCRIPTION
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()),
			QueryCondition.in(Job.F_DESCRIPTION, Lists.newArrayList(UPDATED_DESCRIPTION))
		);
	}

	@Test
	@Transactional
	public void getAllJobsByDescriptionIsNullOrNotNull() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		// Get all the jobList where description is not null
		defaultJobShouldBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNotNull(Job.F_DESCRIPTION));

		// Get all the jobList where description is null
		defaultJobShouldNotBeFound(QueryCondition.eq(Job.F_ID, jobDataVo.getId()), QueryCondition.isNull(Job.F_DESCRIPTION));
	}

	/**
	 * Executes the search, and checks that the default entity is returned
	 */
	private void defaultJobShouldBeFound(QueryCondition... queryCondition) throws Exception {
		restJobMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records").isArray())
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(jobDataVo.getId())))
			.andExpect(jsonPath("$.data.records.[*].cronExpression").value(hasItem(DEFAULT_CRONEXPRESSION)))
			.andExpect(jsonPath("$.data.records.[*].misfirePolicy").value(hasItem(DEFAULT_MISFIREPOLICY)))
			.andExpect(jsonPath("$.data.records.[*].concurrent").value(hasItem(DEFAULT_CONCURRENT)))
			.andExpect(jsonPath("$.data.records.[*].available").value(hasItem(DEFAULT_AVAILABLE)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	/**
	 * Executes the search, and checks that the default entity is not returned
	 */
	private void defaultJobShouldNotBeFound(QueryCondition... queryCondition) throws Exception {
		restJobMockMvc.perform(get(DEFAULT_API_URL).param("queryConditionJson", Json.toJSONString(Lists.newArrayList(queryCondition))))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records").isArray())
			.andExpect(jsonPath("$.data.records").isEmpty());
	}


	@Test
	@Transactional
	public void getNonExistingJob() throws Exception {
		// Get the job
		restJobMockMvc.perform(get(DEFAULT_API_URL + "{id}", Long.MAX_VALUE))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
	}

	@Test
	@Transactional
	public void updateJob() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);

		int databaseSizeBeforeUpdate = jobService.findAll().size();

		// Update the job
		Job updatedJob = jobService.findOneById(jobDataVo.getId());
		// Disconnect from session so that the updates on updatedJob are not directly saved in db
		ClassUtil.updateObj(updatedJob, Lists.newArrayList(
			Job.F_NAME
			, Job.F_GROUP
			, Job.F_INVOKETARGET
			, Job.F_CRONEXPRESSION
			, Job.F_MISFIREPOLICY
			, Job.F_CONCURRENT
			, Job.F_AVAILABLE
			, Job.F_DESCRIPTION
			),

			UPDATED_NAME

			, UPDATED_GROUP

			, UPDATED_INVOKETARGET

			, UPDATED_CRONEXPRESSION

			, UPDATED_MISFIREPOLICY

			, UPDATED_CONCURRENT

			, UPDATED_AVAILABLE


			, UPDATED_DESCRIPTION


		);

		JobDataVo jobVo = jobService.copyBeanToVo(updatedJob);
		restJobMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobVo)))
			.andExpect(status().isOk());

		// Validate the Job in the database
		List<Job> jobList = jobService.findAll();
		assertThat(jobList).hasSize(databaseSizeBeforeUpdate);

		Job testJob = jobList.stream().filter(item -> jobDataVo.getId().equals(item.getId())).findAny().get();
		assertThat(testJob.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testJob.getGroup()).isEqualTo(UPDATED_GROUP);
		assertThat(testJob.getInvokeTarget()).isEqualTo(UPDATED_INVOKETARGET);
		assertThat(testJob.getCronExpression()).isEqualTo(UPDATED_CRONEXPRESSION);
		assertThat(testJob.getMisfirePolicy()).isEqualTo(UPDATED_MISFIREPOLICY);
		assertThat(testJob.getConcurrent()).isEqualTo(UPDATED_CONCURRENT);
		assertThat(testJob.getAvailable()).isEqualTo(UPDATED_AVAILABLE);
		assertThat(testJob.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
	}


	@Test
	@Transactional
	public void deleteJob() throws Exception {
		// Initialize the database
		jobService.save(jobDataVo);
		int databaseSizeBeforeDelete = jobService.findAll().size();

		// Get the job
		restJobMockMvc.perform(delete(DEFAULT_API_URL + "{id}", jobDataVo.getId())
			.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		List<Job> jobList = jobService.findAll();
		assertThat(jobList).hasSize(databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional
	public void equalsVerifier() throws Exception {
		TestUtil.equalsVerifier(Job.class);
		Job job1 = new Job();
		job1.setId("id1");
		Job job2 = new Job();
		job2.setId(job1.getId());
		assertThat(job1).isEqualTo(job2);
		job2.setId("id2");
		assertThat(job1).isNotEqualTo(job2);
		job1.setId(null);
		assertThat(job1).isNotEqualTo(job2);
	}

}
