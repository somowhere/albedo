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

package com.albedo.java.modules.sys.component;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.cache.CacheManager;
import org.springframework.core.env.Environment;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.Set;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:08
 */
@Component
@Slf4j
@AllArgsConstructor
public class InitCacheDataComponent implements InitializingBean {

	private final Environment environment;

	private final CacheManager cacheManager;

	private final RedisTemplate redisTemplate;

	@Override
	public void afterPropertiesSet() {
		if (SpringContextHolder.isDevelopment(environment)) {
			Collection<String> cacheNames = cacheManager.getCacheNames();
			if (CollUtil.isNotEmpty(cacheNames)) {
				for (String cacheName : cacheNames) {
					cacheManager.getCache(cacheName).clear();
				}
			}
			Set keys = redisTemplate.keys("*details*");
			redisTemplate.delete(keys);
		}
	}

}
