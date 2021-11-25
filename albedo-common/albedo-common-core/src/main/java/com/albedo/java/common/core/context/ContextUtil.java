package com.albedo.java.common.core.context;

import cn.hutool.core.convert.Convert;
import com.albedo.java.common.core.basic.domain.BaseEntity;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.StrPool;
import com.alibaba.ttl.TransmittableThreadLocal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


/**
 * 获取当前线程变量中的 用户id、用户昵称、租户编码、账号等信息
 *
 * @author somewhere
 * @date 2017-12-13 16:52
 */
@Slf4j
public final class ContextUtil {
	/**
	 * 支持多线程传递参数
	 *
	 * @author tangyh
	 * @date 2021/6/23 9:26 下午
	 * @create [2021/6/23 9:26 下午 ] [tangyh] [初始创建]
	 */
	private static final ThreadLocal<Map<String, String>> THREAD_LOCAL = new TransmittableThreadLocal<>();

	private ContextUtil() {
	}

	public static void putAll(Map<String, String> map) {
		map.forEach((k, v) -> {
			set(k, v);
		});
	}

	public static void set(String key, Object value) {
		log.info("key: " + key + " value: " + value);
		Map<String, String> map = getLocalMap();
		map.put(key, value == null ? StrPool.EMPTY : value.toString());
	}

	public static <T> T get(String key, Class<T> type) {
		Map<String, String> map = getLocalMap();
		return Convert.convert(type, map.get(key));
	}

	public static <T> T get(String key, Class<T> type, Object def) {
		Map<String, String> map = getLocalMap();
		return Convert.convert(type, map.getOrDefault(key, String.valueOf(def == null ? StrPool.EMPTY : def)));
	}

	public static String get(String key) {
		Map<String, String> map = getLocalMap();
		return map.getOrDefault(key, StrPool.EMPTY);
	}

	public static Map<String, String> getLocalMap() {
		Map<String, String> map = THREAD_LOCAL.get();
		if (map == null) {
			map = new ConcurrentHashMap<>(10);
			THREAD_LOCAL.set(map);
		}
		return map;
	}

	public static void setLocalMap(Map<String, String> localMap) {
		THREAD_LOCAL.set(localMap);
	}

	/**
	 * 用户ID
	 *
	 * @return 用户ID
	 */
	public static Long getUserId() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return (Long) ClassUtil.invokeGetter(principal, BaseEntity.F_ID);
	}

	/**
	 * 获取租户编码
	 *
	 * @return 租户编码
	 */
	public static String getTenant() {
		String tenant = get(ContextConstants.JWT_KEY_TENANT, String.class, StrPool.EMPTY);
		log.info("tenant: " + tenant);
		return tenant;
	}

	public static void setTenant(String val) {
		set(ContextConstants.JWT_KEY_TENANT, val);
	}

	public static String getSubTenant() {
		return get(ContextConstants.JWT_KEY_SUB_TENANT, String.class, StrPool.EMPTY);
	}

	public static void setSubTenant(String val) {
		set(ContextConstants.JWT_KEY_SUB_TENANT, val);
	}

	public static String getClientId() {
		return get(ContextConstants.JWT_KEY_CLIENT_ID, String.class);
	}

	public static void setClientId(String val) {
		set(ContextConstants.JWT_KEY_CLIENT_ID, val);
	}

	/**
	 * 获取灰度版本号
	 *
	 * @return 灰度版本号
	 */
	public static String getGrayVersion() {
		return get(ContextConstants.GRAY_VERSION, String.class);
	}

	public static void setGrayVersion(String val) {
		set(ContextConstants.GRAY_VERSION, val);
	}

	public static void remove() {
		THREAD_LOCAL.remove();
	}

}
