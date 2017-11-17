//package com.albedo.java.web.rest;
//
//import com.albedo.java.AlbedoBootWebApp;
//import com.albedo.java.common.security.MailService;
//import com.albedo.java.modules.sys.domain.User;
//import com.albedo.java.modules.sys.repository.UserRepository;
//import com.albedo.java.modules.sys.service.UserService;
//import com.albedo.java.modules.sys.web.UserResource;
//import com.albedo.java.vo.sys.UserVo;
//import com.albedo.java.web.rest.errors.ExceptionTranslator;
//import org.apache.commons.lang3.RandomStringUtils;
//import org.junit.Before;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mockito.MockitoAnnotations;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
//import org.springframework.http.MediaType;
//import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.setup.MockMvcBuilders;
//import org.springframework.transaction.annotation.Transactional;
//
//import javax.persistence.EntityManager;
//import java.time.Instant;
//import java.util.Arrays;
//import java.util.HashSet;
//import java.util.List;
//import java.util.Set;
//import java.util.stream.Collectors;
//import java.util.stream.Stream;
//
//import static org.assertj.core.api.Assertions.assertThat;
//import static org.hamcrest.Matchers.hasItem;
//import static org.hamcrest.Matchers.containsInAnyOrder;
//import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
//
///**
// * Test class for the UserResource REST controller.
// *
// * @see UserResource
// */
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = AlbedoBootWebApp.class)
//public class UserResourceIntTest {
//
//    private static final Long DEFAULT_ID = 1L;
//
//    private static final String DEFAULT_LOGIN = "johndoe";
//    private static final String UPDATED_LOGIN = "jhipster";
//
//    private static final String DEFAULT_PASSWORD = "passjohndoe";
//    private static final String UPDATED_PASSWORD = "passjhipster";
//
//    private static final String DEFAULT_EMAIL = "johndoe@localhost";
//    private static final String UPDATED_EMAIL = "jhipster@localhost";
//
//    private static final String DEFAULT_FIRSTNAME = "john";
//    private static final String UPDATED_FIRSTNAME = "jhipsterFirstName";
//
//    private static final String DEFAULT_LASTNAME = "doe";
//    private static final String UPDATED_LASTNAME = "jhipsterLastName";
//
//    private static final String DEFAULT_IMAGEURL = "http://placehold.it/50x50";
//    private static final String UPDATED_IMAGEURL = "http://placehold.it/40x40";
//
//    private static final String DEFAULT_LANGKEY = "en";
//    private static final String UPDATED_LANGKEY = "fr";
//
//    @Autowired
//    private UserRepository userRepository;
//
//    @Autowired
//    private MailService mailService;
//
//    @Autowired
//    private UserService userService;
//
//    @Autowired
//    private MappingJackson2HttpMessageConverter jacksonMessageConverter;
//
//    @Autowired
//    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;
//
//    @Autowired
//    private ExceptionTranslator exceptionTranslator;
//
//    @Autowired
//    private EntityManager em;
//
//    private MockMvc restUserMockMvc;
//
//    private User user;
//
//    @Before
//    public void setup() {
//        MockitoAnnotations.initMocks(this);
//        UserResource userResource = new UserResource();
//        this.restUserMockMvc = MockMvcBuilders.standaloneSetup(userResource)
//            .setCustomArgumentResolvers(pageableArgumentResolver)
//            .setControllerAdvice(exceptionTranslator)
//            .setMessageConverters(jacksonMessageConverter)
//            .build();
//    }
//
//    /**
//     * Create a User.
//     *
//     * This is a static method, as tests for other entities might also need it,
//     * if they test an entity which has a required relationship to the User entity.
//     */
//    public static User createEntity(EntityManager em) {
//        User user = new User();
//        user.setLoginId(DEFAULT_LOGIN);
//        user.setPassword(RandomStringUtils.random(60));
//        user.setActivated(true);
//        user.setEmail(DEFAULT_EMAIL);
//        user.setName(DEFAULT_FIRSTNAME);
//        user.setLangKey(DEFAULT_LANGKEY);
//        return user;
//    }
//
//    @Before
//    public void initTest() {
//        user = createEntity(em);
//    }
//
//    @Test
//    @Transactional
//    public void createUser() throws Exception {
//        int databaseSizeBeforeCreate = userRepository.findAll().size();
//
//        // Create the User
//        Set<String> authorities = new HashSet<>();
//        authorities.add("ROLE_USER");
//        UserVo managedUserVM = new UserVo();
//
//        restUserMockMvc.perform(post("/api/users")
//            .contentType(TestUtil.APPLICATION_JSON_UTF8)
//            .content(TestUtil.convertObjectToJsonBytes(managedUserVM)))
//            .andExpect(status().isCreated());
//
//        // Validate the User in the database
//        List<User> userList = userRepository.findAll();
//        assertThat(userList).hasSize(databaseSizeBeforeCreate + 1);
//        User testUser = userList.get(userList.size() - 1);
//        assertThat(testUser.getLoginId()).isEqualTo(DEFAULT_LOGIN);
//        assertThat(testUser.getName()).isEqualTo(DEFAULT_FIRSTNAME);
//        assertThat(testUser.getEmail()).isEqualTo(DEFAULT_EMAIL);
//        assertThat(testUser.getLangKey()).isEqualTo(DEFAULT_LANGKEY);
//    }
//
//
//
//}
