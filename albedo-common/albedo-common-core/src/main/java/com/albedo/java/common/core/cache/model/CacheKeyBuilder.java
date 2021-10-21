package com.albedo.java.common.core.cache.model;


import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.StrPool;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;


/**
 * cache key
 *
 * @author somewhere
 */
@FunctionalInterface
public interface CacheKeyBuilder {

	/**
	 * 租户编码
	 * <p>
	 * 非租户模式设置成空字符串
	 *
	 * @return 租户编码
	 */
	@NonNull
	default String getTenant() {
		return ContextUtil.getTenant();
	}

	/**
	 * key 前缀
	 *
	 * @return key 前缀
	 */
	@NonNull
	String getPrefix();

	/**
	 * 超时时间
	 *
	 * @return 超时时间
	 */
	@Nullable
	default Duration getExpire() {
		return null;
	}

	/**
	 * 获取通配符
	 *
	 * @return key 前缀
	 */
	default String getPattern() {
		return StrUtil.format("*:{}:*", getPrefix());
	}


	/**
	 * 获取通配符
	 *
	 * @param tenant 企业编码
	 * @param suffix 前缀
	 * @return key 前缀
	 */
	default String getPattern(String tenant, Object... suffix) {
		String prefix = this.getPrefix();
		ArgumentAssert.notEmpty(prefix, "缓存前缀不能为空");

		List<String> regionList = new ArrayList<>();
		tenant = StrUtil.isEmpty(tenant) ? StrPool.STAR : tenant;
		// 企业id
		if (StrUtil.isNotEmpty(tenant)) {
			regionList.add(tenant);
		}
		// 缓存前缀
		regionList.add(prefix);

		for (Object s : suffix) {
			regionList.add(ObjectUtil.isNotEmpty(s) ? String.valueOf(s) : StrPool.STAR);
		}
		return CollUtil.join(regionList, StrPool.COLON);
	}

	/**
	 * 构建通用KV模式 的 cache key
	 * 兼容 redis caffeine
	 *
	 * @param suffix 参数
	 * @return cache key
	 */
	default CacheKey key(Object... suffix) {
		String field = suffix.length > 0 ? Convert.toStr(suffix[0], StrPool.EMPTY) : StrPool.EMPTY;
		return hashFieldKey(field, suffix);
	}

	/**
	 * 构建 redis 类型的 hash cache key
	 *
	 * @param field  field
	 * @param suffix 动态参数
	 * @return cache key
	 */
	default CacheHashKey hashFieldKey(@NonNull Object field, Object... suffix) {
		String key = getKey(suffix);

		ArgumentAssert.notEmpty(key, "key 不能为空");
		ArgumentAssert.notNull(field, "field 不能为空");
		return new CacheHashKey(key, field, getExpire());
	}

	/**
	 * 构建 redis 类型的 hash cache key （无field)
	 *
	 * @param suffix 动态参数
	 * @return
	 */
	default CacheHashKey hashKey(Object... suffix) {
		String key = getKey(suffix);

		ArgumentAssert.notEmpty(key, "key 不能为空");
		return new CacheHashKey(key, null, getExpire());
	}

	/**
	 * 根据动态参数 拼接参数
	 *
	 * @param suffix 动态参数
	 * @return
	 */
	default String getKey(Object... suffix) {
		ArrayList<String> regionList = new ArrayList<>();
		String tenant = this.getTenant();
		if (StrUtil.isNotEmpty(tenant)) {
			regionList.add(tenant);
		}
		String prefix = this.getPrefix();
		ArgumentAssert.notEmpty(prefix, "缓存前缀不能为空");
		regionList.add(prefix);

		for (Object s : suffix) {
			if (ObjectUtil.isNotEmpty(s)) {
				regionList.add(String.valueOf(s));
			}
		}
		return CollUtil.join(regionList, StrPool.COLON);
	}
}
