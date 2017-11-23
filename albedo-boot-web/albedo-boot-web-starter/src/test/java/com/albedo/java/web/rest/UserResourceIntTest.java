package com.albedo.java.web.rest;

import com.albedo.java.AlbedoBootWebApp;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.security.MailService;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.OrgService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.web.UserResource;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.UserVo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import javax.persistence.EntityManager;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.containsInAnyOrder;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Test class for the UserResource REST controller.
 *
 * @see UserResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = AlbedoBootWebApp.class)
public class UserResourceIntTest {

    private static final Long DEFAULT_ID = 1L;

    private static final String DEFAULT_ANOTHER_LOGIN = "johndoeddd";
    private static final String DEFAULT_LOGIN = "johndoe";
    private static final String UPDATED_LOGIN = "jhipster";

    private static final String DEFAULT_PASSWORD = "passjohndoe";
    private static final String UPDATED_PASSWORD = "passjhipster";

    private static final String DEFAULT_PHONE = "13258812456";
    private static final String UPDATED_PHONE = "13222222222";

    private static final String DEFAULT_ANOTHER_EMAIL = "23423432@localhost";
    private static final String DEFAULT_EMAIL = "johndoe@localhost";
    private static final String UPDATED_EMAIL = "jhipster@localhost";


    private static final String DEFAULT_NAME = "doe";
    private static final String UPDATED_NAME = "jhipsterLastName";

    private static final String DEFAULT_IMAGEURL = "http://placehold.it/50x50";
    private static final String UPDATED_IMAGEURL = "http://placehold.it/40x40";

    private static final String DEFAULT_LANGKEY = "en";
    private static final String UPDATED_LANGKEY = "fr";

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailService mailService;

    @Autowired
    private UserService userService;
    @Autowired
    private OrgService orgService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AlbedoProperties albedoProperties;
    

    @Autowired
    private EntityManager em;

    private MockMvc restUserMockMvc;

