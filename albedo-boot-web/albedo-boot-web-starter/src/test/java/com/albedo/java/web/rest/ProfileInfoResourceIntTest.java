package com.albedo.java.web.rest;

import com.albedo.java.AlbedoBootWebApp;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.modules.sys.web.ProfileInfoResource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Test class for the ProfileInfoResource REST controller.
 *
 * @see ProfileInfoResource
 **/
@RunWith(SpringRunner.class)
@SpringBootTest(classes = AlbedoBootWebApp.class)
public class ProfileInfoResourceIntTest {

    @Mock
    private Environment environment;

    @Mock
    private AlbedoProperties albedoProperties;

    private MockMvc restProfileMockMvc;

    @Autowired
    protected WebApplicationContext webApplicationContext;
    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        String mockProfile[] = {"test"};
        AlbedoProperties.Ribbon ribbon = new AlbedoProperties.Ribbon();
        ribbon.setDisplayOnActiveProfiles(mockProfile);
        when(albedoProperties.getRibbon()).thenReturn(ribbon);

        String activeProfiles[] = {"test"};
        when(environment.getDefaultProfiles()).thenReturn(activeProfiles);
        when(environment.getActiveProfiles()).thenReturn(activeProfiles);

//        ProfileInfoResource profileInfoResource = new ProfileInfoResource(environment, albedoProperties);
        this.restProfileMockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
            .build();
    }

    @Test
    public void getProfileInfoWithRibbon() throws Exception {
        restProfileMockMvc.perform(get("/api/profile-info"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE));
    }

    @Test
    public void getProfileInfoWithoutRibbon() throws Exception {
        AlbedoProperties.Ribbon ribbon = new AlbedoProperties.Ribbon();
        ribbon.setDisplayOnActiveProfiles(null);
        when(albedoProperties.getRibbon()).thenReturn(ribbon);

        restProfileMockMvc.perform(get("/api/profile-info"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE));
    }

    @Test
    public void getProfileInfoWithoutActiveProfiles() throws Exception {
        String emptyProfile[] = {};
        when(environment.getDefaultProfiles()).thenReturn(emptyProfile);
        when(environment.getActiveProfiles()).thenReturn(emptyProfile);

        restProfileMockMvc.perform(get("/api/profile-info"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE));
    }
}
