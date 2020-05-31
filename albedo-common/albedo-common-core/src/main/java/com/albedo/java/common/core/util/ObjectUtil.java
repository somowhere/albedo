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
