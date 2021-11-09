/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.util;

import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.event.listener.SysLogEvent;
import com.albedo.java.common.log.enums.OperatorType;
import com.albedo.java.modules.sys.domain.LogOperate;
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
	 * @param logOperate 日志
	 */
	public static void recordLogLogin(LogOperate logOperate) {

		logOperate.setOperatorType(OperatorType.MANAGE.name());
		// 打印信息到日志
		sys_user_logger.info("[logOperateVo]:{}", logOperate);
		// 发送异步日志事件
		SpringContextHolder.publishEvent(new SysLogEvent(logOperate));
	}

}
