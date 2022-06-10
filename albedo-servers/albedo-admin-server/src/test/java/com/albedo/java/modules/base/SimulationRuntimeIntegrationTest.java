package com.albedo.java.modules.base;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.modules.AlbedoAdminApplication;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.TestExecutionEvent;
import org.springframework.security.test.context.support.WithUserDetails;

@Slf4j
@WithUserDetails(userDetailsServiceBeanName = "userDetailsServiceImpl", value = "admin", setupBefore = TestExecutionEvent.TEST_EXECUTION)
@SpringBootTest(classes = AlbedoAdminApplication.class)
public class SimulationRuntimeIntegrationTest {
	@BeforeEach
	public void initBeforeTest() {
		ContextUtil.setTenant(CommonConstants.TENANT_CODE_ADMIN);
	}

}
