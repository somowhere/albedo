/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.util;

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.event.listener.SysLogLoginEvent;
import com.albedo.java.modules.sys.domain.LogLoginDo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 异步工厂（产生任务用）
 *
 * @author somewhere
 */
public class AsyncUtil {

	private static final Logger sys_user_logger = LoggerFactory.getLogger("sys-user");

	/**
	 * 记录登陆信息
	 *
	 * @param logLoginDo 日志
	 */
	public static void recordLogLogin(LogLoginDo logLoginDo) {

		// 打印信息到日志
		sys_user_logger.info("[logLogin]:{}", logLoginDo);
		// 发送异步日志事件
		SpringContextHolder.publishEvent(new SysLogLoginEvent(logLoginDo));
	}

}
