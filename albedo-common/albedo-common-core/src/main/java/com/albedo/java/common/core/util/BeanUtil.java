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

package com.albedo.java.common.core.util;

import com.albedo.java.common.core.annotation.BeanField;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.FatalBeanException;
import org.springframework.cglib.beans.BeanMap;
import org.springframework.util.Assert;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;
import java.util.stream.Collectors;

/**
 * bean copy 工具类
 *
 * @author somewhere
 */
@Slf4j
@UtilityClass
public class BeanUtil extends cn.hutool.core.bean.BeanUtil {

	public static void copyProperties(Object source, Object target, boolean ignoreNull, String... ignoreProperties) {
		Assert.notNull(source, "Source must not be null");
		Assert.notNull(target, "Target must not be null");
		Class<?> actualEditable = target.getClass();

		PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
		List<String> ignoreList = ignoreProperties != null ? Arrays.asList(ignoreProperties) : null;
		PropertyDescriptor[] var7 = targetPds;
		int var8 = targetPds.length;

		for (int var9 = 0; var9 < var8; ++var9) {
			PropertyDescriptor targetPd = var7[var9];
			Method writeMethod = targetPd.getWriteMethod();
			boolean ignore = ignoreList == null || !ignoreList.contains(targetPd.getName());
			if (writeMethod != null && ignore) {
				BeanField writeAnnotation = ClassUtil.findAnnotation(target.getClass(), targetPd.getName(),
					BeanField.class);
				if (writeAnnotation != null && writeAnnotation.ingore()) {
					continue;
				}
				Object value = null;
				if (writeAnnotation != null && StringUtil.isNotEmpty(writeAnnotation.writeProperty())) {
					value = cn.hutool.core.bean.BeanUtil.getFieldValue(source, writeAnnotation.writeProperty());
				} else {
					PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
					if (sourcePd != null) {
						Method readMethod = sourcePd.getReadMethod();
						if (readMethod != null) {
							// &&
							// ClassUtils.isAssignable(writeMethod.getParameterTypes()[0],
							// readMethod.getReturnType())
							if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
								readMethod.setAccessible(true);
							}
							try {
								value = readMethod.invoke(source);
							} catch (Throwable var15) {
								throw new FatalBeanException(
									"Could not copy property '" + targetPd.getName() + "' from source to target",
									var15);
							}
							if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
								writeMethod.setAccessible(true);
							}
						}
					}
				}
				try {
					if (!ignoreNull || value != null) {
						writeMethod.invoke(target, value);
					}
				} catch (Throwable var15) {
					throw new FatalBeanException(
						"Could not copy property '" + targetPd.getName() + "' from source to target", var15);
				}

			}
		}

	}

	public static <T> T copyPropertiesByClass(Object source, Class<T> requiredType) {
		T target = null;
		try {
			target = requiredType.newInstance();
		} catch (Exception e) {
			log.error("{}", e);
		}
		try {
			copyProperties(source, target, true);
		} catch (Exception e) {
			log.error("{}", e);
		}
		return target;
	}

	/**
	 * 将对象装成map形式
	 *
	 * @param bean 源对象
	 * @return {Map}
	 */
	public static Map<String, Object> toMap(Object bean) {
		return BeanMap.create(bean);
	}

	/**
	 * 转换 list
	 *
	 * @param sourceList       源集合
	 * @param destinationClass 目标类型
	 * @return 目标集合
	 */
	public static <T, E> List<T> toBeanList(Collection<E> sourceList, Class<T> destinationClass) {
		if (sourceList == null || sourceList.isEmpty() || destinationClass == null) {
			return Collections.emptyList();
		}
		return sourceList.parallelStream()
			.filter(Objects::nonNull)
			.map(source -> toBean(source, destinationClass))
			.collect(Collectors.toList());
	}
}
