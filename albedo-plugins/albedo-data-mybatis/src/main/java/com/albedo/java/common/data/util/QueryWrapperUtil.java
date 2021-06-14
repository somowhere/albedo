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

package com.albedo.java.common.data.util;

import cn.hutool.core.util.CharUtil;
import cn.hutool.core.util.ReflectUtil;
import com.albedo.java.common.core.annotation.Query;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by somewhere on 2018/3/8.
 *
 * @author somewhere
 */
@UtilityClass
@Slf4j
public class QueryWrapperUtil {

	public static Wrapper<?> fillWrapperOrder(Page<?> page, Wrapper<?> wrapper) {
		if (null == page) {
			return wrapper;
		}
		if (ObjectUtil.isEmpty(page.orders())) {
			return wrapper;
		}
		QueryWrapper queryWrapper = null == wrapper ? new QueryWrapper() : (QueryWrapper) wrapper;
		if (ObjectUtil.isNotEmpty(page.orders())) {
			page.orders().forEach(orderItem -> queryWrapper.orderBy(true, orderItem.isAsc(),
				StringUtil.toRevertCamelCase(orderItem.getColumn(), CharUtil.UNDERLINE)));
			page.setOrders(null);
		}
		return queryWrapper;
	}

	public static <T> QueryWrapper<T> getWrapper(PageModel<T> pageModel, Object query) {
		return (QueryWrapper) fillWrapperOrder(pageModel, getWrapper(query));
	}

	public static <T> QueryWrapper<T> getWrapper(Object query) {
		QueryWrapper<T> entityWrapper = Wrappers.query();
		if (query == null) {
			return entityWrapper;
		}
		Field[] fields = ReflectUtil.getFields(query.getClass());
		try {
			for (Field field : fields) {
				boolean accessible = field.isAccessible();
				field.setAccessible(true);
				Query q = field.getAnnotation(Query.class);
				if (q != null) {
					String propName = q.propName();
					String blurry = q.blurry();
					String attributeName = StringUtil.isEmpty(propName) ? StringUtil.toRevertCamelCase(field.getName(), CharUtil.UNDERLINE) : propName;
					Object val = field.get(query);
					if (cn.hutool.core.util.ObjectUtil.isNull(val) || "".equals(val)) {
						continue;
					}
					// 模糊多字段
					if (cn.hutool.core.util.ObjectUtil.isNotEmpty(blurry)) {
						String[] blurrys = blurry.split(",");
						entityWrapper.and(i -> {
							for (String s : blurrys) {
								i.or().like(s, val.toString());
							}
						});
						continue;
					}
					parseWarpper(entityWrapper, q, attributeName, val);
				}
				field.setAccessible(accessible);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return entityWrapper;
	}


	private static void parseWarpper(QueryWrapper<?> entityWrapper, Query q, String attributeName, Object val) {
		switch (q.operator()) {
			case eq:
				entityWrapper.eq(attributeName, val);
				break;
			case ne:
				entityWrapper.ne(attributeName, val);
				break;
			case gt:
				entityWrapper.gt(attributeName, val);
				break;
			case ge:
				entityWrapper.ge(attributeName, val);
				break;
			case lt:
				entityWrapper.lt(attributeName, val);
				break;
			case le:
				entityWrapper.le(attributeName, val);
				break;
			case like:
				entityWrapper.like(attributeName, val);
				break;
			case notLike:
				entityWrapper.notLike(attributeName, val);
				break;
			case likeLeft:
				entityWrapper.likeLeft(attributeName, val);
				break;
			case likeRight:
				entityWrapper.likeRight(attributeName, val);
				break;
			case in:
				entityWrapper.in(attributeName, (Collection<?>) val);
				break;
			case notIn:
				entityWrapper.notIn(attributeName, (Collection<?>) val);
				break;
			case isNotNull:
				entityWrapper.isNotNull(attributeName);
				break;
			case isNull:
				entityWrapper.isNull(attributeName);
				break;
			case between:
				List<Object> between = new ArrayList<>((List<Object>) val);
				entityWrapper.between(attributeName, between.get(0), between.get(1));
				break;
			default:
				break;
		}
	}

}
