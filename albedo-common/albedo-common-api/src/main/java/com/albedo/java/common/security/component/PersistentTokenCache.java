package com.albedo.java.common.security.component;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
public class PersistentTokenCache<T> {
	private final long expireMillis;
	private final Map<String, Value> map;
	private long latestWriteTime;

	public PersistentTokenCache(long expireMillis) {
		if (expireMillis <= 0L) {
			throw new IllegalArgumentException();
		} else {
			this.expireMillis = expireMillis;
			this.map = new LinkedHashMap(64, 0.75F);
			this.latestWriteTime = System.currentTimeMillis();
		}
	}

	public T get(String key) {
		this.purge();
		PersistentTokenCache<T>.Value val = this.map.get(key);
		long time = System.currentTimeMillis();
		return val != null && time < val.expire ? val.token : null;
	}

	public void put(String key, T token) {
		this.purge();
		this.map.remove(key);

		long time = System.currentTimeMillis();
		this.map.put(key, new PersistentTokenCache.Value(token, time + this.expireMillis));
		this.latestWriteTime = time;
	}

	public int size() {
		return this.map.size();
	}

	public void purge() {
		long time = System.currentTimeMillis();
		if (time - this.latestWriteTime > this.expireMillis) {
			this.map.clear();
		} else {
			Iterator values = this.map.values().iterator();

			while (values.hasNext() && time >= ((PersistentTokenCache.Value) values.next()).expire) {
				values.remove();
			}
		}

	}

	private class Value {
		private final T token;
		private final long expire;

		Value(T token, long expire) {
			this.token = token;
			this.expire = expire;
		}
	}
}
