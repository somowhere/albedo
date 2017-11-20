package com.albedo.java.web.rest.errors;

import com.albedo.java.AlbedoBootWebApp;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.web.rest.ExceptionTranslator;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Test class for the ExceptionTranslator controller advice.
 *
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = AlbedoBootWebApp.class)
public class ExceptionTranslatorIntTest {

    @Autowired
    private ExceptionTranslatorTestController controller;
    @Autowired
    private ExceptionTranslator exceptionTranslator;
    @Autowired
    private FastJsonHttpMessageConverter fastJsonHttpMessageConverter;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller)
            .setControllerAdvice(exceptionTranslator)
            .setMessageConverters(fastJsonHttpMessageConverter)
            .build();
    }

    @Test
    public void testRuntimeMsgFailure() throws Exception {
        mockMvc.perform(get("/test/runtime-failure"))
            .andExpect(status().isNotFound());
    }

    @Test
    public void testMethodArgumentNotValid() throws Exception {
         mockMvc.perform(post("/test/method-argument").content("{}")
                 .contentType(MediaType.APPLICATION_JSON))
             .andExpect(status().isOk())
//             .andExpect(content().contentType(MediaTypes.PROBLEM))
             .andExpect(jsonPath("$.status").value(Globals.MSG_TYPE_WARNING))
             .andExpect(jsonPath("$.data.[0].objectName").value("testDTO"))
             .andExpect(jsonPath("$.data.[0].field").value("test"))
             .andExpect(jsonPath("$.data.[0].code").value("NotNull"));
    }

    @Test
    public void testParameterizedError() throws Exception {
        mockMvc.perform(get("/test/parameterized-error"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.message").value("test parameterized error"))
            .andExpect(jsonPath("$.data.p1").value("param0_value"))
            .andExpect(jsonPath("$.data.p2").value("param1_value"));
    }

    @Test
    public void testParameterizedError2() throws Exception {
        mockMvc.perform(get("/test/parameterized-error2"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.message").value("test parameterized error"))
            .andExpect(jsonPath("$.data.foo").value("foo_value"))
            .andExpect(jsonPath("$.data.bar").value("bar_value"));
    }

    @Test
    public void testMissingServletRequestPartException() throws Exception {
        mockMvc.perform(get("/test/missing-servlet-request-part"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_400));
    }

    @Test
    public void testMissingServletRequestParameterException() throws Exception {
        mockMvc.perform(get("/test/missing-servlet-request-parameter"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_400));
    }

    @Test
    public void testAccessDenied() throws Exception {
        mockMvc.perform(get("/test/access-denied"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_403))
            .andExpect(jsonPath("$.message").value("权限不足"));
    }

    @Test
    public void testMethodNotSupported() throws Exception {
        mockMvc.perform(post("/test/access-denied"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_500))
            .andExpect(jsonPath("$.message").value("操作异常; Request method 'POST' not supported"));
    }


    @Test
    public void testInternalServerError() throws Exception {
        mockMvc.perform(get("/test/internal-server-error"))
            .andExpect(status().isOk())
//            .andExpect(content().contentType(MediaTypes.PROBLEM))
            .andExpect(jsonPath("$.code").value(Globals.ERROR_HTTP_CODE_500))
            .andExpect(jsonPath("$.message").value("操作异常; null"));
    }


}
