/*
 *  Copyright (c) 2019-2020, somewhere (wangiegie@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
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

package com.albedo.java.common.config;

import com.albedo.java.common.log.aspect.RequestLogAspect;
import com.albedo.java.common.log.aspect.SysLogAspect;
import com.albedo.java.common.log.event.SysLogListener;
import com.albedo.java.common.security.event.SysUserOnlineListener;
import com.albedo.java.modules.sys.service.LogOperateService;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.AllArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * @author somewhere
 * @date 2019/2/1 日志自动配置
 */
@EnableAsync
@Configuration
@AllArgsConstructor
@EnableAspectJAutoProxy
@ConditionalOnWebApplication
public class LogAutoConfiguration {

	private final LogOperateService logOperateService;

	private final UserOnlineService userOnlineService;

	@Bean
	public SysLogListener sysLogListener() {
		return new SysLogListener(logOperateService);
	}

	@Bean
	public SysUserOnlineListener sysUserOnlineListener() {
		return new SysUserOnlineListener(userOnlineService);
	}

	@Bean
	public SysLogAspect loggingAspect() {
		return new SysLogAspect();
	}

	@Bean
	public RequestLogAspect requestLogAspect() {
		return new RequestLogAspect();
	}

}
