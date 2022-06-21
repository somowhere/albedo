/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.domain.DictDo;
import com.albedo.java.modules.sys.domain.dto.DictDto;
import com.albedo.java.modules.sys.service.DictService;
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

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DictResource REST web.
 *
 * @see DictResource
 */

@Slf4j
public class DictResourceIntTest extends SimulationRuntimeIntegrationTest {

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";

	private static final String DEFAULT_NAME = "NAME1";

	private static final String UPDATED_NAME = "NAME2";

	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";

	private static final String DEFAULT_CODE = "CODE1";

	private static final String UPDATED_CODE = "CODE2";

	private static final Integer DEFAULT_AVAILABLE = CommonConstants.YES;

	private static final Integer UPDATED_AVAILABLE = CommonConstants.NO;

	private static final String DEFAULT_ANOTHER_VAL = "ANOTHER_VAL";

	private static final String DEFAULT_VAL = "VAL1";

	private static final String UPDATED_VAL = "VAL2";

	private static final Long DEFAULT_ANOTHER_PARENT_ID = -2L;

	// private static final String DEFAULT_PARENT_ID = "PARENT_ID1";
	private static final Long UPDATED_PARENT_ID = 2L;

	private static final Integer DEFAULT_SORT = 10;

	private static final Integer UPDATED_SORT = 20;

	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";

	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";

	private String DEFAULT_API_URL;

	@Autowired
	private DictService dictService;

	private MockMvc restDictMockMvc;

	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;

	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	@Autowired
	private ApplicationProperties applicationProperties;

	private DictDto dict;

