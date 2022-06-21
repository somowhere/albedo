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

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.domain.*;
import com.albedo.java.modules.sys.domain.dto.RoleDto;
import com.albedo.java.modules.sys.domain.enums.DataScopeType;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.*;
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

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.List;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the RoleResource REST web.
 *
 * @see RoleResource
 */
@Slf4j
public class RoleResourceIntTest extends SimulationRuntimeIntegrationTest {

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";

	private static final String DEFAULT_NAME = "NAME1";

	private static final String UPDATED_NAME = "NAME2";

	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";

	private static final String DEFAULT_CODE = "CODE1";

	private static final String UPDATED_CODE = "CODE2";

	private static final Integer DEFAULT_AVAILABLE = CommonConstants.YES;

	private static final Integer UPDATED_AVAILABLE = CommonConstants.NO;

	private static final DataScopeType DEFAULT_DATASCOPE = DataScopeType.ALL;

	private static final DataScopeType UPDATED_DATASCOPE = DataScopeType.CUSTOMIZE;

	private static final Integer DEFAULT_LEVEL = 1;

	private static final Integer UPDATED_LEVEL = 2;

	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";

	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";

	private String DEFAULT_API_URL;

	@Autowired
	private RoleService roleService;

	@Autowired
	private UserService userService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private DeptService deptService;

	@Autowired
	private RoleMenuService roleMenuService;

	@Autowired
	private RoleDeptService roleDeptService;

	private MockMvc restRoleMockMvc;

	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;

	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	@Autowired
	private ApplicationProperties applicationProperties;

	private RoleDto roleDto;

