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
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.AlbedoAdminApplication;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
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
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the UserResource REST web.
 *
 * @see com.albedo.java.modules.sys.web.UserResource
 */
@SpringBootTest(classes = {AlbedoAdminApplication.class})
@WithMockUser(username = "admin")
@Slf4j
public class UserResourceIntTest {

	private static final String DEFAULT_ANOTHER_USERNAME = "johndoeddd";

	private static final String DEFAULT_USERNAME = "johndoe";

	private static final String UPDATED_USERNAME = "jhipster";

	private static final String DEFAULT_PASSWORD = "passjohndoe";

	private static final String UPDATED_PASSWORD = "passjhipster";

	private static final String DEFAULT_PHONE = "13258812456";

	private static final String UPDATED_PHONE = "13222222222";

	private static final String DEFAULT_ANOTHER_PHONE = "13222221111";

	private static final String DEFAULT_ANOTHER_EMAIL = "23423432@localhost";

	private static final String DEFAULT_EMAIL = "johndoe@localhost";

	private static final String UPDATED_EMAIL = "jhipster@localhost";

	private static final String DEFAULT_QQOPENID = "QQOPENID1";

	private static final String UPDATED_QQOPENID = "QQOPENID2";

	private static final Integer DEFAULT_AVAILABLE = CommonConstants.YES;

	private static final Integer UPDATED_AVAILABLE = CommonConstants.NO;

	UserDto anotherUser = new UserDto();

	private String DEFAULT_API_URL;

	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private DeptService deptService;

	private MockMvc restUserMockMvc;

	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;

	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	@Autowired
	private ApplicationProperties applicationProperties;

	private UserDto user;

	private List<Role> roleList;

