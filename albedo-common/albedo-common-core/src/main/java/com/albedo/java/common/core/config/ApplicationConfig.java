/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.common.core.config;

import com.albedo.java.common.core.util.StrPool;
import com.albedo.java.common.core.util.StringUtil;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.yaml.snakeyaml.Yaml;

import java.io.InputStream;
import java.util.Map;

/**
 * 系统配置类
 *
 * @author somewhere version 2014-1-20 下午4:06:33
 */
@Slf4j
public class ApplicationConfig {

	private static java.util.Map<String, Object> props = null;

    private static final java.util.Map<String, String> paramMap = Maps.newHashMap();

	static {
		try {
			reload();
		} catch (Exception e) {
            log.error("failed init", e);
		}
	}

	/**
	 * 将构造函数私有化，不能new实例
	 */
	private ApplicationConfig() {

	}

	public static Object getProperty(Map<?, ?> map, Object qualifiedKey) {
		if (map != null && !map.isEmpty() && qualifiedKey != null) {
			String input = String.valueOf(qualifiedKey);
			if (!"".equals(input)) {
				if (input.contains(StrPool.DOT)) {
					int index = input.indexOf(StrPool.DOT);
					String left = input.substring(0, index);
					String right = input.substring(index + 1);
					return getProperty((Map<?, ?>) map.get(left), right);
				} else if (map.containsKey(input)) {
					return map.get(input);
				} else {
					return null;
				}
			}
		}
		return null;
	}

	/**
	 * 获取配置信息的静态方法。
	 *
	 * @param name - 要获取的配置信息的名称
	 * @return - 配置信息。如果不存在，返回null
	 */
	public static String get(String name) {
		String value = paramMap.get(name);
		if (value == null) {
			value = StringUtil.toStrString(getProperty(props, name));
			paramMap.put(name, value != null ? value : StringUtil.EMPTY);
		}
		return value;
	}

	/**
	 * 重新装载配置信息。
	 *
	 * @throws Exception
	 */
	public static void reload() throws Exception {
		if (props == null) {
			props = Maps.newHashMap();
		}

		PathMatchingResourcePatternResolver resourceLoader = new PathMatchingResourcePatternResolver();
		InputStream is = resourceLoader.getResources("classpath*:/config/application.yml")[0].getInputStream();
		// in
		// the
		// classpath
		props = new Yaml().load(is);
		// dumpSystemConfig();
	}

	/**
	 * 获取文件上传路径
	 */
	public static String getStaticFileDirectory() {
		return get("application.file.local.storage-path");
	}

}