	private DictDto anotherDict = new DictDto();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/dict/");
		MockitoAnnotations.openMocks(this);
		final DictResource dictResource = new DictResource(dictService);
		this.restDictMockMvc = MockMvcBuilders.standaloneSetup(dictResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler).setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();
	}

	/**
	 * Create a Dict.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an domain which has a required relationship to the Dict domain.
	 */
	public DictDto createDto() {
		DictDto dict = new DictDto();
		dict.setName(DEFAULT_NAME);
		dict.setVal(DEFAULT_VAL);
		dict.setCode(DEFAULT_CODE);
		dict.setAvailable(DEFAULT_AVAILABLE);
		dict.setSort(DEFAULT_SORT);
		dict.setDescription(DEFAULT_DESCRIPTION);
		return dict;
	}

	@BeforeEach
	public void initTest() {
		dict = createDto();
		// Initialize the database

		anotherDict.setName(DEFAULT_ANOTHER_NAME);
		anotherDict.setVal(DEFAULT_ANOTHER_VAL);
		anotherDict.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		anotherDict.setCode(DEFAULT_ANOTHER_CODE);
		anotherDict.setSort(DEFAULT_SORT);
		anotherDict.setDescription(DEFAULT_DESCRIPTION);
		dictService.saveOrUpdate(anotherDict);

		dict.setParentId(anotherDict.getId());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDict() throws Exception {
		List<DictDo> databaseSizeBeforeCreate = dictService.list();

		// Create the Dict
		restDictMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(dict))).andExpect(status().isOk());

		// Validate the Dict in the database
		List<DictDo> dictDoList = dictService.list();
		assertThat(dictDoList).hasSize(databaseSizeBeforeCreate.size() + 1);
		DictDo testDictDo = dictService.getOne(Wrappers.<DictDo>query().lambda().eq(DictDo::getName, dict.getName()));
		assertThat(testDictDo.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testDictDo.getCode()).isEqualTo(DEFAULT_CODE);
		assertThat(testDictDo.getVal()).isEqualTo(DEFAULT_VAL);
		assertThat(testDictDo.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testDictDo.getParentId()).isEqualTo(anotherDict.getId());
		assertThat(testDictDo.getParentIds()).contains(String.valueOf(anotherDict.getId()));
		assertThat(testDictDo.isLeaf()).isEqualTo(true);
		assertThat(testDictDo.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testDictDo.getDelFlag()).isEqualTo(DictDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDictWithExistingCode() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		int databaseSizeBeforeCreate = dictService.list().size();

		// Create the Dict
		DictDto managedDictVM = createDto();

		// Create the Dict
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isBadRequest()).andExpect(jsonPath("$.code").value(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Validate the Dict in the database
		List<DictDo> dictDoList = dictService.list();
		assertThat(dictDoList).hasSize(databaseSizeBeforeCreate);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getDictPage() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		// Get all the dicts
		restDictMockMvc
			.perform(get(DEFAULT_API_URL)
				.param("blurry", dict.getName())
				.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
			.andExpect(jsonPath("$.data.records.[*].val").value(hasItem(DEFAULT_VAL)))
			.andExpect(jsonPath("$.data.records.[*].available").value(hasItem(DEFAULT_AVAILABLE)))
			.andExpect(jsonPath("$.data.records.[*].sort").value(hasItem(DEFAULT_SORT)))
			.andExpect(jsonPath("$.data.records.[*].parentId").value(hasItem(String.valueOf(anotherDict.getId()))))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getDict() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);

		// Get the dict
		restDictMockMvc.perform(get(DEFAULT_API_URL + "{id}", dict.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.code").value(DEFAULT_CODE))
			.andExpect(jsonPath("$.data.val").value(DEFAULT_VAL))
			.andExpect(jsonPath("$.data.available").value(DEFAULT_AVAILABLE))
			.andExpect(jsonPath("$.data.parentId").value(anotherDict.getId()))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingDict() throws Exception {
		restDictMockMvc.perform(get("/sys/dict/ddd/unknown")).andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateDict() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		int databaseSizeBeforeUpdate = dictService.list().size();

		// Update the dict
		DictDo updatedDictDo = dictService.getById(dict.getId());

		DictDto managedDictVM = new DictDto();
		managedDictVM.setName(UPDATED_NAME);
		managedDictVM.setCode(UPDATED_CODE);
		managedDictVM.setVal(UPDATED_VAL);
		managedDictVM.setSort(UPDATED_SORT);
		managedDictVM.setParentId(UPDATED_PARENT_ID);
		managedDictVM.setDescription(UPDATED_DESCRIPTION);

		managedDictVM.setId(updatedDictDo.getId());
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Dict in the database
		List<DictDo> dictDoList = dictService.list();
		assertThat(dictDoList).hasSize(databaseSizeBeforeUpdate);
		DictDo testDictDo = dictService.getById(updatedDictDo.getId());
		assertThat(testDictDo.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDictDo.getCode()).isEqualTo(UPDATED_CODE);
		assertThat(testDictDo.getVal()).isEqualTo(UPDATED_VAL);
		assertThat(testDictDo.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testDictDo.getParentId()).isEqualTo(UPDATED_PARENT_ID);
		// assertThat(testDict.getParentIds()).contains(UPDATED_PARENT_ID);
		assertThat(testDictDo.isLeaf()).isEqualTo(true);
		assertThat(testDictDo.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testDictDo.getDelFlag()).isEqualTo(DictDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateDictExistingCode() throws Exception {

		dictService.saveOrUpdate(dict);
		// Update the dict
		DictDo updatedDictDo = dictService.getById(dict.getId());

		DictDto managedDictVM = new DictDto();
		managedDictVM.setName(DEFAULT_ANOTHER_NAME);
		managedDictVM.setVal(DEFAULT_ANOTHER_VAL);
		managedDictVM.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		managedDictVM.setCode(DEFAULT_ANOTHER_CODE);
		managedDictVM.setSort(DEFAULT_SORT);
		managedDictVM.setDescription(DEFAULT_DESCRIPTION);
		managedDictVM.setId(updatedDictDo.getId());
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isBadRequest()).andExpect(jsonPath("$.code").value(ResponseCode.ILLEGAL_ARGUMENT_EX.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Update the dict
		DictDo updatedDictAfterDo = dictService.getById(dict.getId());
		assertThat(updatedDictAfterDo.getCode()).isEqualTo(updatedDictDo.getCode());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteDict() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		long databaseSizeBeforeDelete = dictService.count();

		// Delete the dict
		restDictMockMvc.perform(delete(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(dict.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = dictService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testDictEquals() throws Exception {
		TestUtil.equalsVerifier(DictDo.class);
		DictDo dictDo1 = new DictDo();
		dictDo1.setId(1L);
		dictDo1.setName("Dict1");
		DictDo dictDo2 = new DictDo();
		dictDo2.setId(dictDo1.getId());
		dictDo2.setName(dictDo1.getName());
		assertThat(dictDo1).isEqualTo(dictDo2);
		dictDo2.setId(2L);
		dictDo2.setName("Dict2");
		assertThat(dictDo1).isNotEqualTo(dictDo2);
		dictDo1.setId(null);
		assertThat(dictDo1).isNotEqualTo(dictDo2);
	}

}
