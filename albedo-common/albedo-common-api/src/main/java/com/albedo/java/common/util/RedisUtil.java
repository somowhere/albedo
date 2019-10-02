package com.albedo.java.common.util;

import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.util.Json;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.vo.ScheduleVo;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.*;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Jedis Cache 工具类
 *
 * @version 2014-6-29
 */
@Slf4j
public class RedisUtil {

	public static RedisTemplate redisTemplate = SpringContextHolder.getBean("redisTemplate");
	public static StringRedisTemplate stringRedisTemplate = SpringContextHolder.getBean("stringRedisTemplate");

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 * @return 缓存的对象
	 */
	public static <T> ValueOperations<String, T> setCacheObject(String key, T value) {
		ValueOperations<String, T> operation = redisTemplate.opsForValue();
		operation.set(key, value);
		return operation;
	}

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 * @return 缓存的对象
	 */
	public static <T> ValueOperations<String, T> setCacheObject(String key, T value, long time, TimeUnit timeUnit) {
		ValueOperations<String, T> operation = redisTemplate.opsForValue();

		operation.set(key, value, time, timeUnit);
		return operation;
	}

	public static void delete(String key) {
		redisTemplate.delete(key);
	}

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 * @return 缓存的对象
	 */
	public static ValueOperations<String, String> setCacheString(String key, String value) {
		ValueOperations<String, String> operation = stringRedisTemplate.opsForValue();
		operation.set(key, value);
		return operation;
	}

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 * @return 缓存的对象
	 */
	public static ValueOperations<String, String> setCacheString(String key, String value, long time, TimeUnit timeUnit) {
		ValueOperations<String, String> operation = stringRedisTemplate.opsForValue();
		operation.set(key, value, time, timeUnit);
		return operation;
	}

	public static Long deleteStringLike(String pattern) {
		Set<String> keys = stringRedisTemplate.keys(pattern);
		log.info("deleteStringLike keys {}", keys);
		return stringRedisTemplate.delete(keys);

	}

	/**
	 * 获得缓存的基本对象。
	 *
	 * @param key 缓存键值
	 * @return 缓存键值对应的数据
	 */
	public static String getCacheString(String key) {
		ValueOperations<String, String> operation = stringRedisTemplate.opsForValue();
		return operation.get(key);
	}

	/**
	 * 获得缓存的基本对象。
	 *
	 * @param key 缓存键值
	 * @return 缓存键值对应的数据
	 */
	public static <T> T getCacheObject(String key) {
		ValueOperations<String, T> operation = redisTemplate.opsForValue();
		return operation.get(key);
	}

	/**
	 * 缓存List数据
	 *
	 * @param key      缓存的键值
	 * @param dataList 待缓存的List数据
	 * @return 缓存的对象
	 */
	public static <T> ListOperations<String, T> setCacheList(String key, List<T> dataList) {
		ListOperations listOperation = redisTemplate.opsForList();
		if (null != dataList) {
			int size = dataList.size();
			for (int i = 0; i < size; i++) {
				listOperation.leftPush(key, dataList.get(i));
			}
		}
		return listOperation;
	}

	/**
	 * 获得缓存的list对象
	 *
	 * @param key 缓存的键值
	 * @return 缓存键值对应的数据
	 */
	public static <T> List<T> getCacheList(String key) {
		List<T> dataList = Lists.newArrayList();
		ListOperations<String, T> listOperation = redisTemplate.opsForList();
		Long size = listOperation.size(key);

		for (int i = 0; i < size; i++) {
			dataList.add(listOperation.index(key, i));
		}
		return dataList;
	}

	/**
	 * 缓存Set
	 *
	 * @param key     缓存键值
	 * @param dataSet 缓存的数据
	 * @return 缓存数据的对象
	 */
	public static <T> BoundSetOperations<String, T> setCacheSet(String key, Set<T> dataSet) {
		BoundSetOperations<String, T> setOperation = redisTemplate.boundSetOps(key);
		Iterator<T> it = dataSet.iterator();
		while (it.hasNext()) {
			setOperation.add(it.next());
		}
		return setOperation;
	}

	/**
	 * 获得缓存的set
	 *
	 * @param key
	 * @return
	 */
	public static <T> Set<T> getCacheSet(String key) {
		Set<T> dataSet = Sets.newHashSet();
		BoundSetOperations<String, T> operation = redisTemplate.boundSetOps(key);
		Long size = operation.size();
		for (int i = 0; i < size; i++) {
			dataSet.add(operation.pop());
		}
		return dataSet;
	}

	/**
	 * 缓存Map
	 *
	 * @param key
	 * @param dataMap
	 * @return
	 */
	public static <T> HashOperations<String, String, T> setCacheMap(String key, Map<String, T> dataMap) {

		HashOperations hashOperations = redisTemplate.opsForHash();
		if (null != dataMap) {
			for (Map.Entry<String, T> entry : dataMap.entrySet()) {
				hashOperations.put(key, entry.getKey(), entry.getValue());
			}
		}
		return hashOperations;
	}

	/**
	 * 获得缓存的Map
	 *
	 * @param key
	 * @return
	 */
	public static <T> Map<String, T> getCacheMap(String key) {
		Map<String, T> map = redisTemplate.opsForHash().entries(key);
		return map;
	}


	/**
	 * 缓存Map
	 *
	 * @param key
	 * @param dataMap
	 * @return
	 */
	public static <T> HashOperations<String, Integer, T> setCacheIntegerMap(String key, Map<Integer, T> dataMap) {
		HashOperations hashOperations = redisTemplate.opsForHash();
		if (null != dataMap) {
			for (Map.Entry<Integer, T> entry : dataMap.entrySet()) {
				hashOperations.put(key, entry.getKey(), entry.getValue());
			}
		}
		return hashOperations;
	}

	/**
	 * 获得缓存的Map
	 *
	 * @param key
	 * @return
	 */
	public static <T> Map<Integer, T> getCacheIntegerMap(String key) {
		Map<Integer, T> map = redisTemplate.opsForHash().entries(key);
		return map;
	}

	public static RedisTemplate getRedisTemplate() {
		return redisTemplate;
	}

	public static void sendScheduleChannelMessage(Object message) {
		if(log.isDebugEnabled()){
			log.debug("sendScheduleChannelMessage===>" + Json.toJSONString(message));
		}
		stringRedisTemplate.convertAndSend(ScheduleConstants.REDIS_SCHEDULE_DEFAULT_CHANNEL,
			Json.toJSONString(message));
	}
}
