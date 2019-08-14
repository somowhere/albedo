package com.albedo.java.modules.sys.web;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.exception.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.*;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.vo.RoleDataVo;
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
@SpringBootTest(classes = AlbedoAdminApplication.class)
@Slf4j
public class RoleResourceIntTest {


	private String DEFAULT_API_URL;

	private static final String DEFAULT_ANOTHER_NAME = "ANOTHER_NAME";
	private static final String DEFAULT_NAME = "NAME1";
	private static final String UPDATED_NAME = "NAME2";
	private static final String DEFAULT_ANOTHER_CODE = "ANOTHER_CODE";
	private static final String DEFAULT_CODE = "CODE1";
	private static final String UPDATED_CODE = "CODE2";
	private static final String DEFAULT_AVAILABLE = CommonConstants.STR_YES;
	private static final String UPDATED_AVAILABLE = CommonConstants.STR_NO;
	private static final String DEFAULT_DATASCOPE = CommonConstants.STR_YES;
	private static final String UPDATED_DATASCOPE = CommonConstants.STR_NO;
	private static final String DEFAULT_REMARK = "REMARK1";
	private static final String UPDATED_REMARK = "REMARK2";
	private static final String DEFAULT_DESCRIPTION = "DESCRIPTION1";
	private static final String UPDATED_DESCRIPTION = "DESCRIPTION2";


	@Autowired
	private RoleService roleService;
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

	private RoleDataVo roleDataVo;

