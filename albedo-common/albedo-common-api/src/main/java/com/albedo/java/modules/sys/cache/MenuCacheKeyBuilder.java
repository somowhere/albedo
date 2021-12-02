package com.albedo.java.modules.sys.cache;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

import java.time.Duration;

/**
 * @author somewhere
 * @date 2021/10/21 11:25 上午
 */
public class MenuCacheKeyBuilder implements CacheKeyBuilder {
	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.MENU;
	}

	@Override
	public Duration getExpire() {
		return Duration.ofHours(12);
	}
}