    private User user;
    List<Org> orgs;
    List<Role> roles;
    @Autowired
    protected WebApplicationContext webApplicationContext;
    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        this.restUserMockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
            .build();
    }

    /**
     * Create a User.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which has a required relationship to the User entity.
     */
    public User createEntity() {
        User user = new User();
        user.setLoginId(DEFAULT_LOGIN);
        user.setPassword(PublicUtil.getRandomString(60));
        user.setActivated(true);
        user.setEmail(DEFAULT_EMAIL);
        user.setPhone(DEFAULT_PHONE);
        user.setName(DEFAULT_NAME);
        user.setLangKey(DEFAULT_LANGKEY);
        user.setOrgId(orgs.get(0).getId());
        user.setRoleIdList(Collections3.extractToList(roles, Role.F_ID));
        return user;
    }

    @Before
    public void initTest() {
        orgs = orgService.findAll();
        roles = roleService.findAll();
        user = createEntity();
        // Initialize the database

        User anotherUser = new User();
        anotherUser.setLoginId(DEFAULT_ANOTHER_LOGIN);
        anotherUser.setPassword(PublicUtil.getRandomString(60));
        anotherUser.setActivated(true);
        anotherUser.setEmail(DEFAULT_ANOTHER_EMAIL);
        anotherUser.setName("java");
        anotherUser.setLangKey("en");
        userRepository.saveAndFlush(anotherUser);
    }

    @Test
    @Transactional
    public void createUser() throws Exception {
        int databaseSizeBeforeCreate = userRepository.findAll().size();

        // Create the User
        UserVo managedUserVM = new UserVo(null,
                DEFAULT_LOGIN,
                DEFAULT_PASSWORD,
                DEFAULT_PASSWORD,
                orgs.get(0).getId(),
                DEFAULT_NAME,
                DEFAULT_PHONE,
                DEFAULT_EMAIL,
                true,
                DEFAULT_LANGKEY,
                null,
                null,
                null,
                Collections3.extractToList(roles, Role.F_ID),
                null,
                null);

        restUserMockMvc.perform(post(albedoProperties.getAdminPath("/sys/user/edit"))
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
            .andExpect(status().isOk());

        // Validate the User in the database
        List<User> userList = userRepository.findAll();
        assertThat(userList).hasSize(databaseSizeBeforeCreate + 1);
        User testUser = userRepository.findOneByLoginId(managedUserVM.getLoginId()).get();
        assertThat(testUser.getLoginId()).isEqualTo(DEFAULT_LOGIN);
        assertThat(testUser.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testUser.getEmail()).isEqualTo(DEFAULT_EMAIL);
        assertThat(testUser.getLangKey()).isEqualTo(DEFAULT_LANGKEY);
    }

    @Test
    @Transactional
    public void createUserWithExistingLogin() throws Exception {
        int databaseSizeBeforeCreate = userRepository.findAll().size();

        // Create the User
        UserVo managedUserVM = new UserVo(null,
                DEFAULT_ANOTHER_LOGIN,
                DEFAULT_PASSWORD,
                DEFAULT_PASSWORD,
                orgs.get(0).getId(),
                DEFAULT_NAME,
                DEFAULT_PHONE,
                DEFAULT_EMAIL,
                true,
                DEFAULT_LANGKEY,
                null,
                null,
                null,
                Collections3.extractToList(roles, Role.F_ID),
                null,
                null);

        // Create the User
        restUserMockMvc.perform(post(albedoProperties.getAdminPath("/sys/user/edit"))
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(Globals.MSG_TYPE_WARNING))
                .andExpect(jsonPath("$.message").isNotEmpty());

        // Validate the User in the database
        List<User> userList = userRepository.findAll();
        assertThat(userList).hasSize(databaseSizeBeforeCreate);
    }

    @Test
    @Transactional
    public void getAllUsers() throws Exception {
        // Initialize the database
        userRepository.saveAndFlush(user);
        // Get all the users
        restUserMockMvc.perform(get(albedoProperties.getAdminPath("/sys/user/page"))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.data.[*].loginId").value(hasItem(DEFAULT_LOGIN)))
                .andExpect(jsonPath("$.data.[*].name").value(hasItem(DEFAULT_NAME)))
                .andExpect(jsonPath("$.data.[*].phone").value(hasItem(DEFAULT_PHONE)))
                .andExpect(jsonPath("$.data.[*].email").value(hasItem(DEFAULT_EMAIL)))
                .andExpect(jsonPath("$.data.[*].langKey").value(hasItem(DEFAULT_LANGKEY)));
    }

    @Test
    @Transactional
    public void getUser() throws Exception {
        // Initialize the database
        userRepository.saveAndFlush(user);

        // Get the user
        restUserMockMvc.perform(get(albedoProperties.getAdminPath("/sys/user/{login}"), user.getId()))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.data.loginId").value(user.getLoginId()))
                .andExpect(jsonPath("$.data.name").value(DEFAULT_NAME))
                .andExpect(jsonPath("$.data.phone").value(DEFAULT_PHONE))
                .andExpect(jsonPath("$.data.email").value(DEFAULT_EMAIL))
                .andExpect(jsonPath("$.data.langKey").value(DEFAULT_LANGKEY));
    }

    @Test
    @Transactional
    public void getNonExistingUser() throws Exception {
        restUserMockMvc.perform(get(albedoProperties.getAdminPath("/sys/user/ddd/unknown")))
                .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateUser() throws Exception {
        // Initialize the database
        userRepository.saveAndFlush(user);
        int databaseSizeBeforeUpdate = userRepository.findAll().size();

        // Update the user
        User updatedUser = userRepository.findOne(user.getId());

        UserVo managedUserVM = new UserVo(updatedUser.getId(),
                UPDATED_LOGIN,
                UPDATED_PASSWORD,
                UPDATED_PASSWORD,
                orgs.get(0).getId(),
                UPDATED_NAME,
                UPDATED_PHONE,
                UPDATED_EMAIL,
                true,
                UPDATED_LANGKEY,
                null,
                null,
                null,
                Collections3.extractToList(roles, Role.F_ID),
                null,
                null);

        restUserMockMvc.perform(post(albedoProperties.getAdminPath("/sys/user/edit"))
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(Globals.MSG_TYPE_SUCCESS));

        // Validate the User in the database
        List<User> userList = userRepository.findAll();
        assertThat(userList).hasSize(databaseSizeBeforeUpdate);
        User testUser = userRepository.findOne(updatedUser.getId());
        assertThat(testUser.getLoginId()).isEqualTo(UPDATED_LOGIN);
        assertThat(testUser.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testUser.getEmail()).isEqualTo(UPDATED_EMAIL);
        assertThat(testUser.getPhone()).isEqualTo(UPDATED_PHONE);
        assertThat(testUser.getLangKey()).isEqualTo(UPDATED_LANGKEY);
    }


    @Test
    @Transactional
    public void updateUserExistingEmail() throws Exception {

        userRepository.save(user);
        // Update the user
        User updatedUser = userRepository.findOne(user.getId());


        UserVo managedUserVM = new UserVo(updatedUser.getId(),
                UPDATED_LOGIN,
                UPDATED_PASSWORD,
                UPDATED_PASSWORD,
                orgs.get(0).getId(),
                UPDATED_NAME,
                UPDATED_PHONE,
                DEFAULT_ANOTHER_EMAIL,
                true,
                UPDATED_LANGKEY,
                null,
                null,
                null,
                Collections3.extractToList(roles, Role.F_ID),
                null,
                null);

        restUserMockMvc.perform(post(albedoProperties.getAdminPath("/sys/user/edit"))
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(Globals.MSG_TYPE_WARNING))
                .andExpect(jsonPath("$.message").isNotEmpty());

    }

    @Test
    @Transactional
    public void updateUserExistingLogin() throws Exception {

        userRepository.save(user);
        // Update the user
        User updatedUser = userRepository.findOne(user.getId());

        UserVo managedUserVM = new UserVo(updatedUser.getId(),
                DEFAULT_ANOTHER_LOGIN,
                UPDATED_PASSWORD,
                UPDATED_PASSWORD,
                orgs.get(0).getId(),
                UPDATED_NAME,
                UPDATED_PHONE,
                UPDATED_EMAIL,
                true,
                UPDATED_LANGKEY,
                null,
                null,
                null,
                Collections3.extractToList(roles, Role.F_ID),
                null,null
                );
        restUserMockMvc.perform(post(albedoProperties.getAdminPath("/sys/user/edit"))
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(Globals.MSG_TYPE_WARNING))
                .andExpect(jsonPath("$.message").isNotEmpty());
    }

    @Test
    @Transactional
    public void deleteUser() throws Exception {
        // Initialize the database
        userRepository.saveAndFlush(user);
        SpecificationDetail<User> spec = DynamicSpecifications.bySearchQueryCondition(
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
        long databaseSizeBeforeDelete = userRepository.count(spec);

        // Delete the user
        restUserMockMvc.perform(delete(albedoProperties.getAdminPath("/sys/user/delete/{login}"), user.getId())
                .accept(TestUtil.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());

        // Validate the database is empty
        long databaseSizeAfterDelete = userRepository.count(spec);
        assertThat(databaseSizeAfterDelete == databaseSizeBeforeDelete - 1);
    }

    @Test
    @Transactional
    public void getAllAuthorities() throws Exception {
        restUserMockMvc.perform(get(albedoProperties.getAdminPath("/sys/user/authorities"))
                .accept(TestUtil.APPLICATION_JSON_UTF8)
                .contentType(TestUtil.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
                .andExpect(jsonPath("$.data").isArray());
    }

    @Test
    @Transactional
    public void testUserEquals() throws Exception {
        TestUtil.equalsVerifier(User.class);
        User user1 = new User();
        user1.setId("1");
        user1.setLoginId("Login1");
        User user2 = new User();
        user2.setId(user1.getId());
        user2.setLoginId(user1.getLoginId());
        assertThat(user1).isEqualTo(user2);
        user2.setId("2");
        user2.setLoginId("Login2");
        assertThat(user1).isNotEqualTo(user2);
        user1.setId(null);
        assertThat(user1).isNotEqualTo(user2);
    }

}
