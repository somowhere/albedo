package com.albedo.java.common.core.cache.model;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.StrPool;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.lang.NonNull;

import java.time.Duration;


/**
 * hash 缓存 key 封装
 *
 * @author somewhere
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class CacheHashKey extends CacheKey {
	/**
	 * redis hash field
	 */
	@NonNull
	private Object field;

	public CacheHashKey(@NonNull String key, final @NonNull Object field) {
		super(key);
		this.field = field;
	}

	public CacheHashKey(@NonNull String key, final @NonNull Object field, Duration expire) {
		super(key, expire);
		this.field = field;
	}

	public CacheKey tran() {
		return new CacheKey(StrUtil.join(StrPool.COLON, getKey(), getField()), getExpire());
	}
}
