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

package com.albedo.java.common.security.component.session;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.security.event.SysUserOnlineEvent;
import com.albedo.java.common.security.event.SysUserOnlineRefreshLastRequestEvent;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.domain.UserOnlineDo;
import com.albedo.java.modules.sys.feign.RemoteUserOnlineService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;

import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
@Slf4j
@AllArgsConstructor
public class RedisSessionRegistry implements SessionRegistry, ApplicationListener<SessionDestroyedEvent> {

	public static final String SESSIONIDS = ":sessionIds";

	public static final String PRINCIPALS = ":principals";

	private final ApplicationProperties applicationProperties;

	private final RedisTemplate redisTemplate;

	private final RemoteUserOnlineService userOnlineService;

	// ~ Methods
	// ========================================================================================================

	@Override
	public List<Object> getAllPrincipals() {
		return new ArrayList<>(redisTemplate.boundHashOps(getSessionIdsKey()).keys());
	}

	@Override
	public List<SessionInformation> getAllSessions(Object principal, boolean includeExpiredSessions) {
		Set<String> sessionsUsedByPrincipal = getPrincipals(principal);

		if (sessionsUsedByPrincipal == null) {
			return Collections.emptyList();
		}

		List<SessionInformation> list = new ArrayList<>(sessionsUsedByPrincipal.size());

		for (String sessionId : sessionsUsedByPrincipal) {
			SessionInformation sessionInformation = getSessionInformation(sessionId);

			if (sessionInformation == null) {
				continue;
			}

			if (includeExpiredSessions || !sessionInformation.isExpired()) {
				list.add(sessionInformation);
			}
		}

		return list;
	}

	@Override
	public SessionInformation getSessionInformation(String sessionId) {
		ArgumentAssert.notEmpty(sessionId, "SessionId required as per interface contract");

		return (SessionInformation) redisTemplate.boundHashOps(getSessionIdsKey()).get(sessionId);
	}

	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		String sessionId = event.getId();
		removeSessionInformation(sessionId);
	}

	@Override
	public void refreshLastRequest(String sessionId) {
		ArgumentAssert.notEmpty(sessionId, "SessionId required as per interface contract");

		SessionInformation info = getSessionInformation(sessionId);
		if (info != null) {
			long lastRequestTime = info.getLastRequest().getTime();
			info.refreshLastRequest();
			int dbSyncSessionPeriodTime = applicationProperties.getDbSyncSessionPeriod() * 60 * 1000;
			if (dbSyncSessionPeriodTime < info.getLastRequest().getTime() - lastRequestTime) {
				SpringContextHolder.publishEvent(new SysUserOnlineRefreshLastRequestEvent(info));
			}
		}

	}

	@Override
	public void registerNewSession(String sessionId, Object principal) {
		ArgumentAssert.notEmpty(sessionId, "SessionId required as per interface contract");
		ArgumentAssert.notNull(principal, "Principal required as per interface contract");
		ArgumentAssert.isTrue(principal instanceof UserDetail, "Principal required as UserDetail");

		if (log.isDebugEnabled()) {
			log.debug("Registering session " + sessionId + ", for principal " + principal);
		}

		UserDetail userDetail = (UserDetail) principal;
		if (getSessionInformation(sessionId) != null) {
			removeSessionInformation(sessionId);
		}
		SessionInformation sessionInformation = new CustomSessionInformation(userDetail.getId(), sessionId, new Date());
		redisTemplate.boundHashOps(getSessionIdsKey()).put(sessionId, sessionInformation);

		Set<String> sessionsUsedByPrincipal = getPrincipals(userDetail.getId());
		if (sessionsUsedByPrincipal == null) {
			sessionsUsedByPrincipal = new CopyOnWriteArraySet();
			Set<String> prevSessionsUsedByPrincipal = this.putIfAbsentPrincipals(userDetail.getId(), sessionsUsedByPrincipal);
			if (prevSessionsUsedByPrincipal != null) {
				sessionsUsedByPrincipal = prevSessionsUsedByPrincipal;
			}
		}
		sessionsUsedByPrincipal.add(sessionId);

		if (log.isTraceEnabled()) {
			log.trace("Sessions used by '" + principal + "' : " + sessionsUsedByPrincipal);
		}
		Authentication authentication = SecurityUtil.getAuthentication();
		if (authentication != null && authentication.isAuthenticated()) {
			UserOnlineDo userOnlineDo = userOnlineService.getById(sessionId);
			if (userOnlineDo == null) {
				userOnlineDo = LoginUtil.getUserOnline(authentication);
				SpringContextHolder.publishEvent(new SysUserOnlineEvent(userOnlineDo));
			}
		}
	}

	@Override
	public void removeSessionInformation(String sessionId) {
		ArgumentAssert.notEmpty(sessionId, "SessionId required as per interface contract");
		userOnlineService.deleteBySessionId(sessionId);
		SessionInformation info = null;
		try {
			info = getSessionInformation(sessionId);
		} catch (Exception e) {
			redisTemplate.boundHashOps(getSessionIdsKey()).delete(sessionId);
		}
		if (info == null) {
			return;
		}
		if (log.isTraceEnabled()) {
			log.debug("Removing session " + sessionId + " from set of registered sessions");
		}

		redisTemplate.boundHashOps(getSessionIdsKey()).delete(sessionId);

		Set<String> sessionsUsedByPrincipal = getPrincipals(info.getPrincipal());

		if (sessionsUsedByPrincipal == null) {
			return;
		}

		if (log.isDebugEnabled()) {
			log.debug("Removing session " + sessionId + " from principal's set of registered sessions");
		}

		sessionsUsedByPrincipal.remove(sessionId);

		if (sessionsUsedByPrincipal.isEmpty()) {
			// No need to keep object in principals Map anymore
			if (log.isDebugEnabled()) {
				log.debug("Removing principal " + info.getPrincipal() + " from registry");
			}
			removePrincipal(info.getPrincipal());
		}

		if (log.isTraceEnabled()) {
			log.trace("Sessions used by '" + info.getPrincipal() + "' : " + sessionsUsedByPrincipal);
		}

	}

	public Set<String> putIfAbsentPrincipals(Object principal, final Set<String> set) {
		String id = String.valueOf(principal);
		BoundHashOperations<String, String, Set<String>> hashOperations = redisTemplate.boundHashOps(getSessionIdsKey());
		hashOperations.putIfAbsent(id, set);
		return hashOperations.get(id);
	}

	public Set<String> getPrincipals(Object principal) {
		return (Set<String>) redisTemplate.boundHashOps(getSessionIdsKey()).get(String.valueOf(principal));
	}

	public void removePrincipal(Object principal) {
		redisTemplate.boundHashOps(getSessionIdsKey()).delete(String.valueOf(principal));
	}

	private String getSessionIdsKey() {
		return ContextUtil.getTenant() + SESSIONIDS;
	}

	private String getPrincipalsKey() {
		return ContextUtil.getTenant() + PRINCIPALS;
	}
}
