package com.albedo.java.common.config;

import org.apache.xmlbeans.impl.piccolo.xml.EntityManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PreDestroy;
import javax.annotation.Resource;

@Configuration
@EnableCaching
//@AutoConfigureAfter(value = { DatabaseConfiguration.class })
public class CacheConfiguration {

    private final Logger log = LoggerFactory.getLogger(CacheConfiguration.class);

//    @PersistenceContext
//    private EntityManager entityManager;

    @Resource
    AlbedoProperties albedoProperties;
    private net.sf.ehcache.CacheManager cacheManager;

    @PreDestroy
    public void destroy() {
        getCacheManager().shutdown();
    }

    @Bean
    public CacheManager ehCacheManager() {
       
        log.debug("Registering Ehcache Metrics gauges");
//        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();
//        for (EntityType<?> entity : entities) {
//            String name = entity.getName();
//            if (name == null || entity.getJavaType() != null) {
//                name = entity.getJavaType().getName();
//            }
//        }
        EhCacheCacheManager ehCacheManager = new EhCacheCacheManager();
        ehCacheManager.setCacheManager(getCacheManager());
        return ehCacheManager;
    }
    
    @Bean(name="cacheManager")
    public net.sf.ehcache.CacheManager cacheManager() {
        return getCacheManager();
    }
    
    private net.sf.ehcache.CacheManager getCacheManager() {
    	if(cacheManager == null){
    		log.debug("Starting Ehcache");
      		 cacheManager = net.sf.ehcache.CacheManager.create();
      	     cacheManager.getConfiguration().setMaxBytesLocalHeap(albedoProperties.getCache().getEhcache().getMaxBytesLocalHeap());
    	}
		return cacheManager;
	}


}
