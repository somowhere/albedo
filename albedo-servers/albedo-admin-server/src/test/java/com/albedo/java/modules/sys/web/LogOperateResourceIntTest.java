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

import cn.hutool.core.io.FileUtil;
import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.common.core.exception.handler.GlobalExceptionHandler;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.modules.TestUtil;
import com.albedo.java.modules.base.SimulationRuntimeIntegrationTest;
import com.albedo.java.modules.sys.domain.DeptDo;
import com.albedo.java.modules.sys.domain.LogOperateDo;
import com.albedo.java.modules.sys.domain.RoleDo;
import com.albedo.java.modules.sys.domain.UserDo;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.LogOperateService;
import com.albedo.java.modules.sys.service.RoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.stream.Collectors;

import static com.albedo.java.modules.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.hasItem;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

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
		restLogOperateMockMvc.perform(get(DEFAULT_API_URL+"/download"));
		//String path =  System.getProperty("user.dir")+"/4.xlsx";
		//ExcelUtil excelUtil = new ExcelUtil( LogOperateDo.class);
		//	excelUtil.init(logOperateService.list(), "test", ExcelField.Type.EXPORT);
		//excelUtil.exportExcel(new FileOutputStream(path));
	}



}
