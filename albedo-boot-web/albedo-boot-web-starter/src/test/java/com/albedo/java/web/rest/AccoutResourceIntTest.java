package com.albedo.java.web.rest;

import com.albedo.java.AlbedoBootWebApp;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.security.AuthoritiesConstants;
import com.albedo.java.common.security.MailService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.web.AccoutResource;
import com.albedo.java.modules.sys.web.UserResource;
import com.albedo.java.vo.base.LoginVo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

import static org.mockito.Matchers.anyObject;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the AccountResource REST controller.
 *
 * @see UserResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = AlbedoBootWebApp.class)
public class AccoutResourceIntTest {

    @Autowired
    private HttpMessageConverter[] httpMessageConverters;

    @Mock
    private UserService mockUserService;

    @Mock
    private MailService mockMailService;

    private MockMvc restUserMockMvc;

    private MockMvc restMvc;

    @Mock
    private AlbedoProperties albedoProperties;
    @Autowired
    private TokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private MockMvc mockMvc;



    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        doNothing().when(mockMailService).sendActivationEmail(anyObject());

        AccoutResource accountResource =
            new AccoutResource(tokenProvider, authenticationManager);

        AccoutResource accountUserMockResource =
                new AccoutResource(tokenProvider, authenticationManager);

        this.restMvc = MockMvcBuilders.standaloneSetup(accountResource)
            .setMessageConverters(httpMessageConverters)
            .build();
        this.restUserMockMvc = MockMvcBuilders.standaloneSetup(accountUserMockResource).build();

    }

    @Test
    public void testNonAuthenticatedUser() throws Exception {
        restUserMockMvc.perform(get("/api/authenticate")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(content().string(""));
    }

    @Test
    public void testAuthenticatedUser() throws Exception {
        restUserMockMvc.perform(get("/api/authenticate")
            .with(request -> {
                request.setRemoteUser("test");
                return request;
            })
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(content().string("test"));
    }

    @Test
    public void testGetExistingAccount() throws Exception {
        Set<Role> authorities = new HashSet<>();
        Role authority = new Role();
        authority.setName(AuthoritiesConstants.ADMIN);
        authorities.add(authority);

        User user = new User();
        user.setLoginId("test");
        user.setName("john");
        user.setEmail("john.doe@jhipster.com");
        user.setLangKey("en");
        user.setRoles(authorities);
        when(mockUserService.getUserWithAuthorities(SecurityUtil.getCurrentUserId())).
                thenReturn(mockUserService.copyBeanToVo(user));

        restUserMockMvc.perform(get("/api/account")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.loginId").value("test"))
            .andExpect(jsonPath("$.name").value("john"))
            .andExpect(jsonPath("$.email").value("john.doe@jhipster.com"))
            .andExpect(jsonPath("$.langKey").value("en"))
            .andExpect(jsonPath("$.roles").value(AuthoritiesConstants.ADMIN));
    }

    @Test
    public void testGetUnknownAccount() throws Exception {
        when(mockUserService.getUserWithAuthorities(SecurityUtil.getCurrentUserId())).thenReturn(null);

        restUserMockMvc.perform(get("/api/account")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isInternalServerError());
    }

    @Test
    @Transactional
    public void testAuthorize() throws Exception {
        User user = new User();
        user.setLoginId("user-jwt-controller");
        user.setEmail("user-jwt-controller@example.com");
        user.setActivated(true);
        user.setPassword(passwordEncoder.encode("test"));

        userRepository.saveAndFlush(user);

        LoginVo login = new LoginVo();
        login.setUsername("user-jwt-controller");
        login.setPassword("test");
        mockMvc.perform(post("/api/authenticate")
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(login)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id_token").isString())
                .andExpect(jsonPath("$.id_token").isNotEmpty());
    }

    @Test
    @Transactional
    public void testAuthorizeWithRememberMe() throws Exception {
        User user = new User();
        user.setLoginId("user-jwt-controller-remember-me");
        user.setEmail("user-jwt-controller-remember-me@example.com");
        user.setActivated(true);
        user.setPassword(passwordEncoder.encode("test"));

        userRepository.saveAndFlush(user);

        LoginVo login = new LoginVo();
        login.setUsername("user-jwt-controller-remember-me");
        login.setPassword("test");
        login.setRememberMe(true);
        mockMvc.perform(post("/api/authenticate")
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(login)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id_token").isString())
                .andExpect(jsonPath("$.id_token").isNotEmpty());
    }

    @Test
    @Transactional
    public void testAuthorizeFails() throws Exception {
        LoginVo login = new LoginVo();
        login.setUsername("wrong-user");
        login.setPassword("wrong password");
        mockMvc.perform(post("/api/authenticate")
                .contentType(TestUtil.APPLICATION_JSON_UTF8)
                .content(TestUtil.convertObjectToJsonBytes(login)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.id_token").doesNotExist());
    }

}
