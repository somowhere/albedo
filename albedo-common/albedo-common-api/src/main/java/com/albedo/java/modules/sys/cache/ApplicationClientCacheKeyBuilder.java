package com.albedo.java.modules.sys.cache;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

import java.time.Duration;

/**
 * 应用 KEY
 * <p>
 * #c_auth_application
 *
 * @author somewhere
 * @date 2020/9/20 6:45 下午
 */
public class ApplicationClientCacheKeyBuilder implements CacheKeyBuilder {
	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.APPLICATION_CLIENT;
	}

	@Override
	public Duration getExpire() {
		return Duration.ofHours(24);
	}
}
