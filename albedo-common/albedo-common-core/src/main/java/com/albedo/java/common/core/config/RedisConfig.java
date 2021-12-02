///*
// *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
// *  <p>
// *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
// *  you may not use this file except in compliance with the License.
// *  You may obtain a copy of the License at
// *  <p>
// * https://www.gnu.org/licenses/lgpl.html
// *  <p>
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
///*
// *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
// *  <p>
// *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
// *  you may not use this file except in compliance with the License.
// *  You may obtain a copy of the License at
// *  <p>
// * https://www.gnu.org/licenses/lgpl.html
// *  <p>
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
//package com.albedo.java.common.core.config;
//
//import cn.hutool.crypto.digest.DigestUtil;
//import cn.hutool.json.JSONUtil;
//import com.albedo.java.common.core.context.ContextUtil;
//import com.albedo.java.common.core.util.StrPool;
//import lombok.AllArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.boot.autoconfigure.AutoConfigureBefore;
//import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
//import org.springframework.cache.Cache;
//import org.springframework.cache.CacheManager;
//import org.springframework.cache.annotation.CachingConfigurerSupport;
//import org.springframework.cache.annotation.EnableCaching;
//import org.springframework.cache.interceptor.CacheErrorHandler;
//import org.springframework.cache.interceptor.KeyGenerator;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.data.redis.cache.RedisCacheManager;
//import org.springframework.data.redis.connection.RedisConnectionFactory;
//import org.springframework.data.redis.core.*;
//import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
//import org.springframework.data.redis.serializer.StringRedisSerializer;
//
//import java.util.HashMap;
//import java.util.Map;
//
///**
// * @author somewhere
// * @date 2019/2/1 Redis 配置类
// */
//@EnableCaching
//@Configuration
//@AllArgsConstructor
//@Slf4j
//@AutoConfigureBefore(RedisAutoConfiguration.class)
//public class RedisConfig extends CachingConfigurerSupport {
//
//	private final RedisConnectionFactory factory;
//
//	@Bean
//	public JdkSerializationRedisSerializer jdkSerializationRedisSerializer() {
//		return new JdkSerializationRedisSerializer();
//	}
//
//	@Bean
//	public StringRedisSerializer stringRedisSerializer() {
//		return new StringRedisSerializer();
//	}
//
//	@Bean
//	public RedisTemplate<String, Object> redisTemplate(JdkSerializationRedisSerializer jdkSerializationRedisSerializer,
//													   StringRedisSerializer stringRedisSerializer) {
//		RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
//		redisTemplate.setKeySerializer(stringRedisSerializer);
//		redisTemplate.setHashKeySerializer(stringRedisSerializer);
//		redisTemplate.setValueSerializer(jdkSerializationRedisSerializer);
//		redisTemplate.setHashValueSerializer(jdkSerializationRedisSerializer);
//		redisTemplate.setConnectionFactory(factory);
//		return redisTemplate;
//	}
//
//	@Bean
//	public HashOperations<String, String, Object> hashOperations(RedisTemplate<String, Object> redisTemplate) {
//		return redisTemplate.opsForHash();
//	}
//
//	@Bean
//	public ValueOperations<String, String> valueOperations(RedisTemplate<String, String> redisTemplate) {
//		return redisTemplate.opsForValue();
//	}
//
//	@Bean
//	public ListOperations<String, Object> listOperations(RedisTemplate<String, Object> redisTemplate) {
//		return redisTemplate.opsForList();
//	}
//
//	@Bean
//	public SetOperations<String, Object> setOperations(RedisTemplate<String, Object> redisTemplate) {
//		return redisTemplate.opsForSet();
//	}
//
//	@Bean
//	public ZSetOperations<String, Object> zSetOperations(RedisTemplate<String, Object> redisTemplate) {
//		return redisTemplate.opsForZSet();
//	}
//
//	@Bean
//	public CacheManager cacheManager(RedisConnectionFactory connectionFactory) {
//		return RedisCacheManager.create(connectionFactory);
//	}
//
//	/**
//	 * 自定义缓存key生成策略，默认将使用该策略
//	 */
//	@Bean
//	@Override
//	public KeyGenerator keyGenerator() {
//		return (target, method, params) -> {
//			Map<String, Object> container = new HashMap<>(3);
//			Class<?> targetClassClass = target.getClass();
//			// 类地址
//			container.put("class", targetClassClass.toGenericString());
//			// 方法名称
//			container.put("methodName", method.getName());
//			// 包名称
//			container.put("package", targetClassClass.getPackage());
//			container.put("tenant", ContextUtil.getTenant());
//
//			// 参数列表
//			for (int i = 0; i < params.length; i++) {
//				container.put(String.valueOf(i), params[i]);
//			}
//			// 转为JSON字符串
//			String jsonString = JSONUtil.toJsonStr(container);
//			// 做SHA256 Hash计算，得到一个SHA256摘要作为Key
//			return DigestUtil.sha256Hex(jsonString);
//		};
//	}
//
//	@Bean
//	@Override
//	public CacheErrorHandler errorHandler() {
//		// 异常处理，当Redis发生异常时，打印日志，但是程序正常走
//		log.info("初始化 -> [{}]", "Redis CacheErrorHandler");
//		return new CacheErrorHandler() {
//			@Override
//			public void handleCacheGetError(RuntimeException e, Cache cache, Object key) {
//				log.error("Redis occur handleCacheGetError：key -> [{}]", key, e);
//			}
//
//			@Override
//			public void handleCachePutError(RuntimeException e, Cache cache, Object key, Object value) {
//				log.error("Redis occur handleCachePutError：key -> [{}]；value -> [{}]", key, value, e);
//			}
//
//			@Override
//			public void handleCacheEvictError(RuntimeException e, Cache cache, Object key) {
//				log.error("Redis occur handleCacheEvictError：key -> [{}]", key, e);
//			}
//
//			@Override
//			public void handleCacheClearError(RuntimeException e, Cache cache) {
//				log.error("Redis occur handleCacheClearError：", e);
//			}
//		};
//	}
//
//}
