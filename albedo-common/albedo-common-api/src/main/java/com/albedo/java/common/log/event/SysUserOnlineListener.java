/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.log.event;

import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.scheduling.annotation.Async;
import org.springframework.security.core.session.SessionInformation;


/**
 * @author somewhere
 * 异步监听日志事件
 */
@Slf4j
@AllArgsConstructor
public class SysUserOnlineListener {
	private final UserOnlineService userOnlineService;

	@Async
	@Order
	@EventListener(SysUserOnlineEvent.class)
	public void saveSysUserOnline(SysUserOnlineEvent event) {
		UserOnline userOnline = (UserOnline) event.getSource();
		userOnlineService.saveByEvent(userOnline);

	}

	@Async
	@Order
	@EventListener(SysUserOnlineRefreshLastRequestEvent.class)
	public void saveSysUserOnlineRefreshLastRequestEvent(SysUserOnlineRefreshLastRequestEvent event) {
		SessionInformation sessionInformation = (SessionInformation) event.getSource();
		UserOnline userOnline = userOnlineService.getById(sessionInformation.getSessionId());
		if (userOnline != null) {
			userOnline.setLastAccessTime(sessionInformation.getLastRequest());
			userOnlineService.updateById(userOnline);
		} else {
			log.debug("sessionInformation sessionId " + sessionInformation.getSessionId() + ", onlineUser is null");
		}

	}

}
