package com.albedo.java.plugins.cache.repository.impl;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.plugins.cache.repository.CacheOps;
import com.albedo.java.plugins.cache.repository.CachePlusOps;
import com.albedo.java.common.core.cache.model.CacheHashKey;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.util.StrPool;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.lang.NonNull;

import java.util.*;
import java.util.concurrent.ConcurrentMap;
import java.util.function.Function;
import java.util.stream.Collectors;


/**
 * 基于 Caffeine 实现的内存缓存， 主要用于开发、测试、演示环境
 * 生产环境慎用！
 *
 * @author zuihou
 * @date 2019/08/07
 */
public class CaffeineOpsImpl implements CacheOps, CachePlusOps {
	/**
	 * 最大数量
	 */
	private static final long DEF_MAX_SIZE = 1_000;

	/**
	 * 为什么不直接用 Cache<String, Object> ？
	 * 因为想针对每一个key单独设置过期时间
	 */
	private final Cache<String, Cache<String, Object>> cacheMap = Caffeine.newBuilder()
		.maximumSize(DEF_MAX_SIZE)
		.build();

	@Override
	public Long del(@NonNull CacheKey... keys) {
		for (CacheKey key : keys) {
			cacheMap.invalidate(key.getKey());
		}
		return (long) keys.length;
	}

	@Override
	public Long del(String... keys) {
		for (String key : keys) {
			cacheMap.invalidate(key);
		}
		return (long) keys.length;
	}

	@Override
	public void set(@NonNull CacheKey key, Object value, boolean... cacheNullValues) {
		if (value == null) {
			return;
		}
		Caffeine<Object, Object> builder = Caffeine.newBuilder()
			.maximumSize(DEF_MAX_SIZE);
		if (key.getExpire() != null) {
			builder.expireAfterWrite(key.getExpire());
		}
		Cache<String, Object> cache = builder.build();
		cache.put(key.getKey(), value);
		cacheMap.put(key.getKey(), cache);
	}

	@Override
	public <T> T get(@NonNull CacheKey key, boolean... cacheNullValues) {
		Cache<String, Object> ifPresent = cacheMap.getIfPresent(key.getKey());
		if (ifPresent == null) {
			return null;
		}
		return (T) ifPresent.getIfPresent(key.getKey());
	}

	@Override
	public <T> T get(String key, boolean... cacheNullValues) {
		Cache<String, Object> ifPresent = cacheMap.getIfPresent(key);
		if (ifPresent == null) {
			return null;
		}
		return (T) ifPresent.getIfPresent(key);
	}

	@Override
	public <T> List<T> find(@NonNull Collection<CacheKey> keys) {
		return keys.stream().map(k -> (T) get(k, false)).filter(Objects::nonNull).collect(Collectors.toList());
	}

	@Override
	public <T> T get(@NonNull CacheKey key, Function<CacheKey, ? extends T> loader, boolean... cacheNullValues) {
		Cache<String, Object> cache = cacheMap.get(key.getKey(), (k) -> {
			Caffeine<Object, Object> builder = Caffeine.newBuilder()
				.maximumSize(DEF_MAX_SIZE);
			if (key.getExpire() != null) {
				builder.expireAfterWrite(key.getExpire());
			}
			Cache<String, Object> newCache = builder.build();
			newCache.get(k, (tk) -> loader.apply(new CacheKey(tk)));
			return newCache;
		});

		return (T) cache.getIfPresent(key.getKey());
	}

	@Override
	public void flushDb() {
		cacheMap.invalidateAll();
	}

	@Override
	public Boolean exists(@NonNull final CacheKey key) {
		Cache<String, Object> cache = cacheMap.getIfPresent(key.getKey());
		if (cache == null) {
			return false;
		}
		cache.cleanUp();
		return cache.estimatedSize() > 0;
	}

	@Override
	public Long incr(@NonNull CacheKey key) {
		Long old = get(key, k -> 0L);
		Long newVal = old + 1;
		set(key, newVal);
		return newVal;
	}

	@Override
	public Long getCounter(CacheKey key, Function<CacheKey, Long> loader) {
		return get(key);
	}

	@Override
	public Long incrBy(@NonNull CacheKey key, long increment) {
		Long old = get(key, k -> 0L);
		Long newVal = old + increment;
		set(key, newVal);
		return newVal;
	}

	@Override
	public Double incrByFloat(@NonNull CacheKey key, double increment) {
		Double old = get(key, k -> 0D);
		Double newVal = old + increment;
		set(key, newVal);
		return newVal;
	}

	@Override
	public Long decr(@NonNull CacheKey key) {
		Long old = get(key, k -> 0L);
		Long newVal = old - 1;
		set(key, newVal);
		return newVal;
	}

	@Override
	public Long decrBy(@NonNull CacheKey key, long decrement) {
		Long old = get(key, k -> 0L);
		Long newVal = old - decrement;
		set(key, newVal);
		return newVal;
	}
	// ---- 以下接口可能有问题，仅支持在开发环境使用