	private List<Dept> deptList;

	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/user/");
		MockitoAnnotations.openMocks(this);
		final UserResource userResource = new UserResource(userService);
		this.restUserMockMvc = MockMvcBuilders.standaloneSetup(userResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler).setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();

	}

	/**
	 * Create a User.
	 * <p>
	 * This is a static method, as tests for other entities might also need it, if they
	 * test an domain which has a required relationship to the User domain.
	 */
	public UserDto createEntity() {
		UserDto user = new UserDto();
		user.setUsername(DEFAULT_USERNAME);
		user.setPassword(DEFAULT_PASSWORD);
		user.setEmail(DEFAULT_EMAIL);
		user.setPhone(DEFAULT_PHONE);
		user.setQqOpenId(DEFAULT_QQOPENID);
		user.setDeptId(deptList.get(0).getId());
		user.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
		return user;
	}

	@BeforeEach
	public void initTest() {
		deptList = deptService.list();
		roleList = roleService.list();
		user = createEntity();
		// Initialize the database

		anotherUser.setUsername(DEFAULT_ANOTHER_USERNAME);
		anotherUser.setPassword(DEFAULT_PASSWORD);
		anotherUser.setEmail(DEFAULT_ANOTHER_EMAIL);
		anotherUser.setPhone(DEFAULT_ANOTHER_PHONE);
		anotherUser.setDeptId(deptList.get(0).getId());
		anotherUser.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));
		userService.saveOrUpdate(anotherUser);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createUser() throws Exception {
		List<User> databaseSizeBeforeCreate = userService.list();

		// Create the User
		restUserMockMvc.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(user))).andExpect(status().isOk());

		// Validate the User in the database
		List<User> userList = userService.list();
		assertThat(userList).hasSize(databaseSizeBeforeCreate.size() + 1);
		User testUser = userService.getOne(Wrappers.<User>query().lambda().eq(User::getUsername, user.getUsername()));
		assertThat(testUser.getUsername()).isEqualTo(DEFAULT_USERNAME);
		assertThat(testUser.getPhone()).isEqualTo(DEFAULT_PHONE);
		assertThat(testUser.getEmail()).isEqualTo(DEFAULT_EMAIL);
		assertThat(testUser.getQqOpenId()).isEqualTo(DEFAULT_QQOPENID);
		assertThat(testUser.getDelFlag()).isEqualTo(User.FLAG_NORMAL);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void createUserWithExistingEmail() throws Exception {
		// Initialize the database
		int databaseSizeBeforeCreate = userService.list().size();

		// Create the User
		UserDto managedUserVM = createEntity();
		managedUserVM.setEmail(DEFAULT_ANOTHER_EMAIL);
		// Create the User
		restUserMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest()).andExpect(jsonPath("$.code").value(ResponseCode.FAIL.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());

		// Validate the User in the database
		List<User> userList = userService.list();
		assertThat(userList).hasSize(databaseSizeBeforeCreate);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void findPage() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		// Get all the users
		restUserMockMvc
			.perform(get(DEFAULT_API_URL).param(PageModel.F_DESC, User.F_SQL_CREATED_DATE)
				.accept(MediaType.APPLICATION_JSON))
			.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.records.[*].username").value(hasItem(DEFAULT_USERNAME)))
			.andExpect(jsonPath("$.data.records.[*].qqOpenId").value(hasItem(DEFAULT_QQOPENID)))
			.andExpect(jsonPath("$.data.records.[*].phone").value(hasItem(DEFAULT_PHONE)))
			.andExpect(jsonPath("$.data.records.[*].email").value(hasItem(DEFAULT_EMAIL)));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// Get the user
		restUserMockMvc.perform(get(DEFAULT_API_URL + "{id}", user.getId())).andExpect(status().isOk())
			.andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.username").value(user.getUsername()))
			.andExpect(jsonPath("$.data.qqOpenId").value(DEFAULT_QQOPENID))
			.andExpect(jsonPath("$.data.phone").value(DEFAULT_PHONE))
			.andExpect(jsonPath("$.data.email").value(DEFAULT_EMAIL));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getInfo() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// Get the user
		restUserMockMvc.perform(get(DEFAULT_API_URL + "/info/{username}", user.getUsername()))
			.andExpect(status().isOk()).andExpect(content().contentType(MediaType.APPLICATION_JSON_VALUE))
			.andExpect(jsonPath("$.data.user.username").value(user.getUsername()))
			.andExpect(jsonPath("$.data.user.qqOpenId").value(DEFAULT_QQOPENID))
			.andExpect(jsonPath("$.data.roles").value(equalTo(CollUtil.extractToList(roleList, Role.F_ID))))
			.andExpect(jsonPath("$.data.permissions").isNotEmpty());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void getNonExistingUser() throws Exception {
		restUserMockMvc.perform(get("/sys/user/ddd/unknown")).andExpect(status().isNotFound());
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		int databaseSizeBeforeUpdate = userService.list().size();

		// Update the user
		User updatedUser = userService.getById(user.getId());

		UserDto managedUserVM = new UserDto();
		managedUserVM.setUsername(UPDATED_USERNAME);
		managedUserVM.setPassword(UPDATED_PASSWORD);
		managedUserVM.setEmail(UPDATED_EMAIL);
		managedUserVM.setPhone(UPDATED_PHONE);
		managedUserVM.setQqOpenId(UPDATED_QQOPENID);
		managedUserVM.setQqOpenId(UPDATED_QQOPENID);
		managedUserVM.setRoleIdList(CollUtil.extractToList(roleList, Role.F_ID));

		managedUserVM.setId(updatedUser.getId());
		restUserMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isOk()).andExpect(jsonPath("$.code").value(CommonConstants.SUCCESS));

		// Validate the User in the database
		List<User> userList = userService.list();
		assertThat(userList).hasSize(databaseSizeBeforeUpdate);
		User testUser = userService.getById(updatedUser.getId());
		assertThat(testUser.getUsername()).isEqualTo(UPDATED_USERNAME);
		assertThat(testUser.getEmail()).isEqualTo(UPDATED_EMAIL);
		assertThat(testUser.getPhone()).isEqualTo(UPDATED_PHONE);
		assertThat(testUser.getQqOpenId()).isEqualTo(UPDATED_QQOPENID);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUserExistingEmail() throws Exception {

		userService.saveOrUpdate(user);
		// Update the user
		User updatedUser = userService.getById(user.getId());

		UserDto managedUserVM = new UserDto();
		managedUserVM.setEmail(DEFAULT_ANOTHER_EMAIL);
		managedUserVM.setId(updatedUser.getId());
		restUserMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest()).andExpect(jsonPath("$.code").value(ResponseCode.FAIL.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());
		User testUser = userService.getById(updatedUser.getId());
		assertThat(testUser.getEmail()).isEqualTo(DEFAULT_EMAIL);

	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void updateUserExistingUsername() throws Exception {

		userService.saveOrUpdate(user);
		// Update the user
		User updatedUser = userService.getById(user.getId());

		UserDto managedUserVM = new UserDto();
		managedUserVM.setUsername(DEFAULT_ANOTHER_USERNAME);
		managedUserVM.setId(updatedUser.getId());
		restUserMockMvc
			.perform(post(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
				.content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
			.andExpect(status().isBadRequest()).andExpect(jsonPath("$.code").value(ResponseCode.FAIL.getCode()))
			.andExpect(jsonPath("$.message").isNotEmpty());
		User testUser = userService.getById(updatedUser.getId());
		assertThat(testUser.getUsername()).isEqualTo(DEFAULT_USERNAME);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void deleteUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);
		long databaseSizeBeforeDelete = userService.count();

		// Delete the user
		restUserMockMvc.perform(delete(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		long databaseSizeAfterDelete = userService.count();
		assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void lockOrUnLockUser() throws Exception {
		// Initialize the database
		userService.saveOrUpdate(user);

		// lockOrUnLock the user
		restUserMockMvc.perform(put(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		User tempUser = userService.getById(user.getId());
		assertThat(CommonConstants.STR_YES.equals(tempUser.getAvailable()));
		// lockOrUnLock the user
		restUserMockMvc.perform(put(DEFAULT_API_URL).contentType(TestUtil.APPLICATION_JSON_UTF8)
			.content(TestUtil.convertObjectToJsonBytes(Lists.newArrayList(user.getId())))
			.accept(TestUtil.APPLICATION_JSON_UTF8)).andExpect(status().isOk());

		// Validate the database is empty
		User tempUser1 = userService.getById(user.getId());
		assertThat(CommonConstants.STR_NO.equals(tempUser1.getAvailable()));
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void testUserEquals() throws Exception {
		TestUtil.equalsVerifier(User.class);
		User user1 = new User();
		user1.setId("1");
		user1.setUsername("User1");
		User user2 = new User();
		user2.setId(user1.getId());
		user2.setUsername(user1.getUsername());
		assertThat(user1).isEqualTo(user2);
		user2.setId("2");
		user2.setUsername("User2");
		assertThat(user1).isNotEqualTo(user2);
		user1.setId(null);
		assertThat(user1).isNotEqualTo(user2);
	}

}
