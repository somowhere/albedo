package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * {tenant}:TOTAL_LOGIN_IV -> long
 * <p>
 * #sys_log_login
 *
 * @author somewhere
 * @date 2020/9/20 6:45 下午
 */
public class TotalLoginIvCacheKeyBuilder implements CacheKeyBuilder {
	public static CacheKey build() {
		return new TodayLoginIvCacheKeyBuilder().key();
	}

	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.TOTAL_LOGIN_IV;
	}
}
