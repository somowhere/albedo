
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

package com.albedo.java.common.security.event;

import cn.hutool.core.date.LocalDateTimeUtil;
import com.albedo.java.modules.sys.domain.UserOnlineDo;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.session.SessionInformation;

/**
 * @author somewhere 异步监听日志事件
 */
@Slf4j
@AllArgsConstructor
public class SysUserOnlineListener {

	private final UserOnlineService userOnlineService;

	@Async
	@Order
	@EventListener(SysUserOnlineEvent.class)
	public void saveSysUserOnline(SysUserOnlineEvent event) {
		UserOnlineDo userOnlineDo = (UserOnlineDo) event.getSource();
		userOnlineService.saveByEvent(userOnlineDo);

	}

	@Async
	@Order
	@EventListener(SysUserOnlineRefreshLastRequestEvent.class)
	public void saveSysUserOnlineRefreshLastRequestEvent(SysUserOnlineRefreshLastRequestEvent event) {
		SessionInformation sessionInformation = (SessionInformation) event.getSource();
		UserOnlineDo userOnlineDo = userOnlineService.getById(sessionInformation.getSessionId());
		if (userOnlineDo != null) {
			userOnlineDo.setLastAccessTime(LocalDateTimeUtil.of(sessionInformation.getLastRequest()));
			userOnlineService.updateById(userOnlineDo);
		} else {
			log.debug("sessionInformation sessionId " + sessionInformation.getSessionId() + ", onlineUser is null");
		}

	}

}
