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

package com.albedo.java.modules.sys.util;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.domain.vo.SelectVo;
import com.albedo.java.common.core.enumeration.BaseEnum;
import com.albedo.java.common.core.util.*;
import com.albedo.java.modules.sys.cache.DictCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.DictDo;
import com.albedo.java.modules.sys.feign.RemoteDictService;
import com.albedo.java.plugins.cache.repository.CacheOps;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 数据字典工具类 copyright 2014 albedo all right reserved author somewhere created on 2015年1月27日
 * 上午9:52:55
 *
 * @author somewhere
 */
@Slf4j
public class DictUtil {


	public static CacheOps cacheOps = SpringContextHolder.getBean("cacheOps");

	public static RemoteDictService dictService = SpringContextHolder.getBean(RemoteDictService.class);

	public static Set<Class<? extends BaseEnum>> baseEnums = ClassUtil.getAllInterfaceAchieveClass(BaseEnum.class, CommonConstants.BUSINESS_PACKAGE);

	public static List<DictDo> getDictList() {
		return cacheOps.get(new DictCacheKeyBuilder().key(CacheNameConstants.DICT_ALL), (k) -> dictService.findAllOrderBySort());
	}

	public static List<DictDo> getDictListByParentCode(String code) {
		Optional<DictDo> first = getDictList().stream().filter(dict -> dict.getCode().equals(code)).findFirst();
		return getDictList().stream().filter(dict -> first.get().getId().equals(dict.getParentId()))
			.collect(Collectors.toList());
	}

	public static Map<String, List<SelectVo>> convertSelectVoMapByCodes(String... codes) {
		return convertSelectVoMapByCodes(DictUtil.getDictList(), codes);
	}

	public static Map<String, List<SelectVo>> convertBaseEnumToSelectVo(String[] codes) {
		if (ArrayUtil.isNotEmpty(baseEnums)) {
			Map<String, List<SelectVo>> selectVoMap = Maps.newHashMap();
			for (Class<? extends BaseEnum> baseEnumClass : baseEnums) {
				String simpleName = StringUtil.toRevertCamelCase(StringUtil.lowerFirst(baseEnumClass.getSimpleName()), CharUtil.UNDERLINE);
				boolean containsKey = selectVoMap.containsKey(simpleName),
					hitCode = (ArrayUtil.isEmpty(codes) || ArrayUtil.contains(codes, simpleName));
				if (!containsKey && hitCode) {
					ArgumentAssert.isTrue(baseEnumClass.isEnum(), "this is not enum form BaseEnum " + baseEnumClass + " !!!");
					List<SelectVo> selectVoList = Lists.newArrayList();
					for (BaseEnum enumConstant : baseEnumClass.getEnumConstants()) {
						selectVoList.add(SelectVo.builder()
							.value(enumConstant.getCode())
							.label(enumConstant.getText()).build());
					}
					selectVoMap.put(simpleName, selectVoList);
				}
			}
			return selectVoMap;
		}
		return null;
	}

	public static Map<String, List<SelectVo>> convertSelectVoMapByCodes(List<DictDo> dictDoList, String... codes) {
		Map<String, List<SelectVo>> map = Maps.newHashMap();
		if (ObjectUtil.isEmpty(dictDoList)) {
			return map;
		}
		List<DictDo> dictDoCodes = ObjectUtil.isNotEmpty(codes) ?
			dictDoList.stream().filter(dict -> ArrayUtil.contains(codes, dict.getCode())).collect(Collectors.toList())
			: dictDoList;
		dictDoCodes.forEach(dict -> {
			List<SelectVo> dictTempList = convertDictList(dictDoList, dict);
			if (CollUtil.isNotEmpty(dictTempList)) {
				map.put(dict.getCode(), dictTempList);
			}
		});
		Map<String, List<SelectVo>> baseEnumMap = DictUtil.convertBaseEnumToSelectVo(codes);
		if (baseEnumMap != null) {
			map.putAll(baseEnumMap);
		}
		return map;
	}

	private static List<SelectVo> convertDictList(List<DictDo> dictDoList, DictDo dictDo) {
		List<SelectVo> list = Lists.newLinkedList();
		if (CollUtil.isNotEmpty(dictDoList)) {
			for (DictDo item : dictDoList) {
				if (CommonConstants.YES.equals(item.getAvailable()) &&
					ObjectUtil.isNotEmpty(item.getParentId())
					&& item.getParentId().equals(dictDo.getId()) && StringUtil.isNotEmpty(item.getVal())) {
					list.add(SelectVo.builder()
						.value(item.getVal())
						.label(item.getName())
						.version(item.getVersion()).build());
				}
			}
		}
		return list;
	}

}
