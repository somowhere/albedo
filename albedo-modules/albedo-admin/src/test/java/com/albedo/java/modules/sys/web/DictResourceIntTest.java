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
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.dto.DictDto;
import com.albedo.java.modules.sys.service.DictService;
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
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the DictResource REST web.
 *
 * @see DictResource
 */
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class DictResourceIntTest {

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";

	private static final String DEFAULT_NAME = "NAME1";

	private static final String UPDATED_NAME = "NAME2";

	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";

	private static final String DEFAULT_CODE = "CODE1";

	private static final String UPDATED_CODE = "CODE2";

	private static final Integer DEFAULT_SHOW = CommonConstants.YES;

	private static final Integer UPDATED_SHOW = CommonConstants.NO;

	private static final String DEFAULT_ANOTHER_VAL = "ANOTHER_VAL";

	private static final String DEFAULT_VAL = "VAL1";

	private static final String UPDATED_VAL = "VAL2";

	private static final Long DEFAULT_ANOTHER_PARENT_ID = -2L;

	// private static final String DEFAULT_PARENT_ID = "PARENT_ID1";
	private static final Long UPDATED_PARENT_ID = 2L;

	private static final Integer DEFAULT_SORT = 10;

	private static final Integer UPDATED_SORT = 20;

	private static final String DEFAULT_REMARK = "REMARK1";

	private static final String UPDATED_REMARK = "REMARK2";

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
	public DictDto createEntity() {
		DictDto dict = new DictDto();
		dict.setName(DEFAULT_NAME);
		dict.setVal(DEFAULT_VAL);
		dict.setCode(DEFAULT_CODE);
		dict.setSort(DEFAULT_SORT);
		dict.setRemark(DEFAULT_REMARK);
		dict.setDescription(DEFAULT_DESCRIPTION);
		return dict;
	}

	@BeforeEach
	public void initTest() {
		dict = createEntity();
		// Initialize the database

		anotherDict.setName(DEFAULT_ANOTHER_NAME);
		anotherDict.setVal(DEFAULT_ANOTHER_VAL);
		anotherDict.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		anotherDict.setCode(DEFAULT_ANOTHER_CODE);
		anotherDict.setSort(DEFAULT_SORT);
		anotherDict.setRemark(DEFAULT_REMARK);
		anotherDict.setDescription(DEFAULT_DESCRIPTION);
		dictService.saveOrUpdate(anotherDict);

		dict.setParentId(anotherDict.getId());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDict() throws Exception {
		List<Dict> databaseSizeBeforeCreate = dictService.list();

		// Create the Dict
		restDictMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(dict))).andExpect(status().isOk());

		// Validate the Dict in the database
		List<Dict> dictList = dictService.list();
		assertThat(dictList).hasSize(databaseSizeBeforeCreate.size() + 1);
		Dict testDict = dictService.getOne(Wrappers.<Dict>query().lambda().eq(Dict::getName, dict.getName()));
		assertThat(testDict.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testDict.getCode()).isEqualTo(DEFAULT_CODE);
		assertThat(testDict.getVal()).isEqualTo(DEFAULT_VAL);
		assertThat(testDict.getSort()).isEqualTo(DEFAULT_SORT);
		assertThat(testDict.getParentId()).isEqualTo(anotherDict.getId());
		assertThat(testDict.getParentIds()).contains(String.valueOf(anotherDict.getId()));
		assertThat(testDict.isLeaf()).isEqualTo(true);
		assertThat(testDict.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testDict.getDelFlag()).isEqualTo(Dict.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createDictWithExistingCode() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		int databaseSizeBeforeCreate = dictService.list().size();

		// Create the Dict
		DictDto managedDictVM = createEntity();

		// Create the Dict
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(ResponseCode.FAIL.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Validate the Dict in the database
		List<Dict> dictList = dictService.list();
		assertThat(dictList).hasSize(databaseSizeBeforeCreate);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getDictPage() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		// Get all the dicts
		restDictMockMvc
			.perform(get(DEFAULT_API_URL).param(PageModel.F_DESC, "parent.created_date")
				.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
			.andExpect(jsonPath("$.data.records.[*].val").value(hasItem(DEFAULT_VAL)))
			.andExpect(jsonPath("$.data.records.[*].show").value(hasItem(DEFAULT_SHOW)))
			.andExpect(jsonPath("$.data.records.[*].sort").value(hasItem(DEFAULT_SORT)))
			.andExpect(jsonPath("$.data.records.[*].parentId").value(hasItem(anotherDict.getId())))
			.andExpect(jsonPath("$.data.records.[*].remark").value(hasItem(DEFAULT_REMARK)))
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
			.andExpect(jsonPath("$.data.show").value(DEFAULT_SHOW))
			.andExpect(jsonPath("$.data.parentId").value(anotherDict.getId()))
			.andExpect(jsonPath("$.data.remark").value(DEFAULT_REMARK))
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
		Dict updatedDict = dictService.getById(dict.getId());

		DictDto managedDictVM = new DictDto();
		managedDictVM.setName(UPDATED_NAME);
		managedDictVM.setCode(UPDATED_CODE);
		managedDictVM.setVal(UPDATED_VAL);
		managedDictVM.setSort(UPDATED_SORT);
		managedDictVM.setParentId(UPDATED_PARENT_ID);
		managedDictVM.setRemark(UPDATED_REMARK);
		managedDictVM.setDescription(UPDATED_DESCRIPTION);

		managedDictVM.setId(updatedDict.getId());
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Dict in the database
		List<Dict> dictList = dictService.list();
		assertThat(dictList).hasSize(databaseSizeBeforeUpdate);
		Dict testDict = dictService.getById(updatedDict.getId());
		assertThat(testDict.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testDict.getCode()).isEqualTo(UPDATED_CODE);
		assertThat(testDict.getVal()).isEqualTo(UPDATED_VAL);
		assertThat(testDict.getSort()).isEqualTo(UPDATED_SORT);
		assertThat(testDict.getParentId()).isEqualTo(UPDATED_PARENT_ID);
		// assertThat(testDict.getParentIds()).contains(UPDATED_PARENT_ID);
		assertThat(testDict.isLeaf()).isEqualTo(true);
		assertThat(testDict.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testDict.getDelFlag()).isEqualTo(Dict.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateDictExistingCode() throws Exception {

		dictService.saveOrUpdate(dict);
		// Update the dict
		Dict updatedDict = dictService.getById(dict.getId());

		DictDto managedDictVM = new DictDto();
		managedDictVM.setName(DEFAULT_ANOTHER_NAME);
		managedDictVM.setVal(DEFAULT_ANOTHER_VAL);
		managedDictVM.setParentId(DEFAULT_ANOTHER_PARENT_ID);
		managedDictVM.setCode(DEFAULT_ANOTHER_CODE);
		managedDictVM.setSort(DEFAULT_SORT);
		managedDictVM.setRemark(DEFAULT_REMARK);
		managedDictVM.setDescription(DEFAULT_DESCRIPTION);
		managedDictVM.setId(updatedDict.getId());
		restDictMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedDictVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(ResponseCode.FAIL.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Update the dict
		Dict updatedDictAfter = dictService.getById(dict.getId());
		assertThat(updatedDictAfter.getCode()).isEqualTo(updatedDict.getCode());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteDict() throws Exception {
		// Initialize the database
		dictService.saveOrUpdate(dict);
		long databaseSizeBeforeDelete = dictService.count();

		// Delete the dict
		restDictMockMvc.perform(delete(DEFAULT_API_URL + "{id}", dict.getId()).accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = dictService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testDictEquals() throws Exception {
		TestUtil.equalsVerifier(Dict.class);
		Dict dict1 = new Dict();
		dict1.setId(1L);
		dict1.setName("Dict1");
		Dict dict2 = new Dict();
		dict2.setId(dict1.getId());
		dict2.setName(dict1.getName());
		assertThat(dict1).isEqualTo(dict2);
		dict2.setId(2L);
		dict2.setName("Dict2");
		assertThat(dict1).isNotEqualTo(dict2);
		dict1.setId(null);
		assertThat(dict1).isNotEqualTo(dict2);
	}

}
