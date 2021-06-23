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

package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.domain.dto.JobDto;
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
	 * DEFAULT_NAME name : 任务名称
	 */
	private static final String DEFAULT_NAME = "A";

	/**
	 * UPDATED_NAME name : 任务名称
	 */
	private static final String UPDATED_NAME = "B";

	/**
	 * DEFAULT_GROUP group : 任务组名
	 */
	private static final String DEFAULT_GROUP = "A";

	/**
	 * UPDATED_GROUP group : 任务组名
	 */
	private static final String UPDATED_GROUP = "B";

	/**
	 * DEFAULT_INVOKETARGET invoke_target : 调用目标字符串
	 */
	private static final String DEFAULT_INVOKETARGET = "A";

	/**
	 * UPDATED_INVOKETARGET invoke_target : 调用目标字符串
	 */
	private static final String UPDATED_INVOKETARGET = "B";

	/**
	 * DEFAULT_CRONEXPRESSION cron_expression : cron执行表达式
	 */
	private static final String DEFAULT_CRONEXPRESSION = "A";

	/**
	 * UPDATED_CRONEXPRESSION cron_expression : cron执行表达式
	 */
	private static final String UPDATED_CRONEXPRESSION = "B";

	/**
	 * DEFAULT_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final String DEFAULT_MISFIREPOLICY = "A";

	/**
	 * UPDATED_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final String UPDATED_MISFIREPOLICY = "B";

	/**
	 * DEFAULT_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	private static final String DEFAULT_CONCURRENT = "A";

	/**
	 * UPDATED_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	private static final String UPDATED_CONCURRENT = "B";

	/**
	 * DEFAULT_AVAILABLE available : 状态(1-正常，0-锁定)
	 */
	private static final String DEFAULT_AVAILABLE = "A";

	/**
	 * UPDATED_AVAILABLE available : 状态(1-正常，0-锁定)
	 */
	private static final String UPDATED_AVAILABLE = "B";

	/**
	 * DEFAULT_DESCRIPTION description : 备注
	 */
	private static final String DEFAULT_DESCRIPTION = "A";

	/**
	 * UPDATED_DESCRIPTION description : 备注
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

	private JobDto jobDto;

	private JobDto anotherJobDto = new JobDto();

	/**
	 * Create an entity for this test.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an entity which requires the current entity.
	 */
	public static JobDto createEntity() {
		JobDto jobDto = ClassUtil.createObj(JobDto.class,
			Lists.newArrayList(JobDto.F_NAME, JobDto.F_GROUP, JobDto.F_INVOKETARGET, JobDto.F_CRONEXPRESSION,
				JobDto.F_MISFIREPOLICY, JobDto.F_CONCURRENT, JobDto.F_AVAILABLE, JobDto.F_DESCRIPTION),

			DEFAULT_NAME

			, DEFAULT_GROUP

			, DEFAULT_INVOKETARGET

			, DEFAULT_CRONEXPRESSION

			, DEFAULT_MISFIREPOLICY

			, DEFAULT_CONCURRENT

			, DEFAULT_AVAILABLE

			, DEFAULT_DESCRIPTION

		);
		return jobDto;
	}

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/quartz/job/");
		MockitoAnnotations.openMocks(this);
		final JobResource jobResource = new JobResource(jobService);
		this.restJobMockMvc = MockMvcBuilders.standaloneSetup(jobResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(TestUtil.createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();
	}

	@BeforeEach
	public void initTest() {
		jobDto = createEntity();
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createJob() throws Exception {
		int databaseSizeBeforeCreate = jobService.list().size();
		// Create the Job
		restJobMockMvc
			.perform(post(DEFAULT_API_URL).param(PageModel.F_DESC, Job.F_SQL_CREATED_DATE)
				.contentType(TestUtil.APPLICATION_JSON_UTF8).content(TestUtil.convertObjectToJsonBytes(jobDto)))
			.andExpect(status().isOk());
		// Validate the Job in the database
		List<Job> jobList = jobService.list(Wrappers.<Job>query().lambda().orderByAsc(Job::getCreatedDate));
		assertThat(jobList).hasSize(databaseSizeBeforeCreate + 1);
		Job testJob = jobList.get(jobList.size() - 1);
		assertThat(testJob.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testJob.getGroup()).isEqualTo(DEFAULT_GROUP);
		assertThat(testJob.getInvokeTarget()).isEqualTo(DEFAULT_INVOKETARGET);
		assertThat(testJob.getCronExpression()).isEqualTo(DEFAULT_CRONEXPRESSION);
		assertThat(testJob.getMisfirePolicy()).isEqualTo(DEFAULT_MISFIREPOLICY);
		assertThat(testJob.getConcurrent()).isEqualTo(DEFAULT_CONCURRENT);
		assertThat(testJob.getStatus()).isEqualTo(DEFAULT_AVAILABLE);
		assertThat(testJob.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void checkNameIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.list().size();
		// set the field null
		jobDto.setName(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDto))).andExpect(status().isBadRequest());

		List<Job> jobList = jobService.list();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void checkGroupIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.list().size();
		// set the field null
		jobDto.setGroup(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDto))).andExpect(status().isBadRequest());

		List<Job> jobList = jobService.list();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void checkInvokeTargetIsRequired() throws Exception {
		int databaseSizeBeforeTest = jobService.list().size();
		// set the field null
		jobDto.setInvokeTarget(null);

		// Create the Job, which fails.

		restJobMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobDto))).andExpect(status().isBadRequest());

		List<Job> jobList = jobService.list();
		assertThat(jobList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getAllJobs() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);

		// Get all the jobList
		restJobMockMvc.perform(get(DEFAULT_API_URL)).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(jobDto.getId())))
			.andExpect(jsonPath("$.data.records.[*].cronExpression").value(hasItem(DEFAULT_CRONEXPRESSION)))
			.andExpect(jsonPath("$.data.records.[*].misfirePolicy").value(hasItem(DEFAULT_MISFIREPOLICY)))
			.andExpect(jsonPath("$.data.records.[*].concurrent").value(hasItem(DEFAULT_CONCURRENT)))
			.andExpect(jsonPath("$.data.records.[*].available").value(hasItem(DEFAULT_AVAILABLE)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getJob() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);

		// Get the job
		restJobMockMvc.perform(get(DEFAULT_API_URL + "{id}", jobDto.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.id").value(jobDto.getId()))
			.andExpect(jsonPath("$.data.cronExpression").value(DEFAULT_CRONEXPRESSION))
			.andExpect(jsonPath("$.data.misfirePolicy").value(DEFAULT_MISFIREPOLICY))
			.andExpect(jsonPath("$.data.concurrent").value(DEFAULT_CONCURRENT))
			.andExpect(jsonPath("$.data.available").value(DEFAULT_AVAILABLE))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingJob() throws Exception {
		// Get the job
		restJobMockMvc.perform(get(DEFAULT_API_URL + "{id}", Long.MAX_VALUE)).andExpect(status().isOk())
			.andExpect(jsonPath("$.data").isEmpty());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateJob() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);

		int databaseSizeBeforeUpdate = jobService.list().size();

		// Update the job
		Job updatedJob = jobService.getById(jobDto.getId());
		// Disconnect from session so that the updates on updatedJob are not directly
		// saved in db
		ClassUtil.updateObj(updatedJob,
			Lists.newArrayList(Job.F_NAME, Job.F_GROUP, Job.F_INVOKETARGET, Job.F_CRONEXPRESSION,
				Job.F_MISFIREPOLICY, Job.F_CONCURRENT, Job.F_AVAILABLE, Job.F_DESCRIPTION),

			UPDATED_NAME

			, UPDATED_GROUP

			, UPDATED_INVOKETARGET

			, UPDATED_CRONEXPRESSION

			, UPDATED_MISFIREPOLICY

			, UPDATED_CONCURRENT

			, UPDATED_AVAILABLE

			, UPDATED_DESCRIPTION

		);

		JobDto jobVo = jobService.copyBeanToDto(updatedJob);
		restJobMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobVo))).andExpect(status().isOk());

		// Validate the Job in the database
		List<Job> jobList = jobService.list();
		assertThat(jobList).hasSize(databaseSizeBeforeUpdate);

		Job testJob = jobList.stream().filter(item -> jobDto.getId().equals(item.getId())).findAny().get();
		assertThat(testJob.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testJob.getGroup()).isEqualTo(UPDATED_GROUP);
		assertThat(testJob.getInvokeTarget()).isEqualTo(UPDATED_INVOKETARGET);
		assertThat(testJob.getCronExpression()).isEqualTo(UPDATED_CRONEXPRESSION);
		assertThat(testJob.getMisfirePolicy()).isEqualTo(UPDATED_MISFIREPOLICY);
		assertThat(testJob.getConcurrent()).isEqualTo(UPDATED_CONCURRENT);
		assertThat(testJob.getStatus()).isEqualTo(UPDATED_AVAILABLE);
		assertThat(testJob.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteJob() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);
		int databaseSizeBeforeDelete = jobService.list().size();

		// Get the job
		restJobMockMvc.perform(delete(DEFAULT_API_URL + "{id}", jobDto.getId()).accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		List<Job> jobList = jobService.list();
		assertThat(jobList).hasSize(databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void equalsVerifier() throws Exception {
		TestUtil.equalsVerifier(Job.class);
		Job job1 = new Job();
		job1.setId(44);
		Job job2 = new Job();
		job2.setId(job1.getId());
		assertThat(job1).isEqualTo(job2);
		job2.setId(55);
		assertThat(job1).isNotEqualTo(job2);
		job1.setId(null);
		assertThat(job1).isNotEqualTo(job2);
	}

}
