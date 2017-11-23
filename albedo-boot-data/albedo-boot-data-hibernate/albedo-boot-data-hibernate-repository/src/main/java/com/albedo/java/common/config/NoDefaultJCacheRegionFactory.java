package com.albedo.java.common.config;

import java.util.Properties;
import javax.cache.Cache;
import org.hibernate.cache.jcache.JCacheRegionFactory;
import org.hibernate.cache.spi.CacheDataDescription;

public class NoDefaultJCacheRegionFactory extends JCacheRegionFactory {
    public NoDefaultJCacheRegionFactory() {
    }

    @Override
    protected Cache<Object, Object> createCache(String regionName, Properties properties, CacheDataDescription metadata) {
        throw new IllegalStateException("All Hibernate caches should be created upfront. Please update CacheConfiguration.java to add " + regionName);
    }
}

