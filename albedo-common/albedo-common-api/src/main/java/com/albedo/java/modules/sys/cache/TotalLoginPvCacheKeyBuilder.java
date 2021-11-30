package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * {tenant}:TOTAL_LOGIN_PV -> long
 * <p>
 * #sys_log_login
 *
 * @author zuihou
 * @date 2020/9/20 6:45 下午
 */
public class TotalLoginPvCacheKeyBuilder implements CacheKeyBuilder {
	public static CacheKey build() {
		return new TotalLoginPvCacheKeyBuilder().key();
	}

	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.TOTAL_LOGIN_PV;
	}
}
