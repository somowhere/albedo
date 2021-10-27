package com.albedo.java.modules.sys.cache;


import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.constant.CacheKeyBuilderConstants;

/**
 * 参数 KEY
 * {tenant}:PARAMETER_KEY:{key} -> value
 * <p>
 * #c_parameter
 *
 * @author zuihou
 * @date 2020/9/20 6:45 下午
 */
public class ParameterKeyCacheKeyBuilder implements CacheKeyBuilder {
    @Override
    public String getPrefix() {
        return CacheKeyBuilderConstants.PARAMETER_KEY;
    }

}
