package com.albedo.java.common.security.component.session;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.security.event.SysUserOnlineEvent;
import com.albedo.java.common.security.event.SysUserOnlineRefreshLastRequestEvent;
import com.albedo.java.common.security.service.UserDetail;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.domain.UserOnline;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationListener;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionDestroyedEvent;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.util.Assert;

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

	public static final String SESSIONIDS = "sessionIds";

	public static final String PRINCIPALS = "principals";

	private final ApplicationProperties applicationProperties;

	private final RedisTemplate redisTemplate;

	private final UserOnlineService userOnlineService;

	// ~ Methods
	// ========================================================================================================

	@Override
	public List<Object> getAllPrincipals() {
		return new ArrayList<>(redisTemplate.boundHashOps(PRINCIPALS).keys());
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
		Assert.hasText(sessionId, "SessionId required as per interface contract");

		return (SessionInformation) redisTemplate.boundHashOps(SESSIONIDS).get(sessionId);
	}

	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		String sessionId = event.getId();
		removeSessionInformation(sessionId);
	}

	@Override
	public void refreshLastRequest(String sessionId) {
		Assert.hasText(sessionId, "SessionId required as per interface contract");

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
		Assert.hasText(sessionId, "SessionId required as per interface contract");
		Assert.notNull(principal, "Principal required as per interface contract");

		if (log.isDebugEnabled()) {
			log.debug("Registering session " + sessionId + ", for principal " + principal);
		}

		if (getSessionInformation(sessionId) != null) {
			removeSessionInformation(sessionId);
		}
		SessionInformation sessionInformation = new SessionInformation(principal, sessionId, new Date());
		redisTemplate.boundHashOps(SESSIONIDS).put(sessionId, sessionInformation);

		Set<String> sessionsUsedByPrincipal = getPrincipals(principal);
		if (sessionsUsedByPrincipal == null) {
			sessionsUsedByPrincipal = new CopyOnWriteArraySet();
			Set<String> prevSessionsUsedByPrincipal = this.putIfAbsentPrincipals(principal, sessionsUsedByPrincipal);
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
			UserOnline userOnline = userOnlineService.getById(sessionId);
			if (userOnline == null) {
				userOnline = LoginUtil.getUserOnline(authentication);
				SpringContextHolder.publishEvent(new SysUserOnlineEvent(userOnline));
			}
		}
	}

	@Override
	public void removeSessionInformation(String sessionId) {
		Assert.hasText(sessionId, "SessionId required as per interface contract");
		userOnlineService.deleteBySessionId(sessionId);
		SessionInformation info = null;
		try {
			info = getSessionInformation(sessionId);
		} catch (Exception e) {
			redisTemplate.boundHashOps(SESSIONIDS).delete(sessionId);
		}
		if (info == null) {
			return;
		}
		if (log.isTraceEnabled()) {
			log.debug("Removing session " + sessionId + " from set of registered sessions");
		}

		redisTemplate.boundHashOps(SESSIONIDS).delete(sessionId);

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
		UserDetail userDetail = (UserDetail) principal;
		BoundHashOperations<String, String, Set<String>> hashOperations = redisTemplate.boundHashOps(PRINCIPALS);
		hashOperations.putIfAbsent(userDetail.getId(), set);
		return hashOperations.get(userDetail.getId());
	}

	public Set<String> getPrincipals(Object principal) {
		UserDetail userDetail = (UserDetail) principal;
		return (Set<String>) redisTemplate.boundHashOps(PRINCIPALS).get(userDetail.getId());
	}

	public void removePrincipal(Object principal) {
		UserDetail userDetail = (UserDetail) principal;
		redisTemplate.boundHashOps(PRINCIPALS).delete(userDetail.getId());
	}

}
