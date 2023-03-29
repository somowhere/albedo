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

package com.albedo.java.modules.quartz.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.quartz.domain.JobDo;
import com.albedo.java.modules.quartz.domain.dto.JobDto;
import com.albedo.java.modules.quartz.domain.enums.JobConcurrent;
import com.albedo.java.modules.quartz.domain.enums.JobMisfirePolicy;
import com.albedo.java.modules.quartz.domain.enums.JobStatus;
import com.albedo.java.modules.quartz.service.JobService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
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
@Slf4j
public class JobDoResourceIntTest extends SimulationRuntimeIntegrationTest {

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
	private static final String DEFAULT_CRONEXPRESSION = "0/10 * * * * ?";

	/**
	 * UPDATED_CRONEXPRESSION cron_expression : cron执行表达式
	 */
	private static final String UPDATED_CRONEXPRESSION = "0/15 * * * * ?";

	/**
	 * DEFAULT_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final JobMisfirePolicy DEFAULT_MISFIREPOLICY = JobMisfirePolicy.EXECUTE_DEFAULT;

	/**
	 * UPDATED_MISFIREPOLICY misfire_policy : 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	private static final JobMisfirePolicy UPDATED_MISFIREPOLICY = JobMisfirePolicy.IGNORE_MISFIRES;

	/**
	 * DEFAULT_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	private static final JobConcurrent DEFAULT_CONCURRENT = JobConcurrent.YES;

	/**
	 * UPDATED_CONCURRENT concurrent : 是否并发执行（1允许 0禁止）
	 */
	private static final JobConcurrent UPDATED_CONCURRENT = JobConcurrent.NO;

	/**
	 * DEFAULT_STATUS STATUS : 状态(1-正常，0-锁定)
	 */
	private static final JobStatus DEFAULT_STATUS = JobStatus.RUNNING;

	/**
	 * UPDATED_STATUS STATUS : 状态(1-正常，0-锁定)
	 */
	private static final JobStatus UPDATED_STATUS = JobStatus.PAUSE;

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
	public static JobDto createDto() {
		JobDto jobDto = ClassUtil.createObj(JobDto.class,
			Lists.newArrayList(JobDto.F_NAME, JobDto.F_GROUP, JobDto.F_INVOKETARGET, JobDto.F_CRONEXPRESSION,
				JobDto.F_MISFIREPOLICY, JobDto.F_CONCURRENT, JobDto.F_STATUS, JobDto.F_DESCRIPTION),

			DEFAULT_NAME

			, DEFAULT_GROUP

			, DEFAULT_INVOKETARGET

			, DEFAULT_CRONEXPRESSION

			, DEFAULT_MISFIREPOLICY

			, DEFAULT_CONCURRENT

			, DEFAULT_STATUS

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
		jobDto = createDto();
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createJob() throws Exception {
		int databaseSizeBeforeCreate = jobService.list().size();
		// Create the Job
		restJobMockMvc
			.perform(post(DEFAULT_API_URL).param(PageModel.F_DESC, JobDo.F_SQL_CREATED_DATE)
				.contentType(TestUtil.APPLICATION_JSON_UTF8).content(TestUtil.convertObjectToJsonBytes(jobDto)))
			.andExpect(status().isOk());
		// Validate the Job in the database
		List<JobDo> jobDoList = jobService.list(Wrappers.<JobDo>query().lambda().orderByAsc(JobDo::getCreatedDate));
		assertThat(jobDoList).hasSize(databaseSizeBeforeCreate + 1);
		JobDo testJobDo = jobDoList.get(jobDoList.size() - 1);
		assertThat(testJobDo.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testJobDo.getGroup()).isEqualTo(DEFAULT_GROUP);
		assertThat(testJobDo.getInvokeTarget()).isEqualTo(DEFAULT_INVOKETARGET);
		assertThat(testJobDo.getCronExpression()).isEqualTo(DEFAULT_CRONEXPRESSION);
		assertThat(testJobDo.getMisfirePolicy()).isEqualTo(DEFAULT_MISFIREPOLICY);
		assertThat(testJobDo.getConcurrent()).isEqualTo(DEFAULT_CONCURRENT);
		assertThat(testJobDo.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
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

		List<JobDo> jobDoList = jobService.list();
		assertThat(jobDoList).hasSize(databaseSizeBeforeTest);
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

		List<JobDo> jobDoList = jobService.list();
		assertThat(jobDoList).hasSize(databaseSizeBeforeTest);
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

		List<JobDo> jobDoList = jobService.list();
		assertThat(jobDoList).hasSize(databaseSizeBeforeTest);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getAllJobs() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);

		// Get all the jobList
		restJobMockMvc.perform(get(DEFAULT_API_URL)).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].id").value(hasItem(String.valueOf(jobDto.getId()))))
			.andExpect(jsonPath("$.data.records.[*].cronExpression").value(hasItem(DEFAULT_CRONEXPRESSION)))
			.andExpect(jsonPath("$.data.records.[*].concurrent").value(hasItem(DEFAULT_CONCURRENT.getValue())))
			.andExpect(jsonPath("$.data.records.[*].concurrentText").value(hasItem(DEFAULT_CONCURRENT.getText())))
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
			.andExpect(jsonPath("$.data.concurrent").value(DEFAULT_CONCURRENT.getValue()))
			.andExpect(jsonPath("$.data.concurrentText").value(DEFAULT_CONCURRENT.getText()))
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
		JobDo updatedJobDo = jobService.getById(jobDto.getId());
		// Disconnect from session so that the updates on updatedJob are not directly
		// saved in db
		ClassUtil.updateObj(updatedJobDo,
			Lists.newArrayList(JobDo.F_NAME, JobDo.F_GROUP, JobDo.F_INVOKETARGET, JobDo.F_CRONEXPRESSION,
				JobDo.F_MISFIREPOLICY, JobDo.F_CONCURRENT, JobDo.F_STATUS, JobDo.F_DESCRIPTION),

			UPDATED_NAME

			, UPDATED_GROUP

			, UPDATED_INVOKETARGET

			, UPDATED_CRONEXPRESSION

			, UPDATED_MISFIREPOLICY

			, UPDATED_CONCURRENT

			, UPDATED_STATUS

			, UPDATED_DESCRIPTION

		);

		JobDto jobVo = jobService.copyBeanToDto(updatedJobDo);
		restJobMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(jobVo))).andExpect(status().isOk());

