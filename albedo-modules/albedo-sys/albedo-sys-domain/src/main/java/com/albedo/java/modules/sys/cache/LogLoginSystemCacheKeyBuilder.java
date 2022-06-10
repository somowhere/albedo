package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * {tenant}:LOGIN_LOG_SYSTEM -> long
 * <p>
 * #sys_log_login
 *
 * @author somewhere
 * @date 2020/9/20 6:45 下午
 */
public class LogLoginSystemCacheKeyBuilder implements CacheKeyBuilder {
	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.LOGIN_LOG_SYSTEM;
	}

}
