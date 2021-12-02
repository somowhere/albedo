package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * {tenant}:TOTAL_PV -> long
 *
 * @author somewhere
 * @date 2020/9/20 6:45 下午
 */
public class TotalPvCacheKeyBuilder implements CacheKeyBuilder {
	public static CacheKey build() {
		return new TotalPvCacheKeyBuilder().key();
	}

	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.TOTAL_PV;
	}
}
