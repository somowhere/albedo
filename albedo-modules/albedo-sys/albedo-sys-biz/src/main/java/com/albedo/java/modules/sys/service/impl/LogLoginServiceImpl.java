/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
package com.albedo.java.modules.sys.service.impl;

import cn.hutool.core.convert.Convert;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.util.MapHelper;
import com.albedo.java.modules.sys.cache.*;
import com.albedo.java.modules.sys.domain.LogLoginDo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.feign.RemoteLogLoginService;
import com.albedo.java.modules.sys.repository.LogLoginRepository;
import com.albedo.java.modules.sys.service.LogLoginService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.plugins.cache.repository.CacheOps;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 登录日志管理ServiceImpl 登录日志
 *
 * @author admin
 * @version 2021-11-30 10:15:00
 */
@Service
@Transactional(rollbackFor = Exception.class)
@RequiredArgsConstructor
public class LogLoginServiceImpl extends BaseServiceImpl<LogLoginRepository, LogLoginDo> implements LogLoginService, RemoteLogLoginService {
	private static final Supplier<Stream<String>> BROWSER = () -> Stream.of(
		"Chrome", "Firefox", "Microsoft Edge", "Safari", "Opera"
	);
	private static final Supplier<Stream<String>> OPERATING_SYSTEM = () -> Stream.of(
		"Android", "Linux", "Mac OS X", "Ubuntu", "Windows 10", "Windows 8", "Windows 7", "Windows XP", "Windows Vista"
	);
	private final UserService userService;
	private final CacheOps cacheOps;

	private static String simplifyOperatingSystem(String operatingSystem) {
		return OPERATING_SYSTEM.get().parallel().filter(b -> StrUtil.containsIgnoreCase(operatingSystem, b)).findAny().orElse(operatingSystem);
	}

	private static String simplifyBrowser(String browser) {
		return BROWSER.get().parallel().filter(b -> StrUtil.containsIgnoreCase(browser, b)).findAny().orElse(browser);
	}

	@Override
	public boolean save(LogLoginDo logLoginDo) {
		UserVo user;
		Long userId = logLoginDo.getUserId();
		String username = logLoginDo.getUsername();
		if (userId != null) {
			user = this.userService.findUserVoById(userId);
		} else {
			user = this.userService.findVoByUsername(username);
		}
		if (user != null) {
			logLoginDo.setUsername(user.getUsername()).setUserId(user.getId()).setNickname(user.getNickname())
				.setCreatedBy(user.getId());
		}

		super.save(logLoginDo);
		LocalDate now = LocalDate.now();
		String tenDaysAgo = LocalDateTimeUtil.formatNormal(now.plusDays(-9));

		CacheKey totalLoginPvKey = TotalLoginPvCacheKeyBuilder.build();
		CacheKey todayLoginPvKey = TodayLoginPvCacheKeyBuilder.build(now);
		// 登录IV
		CacheKey totalLoginIvKey = TotalLoginIvCacheKeyBuilder.build();
		CacheKey todayLoginIvKey = TodayLoginIvCacheKeyBuilder.build(now);

		CacheKey logLoginTenDayKey = new LogLoginTenDayCacheKeyBuilder().key(tenDaysAgo);
		CacheKey logLoginBrowserKey = new LogLoginBrowserCacheKeyBuilder().key();
		CacheKey logLoginSystemKey = new LogLoginSystemCacheKeyBuilder().key();
		cacheOps.del(totalLoginPvKey);
		cacheOps.del(todayLoginPvKey);
		cacheOps.del(todayLoginIvKey);
		cacheOps.del(totalLoginIvKey);
		cacheOps.del(logLoginTenDayKey);
		cacheOps.del(logLoginBrowserKey);
		cacheOps.del(logLoginSystemKey);
		if (user != null) {
			CacheKey logLoginTenDayUserKey = new LogLoginTenDayCacheKeyBuilder().key(tenDaysAgo, user.getUsername());
			cacheOps.del(logLoginTenDayUserKey);
		}
		return true;
	}

	@Override
	public void pvIncr() {
		CacheKey totalPvKey = TotalPvCacheKeyBuilder.build();
		cacheOps.incr(totalPvKey);

		CacheKey todayPvKey = TodayPvCacheKeyBuilder.build(LocalDate.now());
		cacheOps.incr(todayPvKey);
	}

	@Override
	public Long getTotalPv() {
		CacheKey key = TotalPvCacheKeyBuilder.build();
		return cacheOps.getCounter(key, k -> 0L);
	}

	@Override
	public Long getTodayPv() {
		CacheKey key = TodayPvCacheKeyBuilder.build(LocalDate.now());
		return cacheOps.getCounter(key, k -> 0L);
	}

	@Override
	public Long getTotalLoginPv() {
		CacheKey logLoginTotalKey = TotalLoginPvCacheKeyBuilder.build();
		return Convert.toLong(cacheOps.get(logLoginTotalKey, key -> repository.getTotalLoginPv()), 0L);
	}

	@Override
	public Long getTodayLoginPv() {
		LocalDate now = LocalDate.now();
		CacheKey logLoginTodayKey = TodayLoginPvCacheKeyBuilder.build(now);
		return Convert.toLong(cacheOps.get(logLoginTodayKey, k -> repository.getTodayLoginPv(now)), 0L);
	}

	@Override
	public Long getTotalLoginIv() {
		CacheKey key = TotalLoginIvCacheKeyBuilder.build();
		return Convert.toLong(cacheOps.get(key, k -> repository.getTotalLoginIv()), 0L);
	}

	@Override
	public Long getTodayLoginIv() {
		LocalDate now = LocalDate.now();
		CacheKey logLoginTodayIpKey = TodayLoginIvCacheKeyBuilder.build(now);
		return Convert.toLong(cacheOps.get(logLoginTodayIpKey, k -> repository.getTodayLoginIv(now)), 0L);
	}

	@Override
	public List<Map<String, String>> findLastTenDaysVisitCount(String account) {
		LocalDateTime tenDaysAgo = LocalDateTime.of(LocalDate.now().plusDays(-9), LocalTime.MIN);
		String tenDaysAgoStr = LocalDateTimeUtil.format(tenDaysAgo, DatePattern.NORM_DATE_FORMATTER);
		CacheKey logLoginTenDayKey = new LogLoginTenDayCacheKeyBuilder().key(tenDaysAgoStr, account);
		return cacheOps.get(logLoginTenDayKey, k -> {
			List<Map<String, String>> map = repository.findLastTenDaysVisitCount(tenDaysAgo, account);
			return map.stream().map(item -> {
				Map<String, String> kv = new HashMap<>(MapHelper.initialCapacity(map.size()));
				kv.put("loginDate", item.get("loginDate"));
				kv.put("count", String.valueOf(item.get("count")));
				return kv;
			}).collect(Collectors.toList());
		});
	}

	@Override
	public List<Map<String, Object>> findByBrowser() {
		CacheKey logLoginBrowserKey = new LogLoginBrowserCacheKeyBuilder().key();
		return cacheOps.get(logLoginBrowserKey, k -> repository.findByBrowser());
	}

	@Override
	public List<Map<String, Object>> findByOperatingSystem() {
		CacheKey logLoginSystemKey = new LogLoginSystemCacheKeyBuilder().key();
		return cacheOps.get(logLoginSystemKey, k -> repository.findByOperatingSystem());
	}

	@Override
	public boolean clearLog(LocalDateTime clearBeforeTime, Integer clearBeforeNum) {
		return repository.clearLog(clearBeforeTime, clearBeforeNum) > 0;
	}
}