	/**
	 * KEYS * 匹配数据库中所有 key 。
	 * KEYS h?llo 匹配 hello ， hallo 和 hxllo 等。
	 * KEYS h*llo 匹配 hllo 和 heeeeello 等。
	 * KEYS h[ae]llo 匹配 hello 和 hallo ，但不匹配 hillo
	 *
	 * @param pattern 表达式
	 * @return 集合
	 */
	@Override
	public Set<String> keys(@NonNull String pattern) {
		if (StrUtil.isEmpty(pattern)) {
			return Collections.emptySet();
		}
		ConcurrentMap<String, Cache<String, Object>> map = cacheMap.asMap();
		Set<String> list = new HashSet<>();
		map.forEach((k, val) -> {
			// *
			if (StrPool.ASTERISK.equals(pattern)) {
				list.add(k);
				return;
			}
			// h?llo
			if (pattern.contains(StrPool.QUESTION_MARK)) {
				//待实现
				return;
			}
			// h*llo
			if (pattern.contains(StrPool.ASTERISK)) {
				//待实现
				return;
			}
			// h[ae]llo
			if (pattern.contains(StrPool.LEFT_SQ_BRACKET) && pattern.contains(StrPool.RIGHT_SQ_BRACKET)) {
				//待实现
				return;
			}
		});
		return list;
	}

	@Override
	public List<String> scan(String pattern) {
		return new ArrayList<>(keys(pattern));
	}

	@Override
	public void scanUnlink(String pattern) {
		Set<String> keys = keys(pattern);
		del(keys.stream().toArray(String[]::new));
	}

	@Override
	public Boolean expire(@NonNull CacheKey key) {
		return true;
	}

	@Override
	public Boolean persist(@NonNull CacheKey key) {
		return true;
	}

	@Override
	public String type(@NonNull CacheKey key) {
		return "caffeine";
	}

	@Override
	public Long ttl(@NonNull CacheKey key) {
		return -1L;
	}

	@Override
	public Long pTtl(@NonNull CacheKey key) {
		return -1L;
	}

	@Override
	public void hSet(@NonNull CacheHashKey key, Object value, boolean... cacheNullValues) {
		this.set(key.tran(), value, cacheNullValues);
	}

	@Override
	public <T> T hGet(@NonNull CacheHashKey key, boolean... cacheNullValues) {
		return get(key.tran(), cacheNullValues);
	}

	@Override
	public <T> T hGet(@NonNull CacheHashKey key, Function<CacheHashKey, T> loader, boolean... cacheNullValues) {
		Function<CacheKey, T> ckLoader = k -> loader.apply(key);
		return get(key.tran(), ckLoader, cacheNullValues);
	}

	@Override
	public Boolean hExists(@NonNull CacheHashKey cacheHashKey) {
		return exists(cacheHashKey.tran());
	}

	@Override
	public Long hDel(@NonNull String key, Object... fields) {
		for (Object field : fields) {
			cacheMap.invalidate(StrUtil.join(StrUtil.COLON, key, field));
		}
		return (long) fields.length;
	}

	@Override
	public Long hDel(@NonNull CacheHashKey cacheHashKey) {
		cacheMap.invalidate(cacheHashKey.tran().getKey());
		return 1L;
	}

	@Override
	public Long hLen(@NonNull CacheHashKey key) {
		return 0L;
	}

	@Override
	public Long hIncrBy(@NonNull CacheHashKey key, long increment) {
		return incrBy(key.tran(), increment);
	}

	@Override
	public Double hIncrBy(@NonNull CacheHashKey key, double increment) {
		return incrByFloat(key.tran(), increment);
	}

	@Override
	public Set<Object> hKeys(@NonNull CacheHashKey key) {
		return Collections.emptySet();
	}

	@Override
	public List<Object> hVals(@NonNull CacheHashKey key) {
		return Collections.emptyList();
	}

	@Override
	public <K, V> Map<K, V> hGetAll(CacheHashKey key) {
		return Collections.emptyMap();
	}

	@Override
	public <K, V> Map<K, V> hGetAll(CacheHashKey key, Function<CacheHashKey, Map<K, V>> loader, boolean... cacheNullValues) {
		return Collections.emptyMap();
	}

	@Override
	public Long sAdd(@NonNull CacheKey key, Object value) {
		return 0L;
	}

	@Override
	public Long sRem(@NonNull CacheKey key, Object... members) {
		return 0L;
	}

	@Override
	public Set<Object> sMembers(@NonNull CacheKey key) {
		return Collections.emptySet();
	}

	@Override
	public <T> T sPop(@NonNull CacheKey key) {
		return null;
	}

	@Override
	public Long sCard(@NonNull CacheKey key) {
		return 0L;
	}
}
