
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

package com.albedo.java.modules;

import com.albedo.java.plugins.dynamic.datasource.annotation.EnableDynamicDataSource;
import com.albedo.java.plugins.swagger.annotation.EnableSwaggerDoc;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import java.net.InetAddress;

/**
 * @author somewhere
 * @date 2018年06月21日 用户统一管理系统
 */
@Slf4j
@EnableSwaggerDoc
@EnableDynamicDataSource
@SpringBootApplication
public class AlbedoApiApplication {

	static String SERVER_PORT = "server.port";
	static String SPRING_APPLICATION_NAME = "spring.application.name";
	static String APPLICATION_VERSION = "application.version";

	public static void main(String[] args) throws Exception {
		SpringApplication app = new SpringApplication(AlbedoApiApplication.class);
		final ApplicationContext applicationContext = app.run(args);
		Environment env = applicationContext.getEnvironment();
		log.info(
			"\n----------------------------------------------------------\n\t"
				+ "Application '{} v{}' is running! Access URLs:\n\t" + "Local: \t\thttp://localhost:{}\n\t"
				+ "Doc: \t\thttp://localhost:{}/swagger-ui/index.html\n\t"
				+ "External: \thttp://{}:{}\n\t"
				+ "\n----------------------------------------------------------",
			env.getProperty(SPRING_APPLICATION_NAME), env.getProperty(APPLICATION_VERSION), env.getProperty(SERVER_PORT), env.getProperty(SERVER_PORT),
			InetAddress.getLocalHost().getHostAddress(), env.getProperty(SERVER_PORT));
	}

}
