/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.util;

import cn.hutool.json.JSONUtil;
import com.albedo.java.common.core.constant.ScheduleConstants;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.*;

import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * Redis Cache 工具类
 *
 * @author somewhere
 * @version 2014-6-29
 */
@Slf4j
public class RedisUtil {

	public static RedisTemplate redisTemplate = SpringContextHolder.getBean("redisTemplate");

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

	/**
	 * 缓存基本的对象，Integer、String、实体类等
	 *
	 * @param key   缓存的键值
	 * @param value 缓存的值
	 * @return 缓存的对象
	 */
	public static ValueOperations<String, String> setCacheString(String key, String value) {
		ValueOperations<String, String> operation = redisTemplate.opsForValue();
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
	public static ValueOperations<String, String> setCacheString(String key, String value, long time,
																 TimeUnit timeUnit) {
		ValueOperations<String, String> operation = redisTemplate.opsForValue();
		operation.set(key, value, time, timeUnit);
		return operation;
	}

	public static boolean delete(String key) {
		boolean flag = redisTemplate.delete(key);
		log.debug("deleteStringLike key {} flag {}", key, flag);
		return flag;
	}

	public static Long deleteLike(String pattern) {
		Set<String> keys = redisTemplate.keys(pattern);
		Long count = redisTemplate.delete(keys);
		log.debug("deleteStringLike keys {} count {}", keys, count);
		return count;
	}

	/**
	 * @param prefix 前缀
	 * @param keys
	 */
	public static Long deleteLike(String prefix, Set<Long> keys) {
		Set<Object> delKeys = new HashSet<>();
		for (Long key : keys) {
			delKeys.addAll(redisTemplate.keys(new StringBuffer(prefix).append(key).toString()));
		}
		long count = redisTemplate.delete(delKeys);

		log.debug("deleteStringLike keys {} count {}", delKeys, count);
		return count;
	}

	/**
	 * 获得缓存的基本对象。
	 *
	 * @param key 缓存键值
	 * @return 缓存键值对应的数据
	 */
	public static String getCacheString(String key) {
		ValueOperations<String, String> operation = redisTemplate.opsForValue();
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
		if (log.isDebugEnabled()) {
			log.debug("sendScheduleChannelMessage===>" + JSONUtil.toJsonStr(message));
		}
		redisTemplate.convertAndSend(ScheduleConstants.REDIS_SCHEDULE_DEFAULT_CHANNEL, message);
	}

}
