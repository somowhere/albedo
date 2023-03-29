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

import cn.hutool.core.bean.BeanUtil;
import com.albedo.java.common.core.domain.vo.ComboData;
import com.albedo.java.common.core.domain.vo.SelectVo;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.google.common.collect.Lists;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:24 下午
 */
@UtilityClass
@Slf4j
public class CollUtil extends cn.hutool.core.collection.CollUtil {

	/**
	 * 转换Collection所有元素(通过toString())为String, 中间以 separator分隔。
	 */
	public static String convertToString(final Collection collection, final String separator) {
		return cn.hutool.core.collection.CollUtil.join(collection, separator);
	}

	/**
	 * 转换Collection所有元素(通过toString())为String, 中间以 separator分隔。
	 */
	public static String convertToString(final Collection collection, final String propertyName,
										 final String separator) {
		List list = extractToList(collection, propertyName);
		return convertToString(list, separator);
	}

	/**
	 * 提取集合中的对象的一个属性(通过Getter函数), 组合成List.
	 *
	 * @param collection   来源集合.
	 * @param propertyName 要提取的属性名.
	 */
	@SuppressWarnings("unchecked")
	public static List extractToList(final Collection collection, final String propertyName) {
		List list = Lists.newArrayList();
		try {
			if (collection != null) {
				Object item = null;
				for (Object obj : collection) {
					if (obj instanceof Map) {
						item = ((Map) obj).get(propertyName);
					} else {
						item = BeanUtil.getFieldValue(obj, propertyName);
					}
					if (item != null) {
						list.add(item);
					}
				}
			}
		} catch (Exception e) {
			throw e;
		}

		return list;
	}

	public static List<ComboData> convertComboDataList(List<?> dataList, String idFieldName, String nameFieldName) {
		List<ComboData> comboDataList = Lists.newArrayList();
		dataList.forEach(item -> comboDataList
			.add(new ComboData(StringUtil.toStrString(BeanUtil.getFieldValue(item, idFieldName)),
				StringUtil.toStrString(ClassUtil.invokeGetter(item, nameFieldName)))));
		return comboDataList;
	}

	public static List<SelectVo> convertSelectVoList(List<?> dataList, String idFieldName, String nameFieldName) {
		List<SelectVo> selectVoList = Lists.newArrayList();
		dataList.forEach(
			item -> selectVoList.add(new SelectVo(StringUtil.toStrString(BeanUtil.getFieldValue(item, idFieldName)),
				StringUtil.toStrString(ClassUtil.invokeGetter(item, nameFieldName)))));
		return selectVoList;
	}

	/**
	 * 从list中取第一条数据返回对应List中泛型的单个结果
	 *
	 * @param list ignore
	 * @param <E>  ignore
	 * @return ignore
	 */
	public static <E> E getObject(List<E> list) {
		if (CollectionUtils.isNotEmpty(list)) {
			int size = list.size();
			if (size > 1) {
				log.warn(String.format("Warn: execute Method There are  %s results.", size));
			}
			return list.get(0);
		}
		return null;
	}

}