	private RoleDto anotherRole = new RoleDto();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/role/");
		MockitoAnnotations.openMocks(this);
		final RoleResource roleResource = new RoleResource(roleService, roleMenuService, userService);
		this.restRoleMockMvc = MockMvcBuilders.standaloneSetup(roleResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler).setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();
	}

	/**
	 * Create a Role.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an domain which has a required relationship to the Role domain.
	 */
	public RoleDto createDto() {
		RoleDto roleDto = new RoleDto();
		roleDto.setName(DEFAULT_NAME);
		roleDto.setDataScope(DEFAULT_DATASCOPE);
		roleDto.setCode(DEFAULT_CODE);
		roleDto.setLevel(DEFAULT_LEVEL);
		roleDto.setDescription(DEFAULT_DESCRIPTION);
		return roleDto;
	}

	@BeforeEach
	public void initTest() {
		roleDto = createDto();
		// Initialize the database
		List<MenuDo> allMenuEntityDos = menuService.list();
		List<DeptDo> allDeptDo = deptService.list();
		anotherRole.setName(DEFAULT_ANOTHER_NAME);
		anotherRole.setDataScope(DEFAULT_DATASCOPE);
		anotherRole.setLevel(DEFAULT_LEVEL);
		anotherRole.setDescription(DEFAULT_DESCRIPTION);
		anotherRole.setMenuIdList(CollUtil.extractToList(allMenuEntityDos, MenuDo.F_ID));
		anotherRole.setDeptIdList(CollUtil.extractToList(allDeptDo, MenuDo.F_ID));
		roleService.saveOrUpdate(anotherRole);
		roleDto.setMenuIdList(anotherRole.getMenuIdList());
		roleDto.setDeptIdList(anotherRole.getDeptIdList());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createRole() throws Exception {
		List<RoleDo> databaseSizeBeforeCreate = roleService.list();

		// Create the Role
		restRoleMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(roleDto))).andExpect(status().isOk());

		// Validate the Role in the database
		List<RoleDo> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeCreate.size() + 1);
		RoleDo testRoleDo = roleService.getOne(Wrappers.<RoleDo>query().lambda().eq(RoleDo::getName, roleDto.getName()));
		assertThat(testRoleDo.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testRoleDo.getLevel()).isEqualTo(DEFAULT_LEVEL);
		assertThat(testRoleDo.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testRoleDo.getDelFlag()).isEqualTo(RoleDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getRolePage() throws Exception {
		// Initialize the database
		roleService.saveOrUpdate(roleDto);
		// Get all the roles
		restRoleMockMvc
			.perform(get(DEFAULT_API_URL).param(PageModel.F_DESC, RoleDo.F_SQL_CREATED_DATE)
				.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
			.andExpect(jsonPath("$.data.records.[*].level").value(hasItem(DEFAULT_LEVEL)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getRole() throws Exception {
		// Initialize the database
		roleService.saveOrUpdate(roleDto);

		// Get the role
		restRoleMockMvc.perform(get(DEFAULT_API_URL + "{id}", roleDto.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.code").value(DEFAULT_CODE))
			.andExpect(jsonPath("$.data.level").value(DEFAULT_LEVEL))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingRole() throws Exception {
		restRoleMockMvc.perform(get("/sys/role/ddd/unknown")).andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateRole() throws Exception {
		// Initialize the database
		roleService.saveOrUpdate(roleDto);
		int databaseSizeBeforeUpdate = roleService.list().size();

		// Update the role
		RoleDo updatedRoleDo = roleService.getById(roleDto.getId());

		RoleDto managedRoleVM = new RoleDto();
		managedRoleVM.setName(UPDATED_NAME);
		managedRoleVM.setLevel(UPDATED_LEVEL);
		managedRoleVM.setCode(UPDATED_CODE);
		managedRoleVM.setDataScope(UPDATED_DATASCOPE);
		managedRoleVM.setDescription(UPDATED_DESCRIPTION);
		managedRoleVM.setMenuIdList(Lists.newArrayList(anotherRole.getMenuIdList().get(0)));
		managedRoleVM.setDeptIdList(Lists.newArrayList(anotherRole.getDeptIdList().get(0)));
		managedRoleVM.setId(updatedRoleDo.getId());
		restRoleMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedRoleVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Role in the database
		List<RoleDo> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeUpdate);
		RoleDo testRoleDo = roleService.getById(updatedRoleDo.getId());
		List<RoleMenuDo> listRoleMenuDoEntities = roleMenuService
			.list(Wrappers.<RoleMenuDo>query().lambda().eq(RoleMenuDo::getRoleId, testRoleDo.getId()));
		assertThat(listRoleMenuDoEntities.size()).isEqualTo(1);
		assertThat(listRoleMenuDoEntities.get(0).getMenuId()).isEqualTo(anotherRole.getMenuIdList().get(0));
		List<RoleDeptDo> listRoleDeptDo = roleDeptService
			.list(Wrappers.<RoleDeptDo>query().lambda().eq(RoleDeptDo::getRoleId, testRoleDo.getId()));
		assertThat(listRoleDeptDo.size()).isEqualTo(1);
		assertThat(listRoleDeptDo.get(0).getDeptId()).isEqualTo(anotherRole.getDeptIdList().get(0));
		assertThat(testRoleDo.getName()).isEqualTo(UPDATED_NAME);
		// assertThat(testRole.getParentIds()).contains(UPDATED_PARENT_ID);
		assertThat(testRoleDo.getLevel()).isEqualTo(UPDATED_LEVEL);
		assertThat(testRoleDo.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testRoleDo.getDelFlag()).isEqualTo(RoleDo.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteRole() throws Exception {
		// Initialize the database
		roleService.saveOrUpdate(roleDto);
		long databaseSizeBeforeDelete = roleService.count();
		// Delete the role
		restRoleMockMvc.perform(delete(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(roleDto.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = roleService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testRoleEquals() throws Exception {
		TestUtil.equalsVerifier(RoleDo.class);
		RoleDo roleDo1 = new RoleDo();
		roleDo1.setId(1L);
		roleDo1.setName("Role1");
		RoleDo roleDo2 = new RoleDo();
		roleDo2.setId(roleDo1.getId());
		roleDo2.setName(roleDo1.getName());
		assertThat(roleDo1).isEqualTo(roleDo2);
		roleDo2.setId(2L);
		roleDo2.setName("Role2");
		assertThat(roleDo1).isNotEqualTo(roleDo2);
		roleDo1.setId(null);
		assertThat(roleDo1).isNotEqualTo(roleDo2);
	}
	//@Test
	//public void doExport() throws FileNotFoundException {
	//	String homePath = System.getProperty("user.dir");
	//	String filePath = File.separator + "src" + File.separator + "main" +
	//		File.separator + "resources" + File.separator;
	//	//String path =  homePath+filePath+"4.xlsx";
	//	//write(path);
	//	List<UserVo> userVoList = Lists.newArrayList(UserVo.builder().username("username").build());
	//
	//	ExcelUtil excelUtil = new ExcelUtil( UserVo.class);
	//	excelUtil.init(userVoList, "test", ExcelField.Type.EXPORT);
	//	excelUtil.exportExcel(new FileOutputStream(homePath+filePath+"5.xlsx"));
	//}
}
