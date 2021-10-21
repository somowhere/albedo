package com.albedo.java.cache.repository.impl;

import com.albedo.java.cache.redis.RedisOps;
import com.albedo.java.cache.repository.CacheOps;
import com.albedo.java.cache.repository.CachePlusOps;
import com.albedo.java.common.core.cache.model.CacheHashKey;
import com.albedo.java.common.core.cache.model.CacheKey;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.lang.NonNull;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;

/**
 * Redis Repository
 * redis 基本操作 可扩展,基本够用了
 *
 * @author zuihou
 * @date 2019-08-06 10:42
 */
@Slf4j
public class RedisOpsImpl implements CacheOps, CachePlusOps {

	/**
	 * Spring Redis Template
	 */
	private final RedisOps redisOps;

	public RedisOpsImpl(RedisOps redisOps) {
		this.redisOps = redisOps;
	}

	/**
	 * 获取 RedisTemplate对象
	 */
	public RedisTemplate<String, Object> getRedisTemplate() {
		return redisOps.getRedisTemplate();
	}

	@Override
	public Long del(@NonNull CacheKey... keys) {
		return redisOps.del(keys);
	}

	@Override
	public Long del(String... keys) {
		return redisOps.del(keys);
	}

	@Override
	public Boolean exists(@NonNull CacheKey key) {
		return redisOps.exists(key.getKey());
	}

	@Override
	public void set(@NonNull CacheKey key, Object value, boolean... cacheNullValues) {
		redisOps.set(key, value, cacheNullValues);
	}

	@Override
	public <T> T get(@NonNull CacheKey key, boolean... cacheNullValues) {
		return redisOps.get(key, cacheNullValues);
	}

	@Override
	public <T> T get(String key, boolean... cacheNullValues) {
		return redisOps.get(key, cacheNullValues);
	}

	@Override
	public <T> List<T> find(@NonNull Collection<CacheKey> keys) {
		return redisOps.mGetByCacheKey(keys);
	}

	@Override
	public <T> T get(@NonNull CacheKey key, Function<CacheKey, ? extends T> loader, boolean... cacheNullValues) {
		return redisOps.get(key, loader, cacheNullValues);
	}

	/**
	 * 清空redis存储的数据
	 */
	@Override
	public void flushDb() {
		redisOps.getRedisTemplate().execute((RedisCallback<String>) connection -> {
			connection.flushDb();
			return "ok";
		});
	}

	@Override
	public Long incr(@NonNull CacheKey key) {
		return redisOps.incr(key);
	}

	@Override
	public Long getCounter(CacheKey key, Function<CacheKey, Long> loader) {
		return redisOps.getCounter(key, loader);
	}

	@Override
	public Long incrBy(@NonNull CacheKey key, long increment) {
		return redisOps.incrBy(key, increment);
	}

	@Override
	public Double incrByFloat(@NonNull CacheKey key, double increment) {
		return redisOps.incrByFloat(key, increment);
	}

	@Override
	public Long decr(@NonNull CacheKey key) {
		return redisOps.decr(key);
	}

	@Override
	public Long decrBy(@NonNull CacheKey key, long decrement) {
		return redisOps.decrBy(key, decrement);
	}

	@Override
	public Set<String> keys(@NonNull String pattern) {
		return redisOps.keys(pattern);
	}

	@Override
	public List<String> scan(String pattern) {
		return redisOps.scan(pattern);
	}

	@Override
	public void scanUnlink(String pattern) {
		redisOps.scanUnlink(pattern);
	}

	@Override
	public Boolean expire(@NonNull CacheKey key) {
		assert key.getExpire() != null;
		return redisOps.expire(key.getKey(), key.getExpire());
	}

	@Override
	public Boolean persist(@NonNull CacheKey key) {
		return redisOps.persist(key.getKey());
	}

	@Override
	public String type(@NonNull CacheKey key) {
		return redisOps.type(key.getKey());
	}

	@Override
	public Long ttl(@NonNull CacheKey key) {
		return redisOps.ttl(key.getKey());
	}

	@Override
	public Long pTtl(@NonNull CacheKey key) {
		return redisOps.pTtl(key.getKey());
	}

	@Override
	public void hSet(@NonNull CacheHashKey key, Object value, boolean... cacheNullValues) {
		redisOps.hSet(key, value, cacheNullValues);
	}

	@Override
	public <T> T hGet(@NonNull CacheHashKey key, boolean... cacheNullValues) {
		return redisOps.hGet(key, cacheNullValues);
	}

	@Override
	public <T> T hGet(@NonNull CacheHashKey key, Function<CacheHashKey, T> loader, boolean... cacheNullValues) {
		return redisOps.hGet(key, loader, cacheNullValues);
	}

	@Override
	public Boolean hExists(@NonNull CacheHashKey cacheHashKey) {
		return redisOps.hExists(cacheHashKey);
	}

	@Override
	public Long hDel(@NonNull String key, Object... fields) {
		return redisOps.hDel(key, fields);
	}

	@Override
	public Long hDel(@NonNull CacheHashKey cacheHashKey) {
		return redisOps.hDel(cacheHashKey.getKey(), cacheHashKey.getField());
	}

	@Override
	public Long hLen(@NonNull CacheHashKey key) {
		return redisOps.hLen(key.getKey());
	}

	@Override
	public Long hIncrBy(@NonNull CacheHashKey key, long increment) {
		return redisOps.hIncrBy(key, increment);
	}

	@Override
	public Double hIncrBy(@NonNull CacheHashKey key, double increment) {
		return redisOps.hIncrByFloat(key, increment);
	}

	@Override
	public Set<Object> hKeys(@NonNull CacheHashKey key) {
		return redisOps.hKeys(key.getKey());
	}

	@Override
	public List<Object> hVals(@NonNull CacheHashKey key) {
		return redisOps.hVals(key.getKey());
	}


	@Override
	public <K, V> Map<K, V> hGetAll(@NonNull CacheHashKey key) {
		return redisOps.hGetAll(key);
	}

	@Override
	public <K, V> Map<K, V> hGetAll(@NonNull CacheHashKey key, Function<CacheHashKey, Map<K, V>> loader, boolean... cacheNullValues) {
		return redisOps.hGetAll(key, loader, cacheNullValues);
	}


	@Override
	public Long sAdd(@NonNull CacheKey key, Object value) {
		Long result = redisOps.sAdd(key, value);
		if (key.getExpire() != null) {
			redisOps.expire(key.getKey(), key.getExpire());
		}
		return result;
	}

	@Override
	public Long sRem(@NonNull CacheKey key, Object... members) {
		return redisOps.sRem(key, members);
	}

	@Override
	public Set<Object> sMembers(@NonNull CacheKey key) {
		return redisOps.sMembers(key);
	}

	@Override
	public <T> T sPop(@NonNull CacheKey key) {
		return redisOps.sPop(key);
	}

	@Override
	public Long sCard(@NonNull CacheKey key) {
		return redisOps.sCard(key);
	}
}