		// Validate the Job in the database
		List<JobDo> jobDoList = jobService.list();
		assertThat(jobDoList).hasSize(databaseSizeBeforeUpdate);

		JobDo testJobDo = jobDoList.stream().filter(item -> jobDto.getId().equals(item.getId())).findAny().get();
		assertThat(testJobDo.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testJobDo.getGroup()).isEqualTo(UPDATED_GROUP);
		assertThat(testJobDo.getInvokeTarget()).isEqualTo(UPDATED_INVOKETARGET);
		assertThat(testJobDo.getCronExpression()).isEqualTo(UPDATED_CRONEXPRESSION);
		assertThat(testJobDo.getMisfirePolicy()).isEqualTo(UPDATED_MISFIREPOLICY);
		assertThat(testJobDo.getConcurrent()).isEqualTo(UPDATED_CONCURRENT);
		assertThat(testJobDo.getStatus()).isEqualTo(UPDATED_STATUS);
		assertThat(testJobDo.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteJob() throws Exception {
		// Initialize the database
		jobService.saveOrUpdate(jobDto);
		int databaseSizeBeforeDelete = jobService.list().size();

		// Delete the job
		restJobMockMvc.perform(delete(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(jobDto.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		List<JobDo> jobDoList = jobService.list();
		assertThat(jobDoList).hasSize(databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void equalsVerifier() throws Exception {
		TestUtil.equalsVerifier(JobDo.class);
		JobDo jobDo1 = new JobDo();
		jobDo1.setId(44l);
		JobDo jobDo2 = new JobDo();
		jobDo2.setId(jobDo1.getId());
		assertThat(jobDo1).isEqualTo(jobDo2);
		jobDo2.setId(55l);
		assertThat(jobDo1).isNotEqualTo(jobDo2);
		jobDo1.setId(null);
		assertThat(jobDo1).isNotEqualTo(jobDo2);
	}

}
