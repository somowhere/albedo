/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.service.LogOperateService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

/**
 * Test class for the UserResource REST web.
 *
 * @see UserResource
 */
@Slf4j
public class LogOperateResourceIntTest extends SimulationRuntimeIntegrationTest {


	private String DEFAULT_API_URL;

	@Autowired
	private LogOperateService logOperateService;

	private MockMvc restLogOperateMockMvc;

	@Autowired
	private MappingJackson2HttpMessageConverter jacksonMessageConverter;

	@Autowired
	private GlobalExceptionHandler globalExceptionHandler;

	@Autowired
	private ApplicationProperties applicationProperties;


	@BeforeEach
	public void setup() {
		DEFAULT_API_URL = applicationProperties.getAdminPath("/sys/log-operate");
		MockitoAnnotations.openMocks(this);
		final LogOperateResource logOperateResource = new LogOperateResource(logOperateService);
		this.restLogOperateMockMvc = MockMvcBuilders.standaloneSetup(logOperateResource)
			.addPlaceholderValue(TestUtil.ADMIN_PATH, applicationProperties.getAdminPath())
			.setControllerAdvice(globalExceptionHandler).setConversionService(createFormattingConversionService())
			.setMessageConverters(jacksonMessageConverter).build();

	}

	@BeforeEach
	public void initTest() {
	}

	@Test
	@Transactional(rollbackFor = Exception.class)
	public void download() throws Exception {
		restLogOperateMockMvc.perform(get(DEFAULT_API_URL + "/download"));
		//String path =  System.getProperty("user.dir")+"/4.xlsx";
		//ExcelUtil excelUtil = new ExcelUtil( LogOperateDo.class);
		//	excelUtil.init(logOperateService.list(), "test", ExcelField.Type.EXPORT);
		//excelUtil.exportExcel(new FileOutputStream(path));
	}


}
