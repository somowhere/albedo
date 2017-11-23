package com.albedo.java.web.rest;

import com.albedo.java.AlbedoBootWebApp;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.security.MailService;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.jwt.TokenProvider;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.web.UserResource;
import com.albedo.java.util.domain.Globals;
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
import org.springframework.web.context.WebApplicationContext;

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


    @Autowired
    protected WebApplicationContext webApplicationContext;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        doNothing().when(mockMailService).sendActivationEmail(anyObject());

//        AccoutResource accountResource =
//            new AccoutResource(tokenProvider, authenticationManager);
//
//        AccoutResource accountUserMockResource =
//                new AccoutResource(tokenProvider, authenticationManager);

        this.mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
//                .standaloneSetup(accountResource)
//            .setMessageConverters(httpMessageConverters)
            .build();

    }


    @Test
    public void testGetUnknownAccount() throws Exception {
        when(mockUserService.getUserWithAuthorities(SecurityUtil.getCurrentUserId())).thenReturn(null);

        mockMvc.perform(get("/api/account")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_500));
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
                .andExpect(jsonPath("$.data").isString())
                .andExpect(jsonPath("$.data").isNotEmpty());
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
                .andExpect(jsonPath("$.data").isString())
                .andExpect(jsonPath("$.data").isNotEmpty());
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
                .andExpect(jsonPath("$.data").doesNotExist());
    }

}
