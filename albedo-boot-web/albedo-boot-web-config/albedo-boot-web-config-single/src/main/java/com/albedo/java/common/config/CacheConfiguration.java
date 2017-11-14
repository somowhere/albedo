package com.albedo.java.common.config;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.ehcache.InstrumentedEhcache;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PreDestroy;
import java.util.SortedSet;

@Configuration
@EnableCaching
@AutoConfigureAfter(value = {MetricsConfiguration.class})
public class CacheConfiguration {

    private final Logger log = LoggerFactory.getLogger(CacheConfiguration.class);

    //    @PersistenceContext
//    private EntityManager entityManager;
    @Autowired
    AlbedoProperties albedoProperties;
    @Autowired
    private MetricRegistry metricRegistry;
    private net.sf.ehcache.CacheManager cacheManager;

    @PreDestroy
    public void destroy() {
        log.info("Remove Cache Manager metrics");
        SortedSet<String> names = metricRegistry.getNames();
        names.forEach(metricRegistry::remove);
        log.info("Closing Cache Manager");
        getCacheManager().shutdown();
    }

    @Bean(name = "ehCacheManager")
    public EhCacheCacheManager ehCacheManager() {

        log.debug("Registering Ehcache Metrics gauges");
//        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();
//        for (EntityType<?> entity : entities) {
//            String name = entity.getName();
//            if (name == null || entity.getJavaType() != null) {
//                name = entity.getJavaType().getName();
//            }
//            Assert.notNull(name, "entity cannot exist without an identifier");
//            reconfigureCache(name, albedoProperties);
//            for (PluralAttribute pluralAttribute : entity.getPluralAttributes()) {
//                reconfigureCache(name + "." + pluralAttribute.getName(), albedoProperties);
//            }
//        }
        EhCacheCacheManager ehCacheManager = new EhCacheCacheManager();
        ehCacheManager.setCacheManager(getCacheManager());
        return ehCacheManager;
    }

    @Bean(name = "cacheManager")
    public net.sf.ehcache.CacheManager cacheManager() {
        return getCacheManager();
    }

    private net.sf.ehcache.CacheManager getCacheManager() {
        if (cacheManager == null) {
            log.debug("Starting Ehcache");
            cacheManager = net.sf.ehcache.CacheManager.create();
            cacheManager.getConfiguration().setMaxBytesLocalHeap(albedoProperties.getCache().getEhcache().getMaxBytesLocalHeap());
        }
        return cacheManager;
    }

    private void reconfigureCache(String name, AlbedoProperties albedoProperties) {
        net.sf.ehcache.Cache cache = getCacheManager().getCache(name);
        if (cache != null) {
            cache.getCacheConfiguration().setTimeToLiveSeconds(albedoProperties.getCache().getTimeToLiveSeconds());
            net.sf.ehcache.Ehcache decoratedCache = InstrumentedEhcache.instrument(metricRegistry, cache);
            getCacheManager().replaceCacheWithDecoratedCache(cache, decoratedCache);
        }
    }

}