	private RoleDataVo anotherRole = new RoleDataVo();

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/role//");
		MockitoAnnotations.initMocks(this);
		final RoleResource roleResource = new RoleResource(roleService, roleMenuService);
		this.restRoleMockMvc = MockMvcBuilders.standaloneSetup(roleResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler)
			.setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter)
			.build();
	}

	/**
	 * Create a Role.
	 * <p>
	 * This is a static method, as tests for other entities might also need it,
	 * if they test an domain which has a required relationship to the Role domain.
	 */
	public RoleDataVo createEntity() {
		RoleDataVo roleDataVo = new RoleDataVo();
		roleDataVo.setName(DEFAULT_NAME);
		roleDataVo.setCode(DEFAULT_CODE);
		roleDataVo.setAvailable(DEFAULT_AVAILABLE);
		roleDataVo.setDataScope(DEFAULT_DATASCOPE);
		roleDataVo.setRemark(DEFAULT_REMARK);
		roleDataVo.setDescription(DEFAULT_DESCRIPTION);
		return roleDataVo;
	}

	@BeforeEach
	public void initTest() {
		roleDataVo = createEntity();
		// Initialize the database
		List<Menu> allMenuEntities = menuService.findAll();
		List<Dept> allDept = deptService.findAll();
		anotherRole.setName(DEFAULT_ANOTHER_NAME);
		anotherRole.setCode(DEFAULT_ANOTHER_CODE);
		anotherRole.setAvailable(DEFAULT_AVAILABLE);
		anotherRole.setDataScope(DEFAULT_DATASCOPE);
		anotherRole.setRemark(DEFAULT_REMARK);
		anotherRole.setDescription(DEFAULT_DESCRIPTION);
		anotherRole.setMenuIdList(CollUtil.extractToList(allMenuEntities, Menu.F_ID));
		anotherRole.setDeptIdList(CollUtil.extractToList(allDept, Menu.F_ID));
		roleService.save(anotherRole);
		roleDataVo.setMenuIdList(anotherRole.getMenuIdList());
		roleDataVo.setDeptIdList(anotherRole.getDeptIdList());
	}

	@Test
	@Transactional
	public void createRole() throws Exception {
		List<Role> databaseSizeBeforeCreate = roleService.list();

		// Create the Role
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(roleDataVo)))
			.andExpect(status().isOk());

		// Validate the Role in the database
		List<Role> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeCreate.size() + 1);
		Role testRole = roleService.findOne(Wrappers.<Role>query().lambda()
			.eq(Role::getName, roleDataVo.getName()));
		assertThat(testRole.getName()).isEqualTo(DEFAULT_NAME);
		assertThat(testRole.getCode()).isEqualTo(DEFAULT_CODE);
		assertThat(testRole.getRemark()).isEqualTo(DEFAULT_REMARK);
		assertThat(testRole.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
		assertThat(testRole.getDelFlag()).isEqualTo(Role.FLAG_NORMAL);
	}

	@Test
	@Transactional
	public void getRolePage() throws Exception {
		// Initialize the database
		roleService.save(roleDataVo);
		// Get all the roles
		restRoleMockMvc.perform(get(DEFAULT_API_URL)
			.param(PageModel.F_DESC, Role.F_SQL_CREATEDDATE)
			.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data.records.[*].name").value(hasItem(DEFAULT_NAME)))
			.andExpect(jsonPath("$.data.records.[*].code").value(hasItem(DEFAULT_CODE)))
			.andExpect(jsonPath("$.data.records.[*].remark").value(hasItem(DEFAULT_REMARK)))
			.andExpect(jsonPath("$.data.records.[*].description").value(hasItem(DEFAULT_DESCRIPTION)))
		;
	}

	@Test
	@Transactional
	public void getRole() throws Exception {
		// Initialize the database
		roleService.save(roleDataVo);

		// Get the role
		restRoleMockMvc.perform(get(DEFAULT_API_URL + "{id}", roleDataVo.getId()))
			.andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
			.andExpect(jsonPath("$.data.code").value(DEFAULT_CODE))
			.andExpect(jsonPath("$.data.remark").value(DEFAULT_REMARK))
			.andExpect(jsonPath("$.data.description").value(DEFAULT_DESCRIPTION));
	}

	@Test
	@Transactional
	public void getNonExistingRole() throws Exception {
		restRoleMockMvc.perform(get("/sys/role/ddd/unknown"))
			.andExpect(status().isNotFound());
	}

	@Test
	@Transactional
	public void updateRole() throws Exception {
		// Initialize the database
		roleService.save(roleDataVo);
		int databaseSizeBeforeUpdate = roleService.list().size();

		// Update the role
		Role updatedRole = roleService.findOneById(roleDataVo.getId());


		RoleDataVo managedRoleVM = new RoleDataVo();
		managedRoleVM.setName(UPDATED_NAME);
		managedRoleVM.setCode(UPDATED_CODE);
		managedRoleVM.setRemark(UPDATED_REMARK);
		managedRoleVM.setAvailable(UPDATED_AVAILABLE);
		managedRoleVM.setDataScope(UPDATED_DATASCOPE);
		managedRoleVM.setDescription(UPDATED_DESCRIPTION);
		managedRoleVM.setMenuIdList(Lists.newArrayList(anotherRole.getMenuIdList().get(0)));
		managedRoleVM.setDeptIdList(Lists.newArrayList(anotherRole.getDeptIdList().get(0)));
		managedRoleVM.setId(updatedRole.getId());
		restRoleMockMvc.perform(post(DEFAULT_API_URL)
			.contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(managedRoleVM)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the Role in the database
		List<Role> roleList = roleService.list();
		assertThat(roleList).hasSize(databaseSizeBeforeUpdate);
		Role testRole = roleService.findOneById(updatedRole.getId());
		List<RoleMenu> listRoleMenuEntities = roleMenuService.list(Wrappers.<RoleMenu>query().lambda()
			.eq(RoleMenu::getRoleId, testRole.getId()));
		assertThat(listRoleMenuEntities.size()).isEqualTo(1);
		assertThat(listRoleMenuEntities.get(0).getMenuId()).isEqualTo(anotherRole.getMenuIdList().get(0));
		List<RoleDept> listRoleDept = roleDeptService.list(Wrappers.<RoleDept>query().lambda()
			.eq(RoleDept::getRoleId, testRole.getId()));
		assertThat(listRoleDept.size()).isEqualTo(1);
		assertThat(listRoleDept.get(0).getDeptId()).isEqualTo(anotherRole.getDeptIdList().get(0));
		assertThat(testRole.getName()).isEqualTo(UPDATED_NAME);
		assertThat(testRole.getCode()).isEqualTo(UPDATED_CODE);
//		assertThat(testRole.getParentIds()).contains(UPDATED_PARENTID);
		assertThat(testRole.getRemark()).isEqualTo(UPDATED_REMARK);
		assertThat(testRole.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
		assertThat(testRole.getDelFlag()).isEqualTo(Role.FLAG_NORMAL);
	}

	@Test
	@Transactional
	public void deleteRole() throws Exception {
		// Initialize the database
		roleService.save(roleDataVo);
		long databaseSizeBeforeDelete = roleService.findCount();

		// Delete the role
		restRoleMockMvc.perform(delete(DEFAULT_API_URL + "{id}", roleDataVo.getId())
			.accept(TestUtil.APPLICATION_JSON_UTF8))
			.andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = roleService.findCount();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional
	public void testRoleEquals() throws Exception {
		TestUtil.equalsVerifier(Role.class);
		Role role1 = new Role();
		role1.setId("1");
		role1.setName("Role1");
		Role role2 = new Role();
		role2.setId(role1.getId());
		role2.setName(role1.getName());
		assertThat(role1).isEqualTo(role2);
		role2.setId("2");
		role2.setName("Role2");
		assertThat(role1).isNotEqualTo(role2);
		role1.setId(null);
		assertThat(role1).isNotEqualTo(role2);
	}

}
