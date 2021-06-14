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

package com.albedo.java.common.core.util;

import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:09
 */
@UtilityClass
@Slf4j
public class ObjectUtil extends cn.hutool.core.util.ObjectUtil {

	/**
	 * 判断某个对象是否为空 集合类、数组做特殊处理
	 *
	 * @param obj
	 * @return 如为不空，集合size>0|字符串不为空串|数组length>0 返回true,否则false
	 * @author somewhere
	 */
	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}

	/**
	 * 判断某个对象是否为空 集合类、数组做特殊处理
	 *
	 * @param obj
	 * @return 如为空，返回true,否则false
	 * @author somewhere
	 */
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}
		// 如果不为null，需要处理几种特殊对象类型
		if (obj instanceof String) {
			return "".equals(obj);
		} else if (obj instanceof Collection) {
			// 对象为集合
			Collection coll = (Collection) obj;
			return coll.size() == 0;
		} else if (obj instanceof Map) {
			// 对象为Map
			Map map = (Map) obj;
			return map.size() == 0;
		} else if (obj.getClass().isArray()) {
			// 对象为数组
			return Array.getLength(obj) == 0;
		} else {
			// 其他类型，只要不为null，即不为empty
			return false;
		}
	}

}
