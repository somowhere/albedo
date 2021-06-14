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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.dto.DeptDto;
import com.albedo.java.modules.sys.service.DeptService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
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

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DeptResource REST web.
 *
 * @see DeptResource
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class DeptResourceIntTest {

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";

	private static final String DEFAULT_NAME = "NAME1";

	private static final String UPDATED_NAME = "NAME2";

	private static final String DEFAULT_ANOTHER_PARENT_ID = "ANOTHER_PARENT_ID";

	// private static final String DEFAULT_PARENT_ID = "PARENT_ID1";
	private static final String UPDATED_PARENT_ID = "PARENT_ID2";

	private static final Integer DEFAULT_SORT = 10;

	private static final Integer UPDATED_SORT = 20;

	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";

	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";

	private String DEFAULT_API_URL;

	@Autowired
	private DeptService deptService;

	private MockMvc restDeptMockMvc;

	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;

	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	@Autowired
	private ApplicationProperties applicationProperties;

	private DeptDto dept;

	private DeptDto anotherDept = new DeptDto();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/dept/");
		MockitoAnnotations.initMocks(this);
		final DeptResource deptResource = new DeptResource(deptService);
		this.restDeptMockMvc = MockMvcBuilders.standaloneSetup(deptResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler).setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();
	}

	/**
	 * Create a Dept.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an domain which has a required relationship to the Dept domain.
	 */
	public DeptDto createEntity() {
		DeptDto dept = new DeptDto();
		dept.setName(DEFAULT_NAME);
		dept.setSort(DEFAULT_SORT);
		dept.setDescription(DEFAULT_DESCRIPTION);
		return dept;
	}

	@BeforeEach
	public void initTest() {
		dept = createEntity();
		// Initialize the database

		anotherDept.setName(DEFAULT_ANOTHER_NAME);
		anotherDept.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		anotherDept.setSort(DEFAULT_SORT);
		anotherDept.setDescription(DEFAULT_DESCRIPTION);
		deptService.saveOrUpdate(anotherDept);

		dept.setParentId(anotherDept.getId());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDept() throws Exception {
		List<Dept> databaseSizeBeforeCreate = deptService.list();

		// Create the Dept
		restDeptMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(dept))).andExpect(status().isOk());

		// Validate the Dept in the database
		List<Dept> deptList = deptService.list();
		assertThat(deptList).hasSize(databaseSizeBeforeCreate.size() + 1);
		Dept testDept = deptService.getOne(Wrappers.<Dept>query().lambda().eq(Dept::getName, dept.getName()));
		assertThat(testDept.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testDept.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testDept.getParentId()).isEqualTo(anotherDept.getId());
		assertThat(testDept.getParentIds()).contains(anotherDept.getId());
		assertThat(testDept.isLeaf()).isEqualTo(true);
		assertThat(testDept.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testDept.getDelFlag()).isEqualTo(Dept.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);

		// Get the dept
		restDeptMockMvc.perform(get(DEFAULT_API_URL + "{id}", dept.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.parentId").value(anotherDept.getId()))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingDept() throws Exception {
		restDeptMockMvc.perform(get("/sys/dept/ddd/unknown")).andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);
		int databaseSizeBeforeUpdate = deptService.list().size();

		// Update the dept
		Dept updatedDept = deptService.getById(dept.getId());

		DeptDto managedDeptVM = new DeptDto();
		managedDeptVM.setName(UPDATED_NAME);
		managedDeptVM.setSort(UPDATED_SORT);
		managedDeptVM.setParentId(UPDATED_PARENT_ID);
		managedDeptVM.setDescription(UPDATED_DESCRIPTION);

		managedDeptVM.setId(updatedDept.getId());
		restDeptMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDeptVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Dept in the database
		List<Dept> deptList = deptService.list();
		assertThat(deptList).hasSize(databaseSizeBeforeUpdate);
		Dept testDept = deptService.getById(updatedDept.getId());
		assertThat(testDept.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDept.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testDept.getParentId()).isEqualTo(UPDATED_PARENT_ID);
		// assertThat(testDept.getParentIds()).contains(UPDATED_PARENT_ID);
		assertThat(testDept.isLeaf()).isEqualTo(true);
		assertThat(testDept.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testDept.getDelFlag()).isEqualTo(Dept.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteDept() throws Exception {
		// Initialize the database
		deptService.saveOrUpdate(dept);
		long databaseSizeBeforeDelete = deptService.count();

		// Delete the dept
		restDeptMockMvc.perform(delete(DEFAULT_API_URL + "{id}", dept.getId()).accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = deptService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testDeptEquals() throws Exception {
		TestUtil.equalsVerifier(Dept.class);
		Dept dept1 = new Dept();
		dept1.setId("1");
		dept1.setName("Dept1");
		Dept dept2 = new Dept();
		dept2.setId(dept1.getId());
		dept2.setName(dept1.getName());
		assertThat(dept1).isEqualTo(dept2);
		dept2.setId("2");
		dept2.setName("Dept2");
		assertThat(dept1).isNotEqualTo(dept2);
		dept1.setId(null);
		assertThat(dept1).isNotEqualTo(dept2);
	}

}
