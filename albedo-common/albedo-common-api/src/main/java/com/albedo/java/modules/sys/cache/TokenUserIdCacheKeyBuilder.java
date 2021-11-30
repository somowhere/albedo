package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * <p>
 * #c_application
 *
 * @author zuihou
 * @date 2020/9/20 6:45 下午
 */
public class TokenUserIdCacheKeyBuilder implements CacheKeyBuilder {
	@Override
	public String getPrefix() {
		return CacheKeyBuilderConstants.TOKEN_USER_ID;
	}

//    @Override
//    public Duration getExpire() {
//        return Duration.ofMinutes(15);
//    }
}
