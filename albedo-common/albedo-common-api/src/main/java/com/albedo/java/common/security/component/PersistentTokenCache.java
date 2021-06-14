/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
