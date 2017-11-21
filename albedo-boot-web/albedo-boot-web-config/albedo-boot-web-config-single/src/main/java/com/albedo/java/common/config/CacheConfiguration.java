package com.albedo.java.common.config;

import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import org.ehcache.config.builders.CacheConfigurationBuilder;
import org.ehcache.config.builders.ResourcePoolsBuilder;
import org.ehcache.expiry.Duration;
import org.ehcache.expiry.Expirations;
import org.ehcache.jsr107.Eh107Configuration;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.cache.JCacheManagerCustomizer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

@Configuration
@EnableCaching
@AutoConfigureAfter(value = { MetricsConfiguration.class })
//@AutoConfigureBefore(value = { WebConfigurer.class, DatabaseAutoConfiguration.class })
public class CacheConfiguration {

    public CacheConfiguration(){
        int i=0;
        System.out.println("......................"+i);
    }
}
