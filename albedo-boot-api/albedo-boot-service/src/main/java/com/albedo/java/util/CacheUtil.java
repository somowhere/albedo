//package com.albedo.java.util;
//
//import com.albedo.java.util.spring.SpringContextHolder;
//import org.springframework.cache.Cache;
//import org.springframework.cache.CacheManager;
//
///**
// * Cache工具类
// *
// * @author lijie
// * @version 2014-4-29
// */
//public class CacheUtil {
//
//    /*** 系统 缓存 */
//    private static final String CACHE_SYS = "systemCache";
//    static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);
//
//    /**
//     * 获得一个Cache，没有则创建一个。
//     *
//     * @param cacheName
//     * @return
//     */
//    public static Cache getCache(String cacheName) {
//        Cache cache = cacheManager.getCache(cacheName);
//        if (cache == null) {
//            cacheManager.
//            if (!cacheManager.cacheExists(cacheName)) {
//                cacheManager.addCache(cacheName);
//            }
//            cache = cacheManager.getCache(cacheName);
//            cache.getCacheConfiguration().setEternal(true);
//        }
//        return cache;
//    }
//
//    public static CacheManager getCacheManager() {
//        return cacheManager;
//    }
//
//    public static Object get(String key) {
//        // return MemcacheUtil.get(key);
//        return get(CACHE_SYS, key);
//    }
//
//    public static void put(String key, Object value) {
//        put(CACHE_SYS, key, value);
//        // MemcacheUtil.set(key, value);
//    }
//
//    public static void put(String key, Object value, int timeToLiveSeconds) {
//        put(CACHE_SYS, key, value, timeToLiveSeconds);
//        // MemcacheUtil.set(key, value);
//    }
//
//    /**
//     * 清空指定Key的系统缓存对象
//     *
//     * @param key
//     */
//    public static void remove(String key) {
//        remove(CACHE_SYS, key);
//        // MemcacheUtil.delete(key);
//    }
//
//    /**
//     * 清空所有系统缓存
//     */
//    public static void clearAllCacheSystem() {
//        getCache(CACHE_SYS).removeAll();
//        // MemcacheUtil.delete(key);
//    }
//
//    public static Object get(String cacheName, String key) {
//        Element element = getCache(cacheName).get(key);
//        return element == null ? null : element.getObjectValue();
//    }
//
//
//    public static <T> T getJson(String cacheName, String key, Class<T> clazz) {
//        Element element = getCache(cacheName).get(key);
//        String value = element == null ? null : PublicUtil.toStrString(element.getObjectValue());
//        T obj = Json.parseObject(value, clazz);
//        return obj;
//    }
//
//
//    public static void put(String cacheName, String key, Object value) {
//        put(cacheName, key, value, 0);
//    }
//
//    public static void put(String cacheName, String key, Object value, int timeToLiveSeconds) {
//        Element element = new Element(key, value);
//        if (timeToLiveSeconds > 0) element.setTimeToLive(timeToLiveSeconds);
//        getCache(cacheName).put(element);
//    }
//
//
//    public static void remove(String cacheName, String key) {
//        getCache(cacheName).remove(key);
//    }
//
//    public static void removeCache(String cacheName) {
//        getCache(cacheName).removeAll();
//    }
//
//}
