package com.albedo.java.modules.sys.component;


import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.cache.CacheManager;
import org.springframework.core.env.Environment;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Set;

@Component
@Slf4j
@AllArgsConstructor
public class InitCacheDataComponent implements InitializingBean {

	private final Environment environment;
	private final CacheManager cacheManager;
	private final RedisTemplate redisTemplate;

	@Override
	public void afterPropertiesSet() {
		if (SpringContextHolder.isDevelopment(environment)) {
			Collection<String> cacheNames = cacheManager.getCacheNames();
			if (CollUtil.isNotEmpty(cacheNames)) {
				for (String cacheName : cacheNames) {
					cacheManager.getCache(cacheName).clear();
				}
			}
			Set keys = redisTemplate.keys("*details*");
			redisTemplate.delete(keys);
		}
	}
}
