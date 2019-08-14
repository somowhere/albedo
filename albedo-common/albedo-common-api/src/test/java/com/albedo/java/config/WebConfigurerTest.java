package com.albedo.java.config;

import com.albedo.java.common.config.WebConfigurer;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.security.filter.PasswordDecoderFilter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpHeaders;
import org.springframework.mock.env.MockEnvironment;
import org.springframework.mock.web.MockServletContext;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import javax.servlet.Filter;
import javax.servlet.FilterRegistration;
import javax.servlet.Servlet;
import javax.servlet.ServletRegistration;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.options;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Unit tests for the {@link WebConfigurer} class.
 */
public class WebConfigurerTest {

	private WebConfigurer webConfigurer;

	private MockServletContext servletContext;

	private MockEnvironment env;

	private ApplicationProperties props;
	private PasswordDecoderFilter passwordDecoderFilter;

	@BeforeEach
	public void setup() {
		servletContext = spy(new MockServletContext());
		doReturn(mock(FilterRegistration.Dynamic.class))
			.when(servletContext).addFilter(anyString(), any(Filter.class));
		doReturn(mock(ServletRegistration.Dynamic.class))
			.when(servletContext).addServlet(anyString(), any(Servlet.class));

		env = new MockEnvironment();
		props = new ApplicationProperties();
		passwordDecoderFilter = new PasswordDecoderFilter(props);

		webConfigurer = new WebConfigurer(env, props, passwordDecoderFilter);
	}


	@Test
	public void testCorsFilterOnApiPath() throws Exception {
		props.getCors().setAllowedOrigins(Collections.singletonList("*"));
		props.getCors().setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE"));
		props.getCors().setAllowedHeaders(Collections.singletonList("*"));
		props.getCors().setMaxAge(1800L);
		props.getCors().setAllowCredentials(true);

		MockMvc mockMvc = MockMvcBuilders.standaloneSetup(new WebConfigurerTestController())
			.addFilters(webConfigurer.corsFilter())
			.build();

		mockMvc.perform(
			options("/api/test-cors")
				.header(HttpHeaders.ORIGIN, "other.domain.com")
				.header(HttpHeaders.ACCESS_CONTROL_REQUEST_METHOD, "POST"))
			.andExpect(status().isOk())
			.andExpect(header().string(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "other.domain.com"))
			.andExpect(header().string(HttpHeaders.VARY, "Origin"))
			.andExpect(header().string(HttpHeaders.ACCESS_CONTROL_ALLOW_METHODS, "GET,POST,PUT,DELETE"))
			.andExpect(header().string(HttpHeaders.ACCESS_CONTROL_ALLOW_CREDENTIALS, "true"))
			.andExpect(header().string(HttpHeaders.ACCESS_CONTROL_MAX_AGE, "1800"));

		mockMvc.perform(
			get("/api/test-cors")
				.header(HttpHeaders.ORIGIN, "other.domain.com"))
			.andExpect(status().isOk())
			.andExpect(header().string(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN, "other.domain.com"));
	}

	@Test
	public void testCorsFilterOnOtherPath() throws Exception {
		props.getCors().setAllowedOrigins(Collections.singletonList("*"));
		props.getCors().setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE"));
		props.getCors().setAllowedHeaders(Collections.singletonList("*"));
		props.getCors().setMaxAge(1800L);
		props.getCors().setAllowCredentials(true);

		MockMvc mockMvc = MockMvcBuilders.standaloneSetup(new WebConfigurerTestController())
			.addFilters(webConfigurer.corsFilter())
			.build();

		mockMvc.perform(
			get("/test/test-cors")
				.header(HttpHeaders.ORIGIN, "other.domain.com"))
			.andExpect(status().isOk())
			.andExpect(header().doesNotExist(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN));
	}

	@Test
	public void testCorsFilterDeactivated() throws Exception {
		props.getCors().setAllowedOrigins(null);

		MockMvc mockMvc = MockMvcBuilders.standaloneSetup(new WebConfigurerTestController())
			.addFilters(webConfigurer.corsFilter())
			.build();

		mockMvc.perform(
			get("/api/test-cors")
				.header(HttpHeaders.ORIGIN, "other.domain.com"))
			.andExpect(status().isOk())
			.andExpect(header().doesNotExist(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN));
	}

	@Test
	public void testCorsFilterDeactivated2() throws Exception {
		props.getCors().setAllowedOrigins(new ArrayList<>());

		MockMvc mockMvc = MockMvcBuilders.standaloneSetup(new WebConfigurerTestController())
			.addFilters(webConfigurer.corsFilter())
			.build();

		mockMvc.perform(
			get("/api/test-cors")
				.header(HttpHeaders.ORIGIN, "other.domain.com"))
			.andExpect(status().isOk())
			.andExpect(header().doesNotExist(HttpHeaders.ACCESS_CONTROL_ALLOW_ORIGIN));
	}
}
