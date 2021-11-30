package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

import java.time.Duration;
import java.time.LocalDate;

/**
 * 参数 KEY
 * {tenant}:TODAY_LOGIN_IV:{now} -> long
 * <p>
 * #sys_log_login
 *
 * @author zuihou
 * @date 2020/9/20 6:45 下午
 */
public class TodayLoginIvCacheKeyBuilder implements CacheKeyBuilder {
	public static CacheKey build(LocalDate now) {
		return new TodayLoginIvCacheKeyBuilder().key(now.toString());
	}

	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.TODAY_LOGIN_IV;
	}

	@Override
	public Duration getExpire() {
		return Duration.ofDays(2L);
	}
}
