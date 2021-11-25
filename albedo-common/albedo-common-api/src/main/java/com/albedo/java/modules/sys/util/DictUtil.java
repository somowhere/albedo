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

package com.albedo.java.modules.sys.util;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.enumeration.BaseEnum;
import com.albedo.java.common.core.util.*;
import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * 数据字典工具类 copyright 2014 albedo all right reserved author somewhere created on 2015年1月27日
 * 上午9:52:55
 *
 * @author somewhere
 */
@Slf4j
public class DictUtil {

	public static CacheManager cacheManager = SpringContextHolder.getBean(CacheManager.class);

	public static DictService dictService = SpringContextHolder.getBean(DictService.class);

	public static List<Dict> getDictList() {
		Cache cache = cacheManager.getCache(CacheNameConstants.DICT_DETAILS);
		if (cache != null && cache.get(CacheNameConstants.DICT_ALL) != null) {
			return (List<Dict>) cache.get(CacheNameConstants.DICT_ALL).get();
		}
		try {
			List<Dict> dictList = dictService.findAllOrderBySort();
			if (ObjectUtil.isNotEmpty(dictList)) {
				cache.put(CacheNameConstants.DICT_ALL, dictList);
				return dictList;
			}
		} catch (Exception e) {
			log.warn("{}", e);
		}
		return null;
	}

	public static List<Dict> getDictListByParentCode(String code) {
		Optional<Dict> first = getDictList().stream().filter(dict -> dict.getCode().equals(code)).findFirst();
		return getDictList().stream().filter(dict -> first.get().getId().equals(dict.getParentId()))
			.collect(Collectors.toList());
	}

	public static Map<String, List<SelectVo>> convertSelectVoMapByCodes(String... codes) {
		return convertSelectVoMapByCodes(DictUtil.getDictList(), codes);
	}

	public static Map<String, List<SelectVo>> convertBaseEnumToSelectVo(String[] codes, List<Class<BaseEnum>> baseEnums) {
		if (ArrayUtil.isNotEmpty(baseEnums)) {
			Map<String, List<SelectVo>> selectVoMap = Maps.newHashMap();
			for (Class<BaseEnum> baseEnumClass : baseEnums) {
				String simpleName = StringUtil.toRevertCamelCase(StringUtil.lowerFirst(baseEnumClass.getSimpleName()), CharUtil.UNDERLINE);
				boolean containsKey = selectVoMap.containsKey(simpleName),
					hitCode = (ArrayUtil.isEmpty(codes) || ArrayUtil.contains(codes, simpleName));
				if (!containsKey && hitCode) {
					Assert.isTrue(baseEnumClass.isEnum(), "this is not enum form BaseEnum " + baseEnumClass + " !!!");
					List<SelectVo> selectVoList = Lists.newArrayList();
					for (BaseEnum enumConstant : baseEnumClass.getEnumConstants()) {
						selectVoList.add(SelectVo.builder()
							.value(enumConstant.getCode())
							.label(enumConstant.getDesc()).build());
					}
					selectVoMap.put(simpleName, selectVoList);
				}
			}
			return selectVoMap;
		}
		return null;
	}

	public static Map<String, List<SelectVo>> convertSelectVoMapByCodes(List<Dict> dictList, String... codes) {
		Map<String, List<SelectVo>> map = Maps.newHashMap();
		if (ObjectUtil.isEmpty(dictList)) {
			return map;
		}
		List<Dict> dictCodes = ObjectUtil.isNotEmpty(codes) ?
			dictList.stream().filter(dict -> ArrayUtil.contains(codes, dict.getCode())).collect(Collectors.toList())
			: dictList;
		dictCodes.forEach(dict -> {
			List<SelectVo> dictTempList = convertDictList(dictList, dict);
			if (CollUtil.isNotEmpty(dictTempList)) {
				map.put(dict.getCode(), dictTempList);
			}
		});
		Map<String, List<SelectVo>> baseEnumMap = DictUtil.convertBaseEnumToSelectVo(codes,
			ClassUtil.getAllInterfaceAchieveClass(BaseEnum.class, CommonConstants.BUSINESS_PACKAGE));
		if (baseEnumMap != null) {
			map.putAll(baseEnumMap);
		}
		return map;
	}

	private static List<SelectVo> convertDictList(List<Dict> dictList, Dict dict) {
		List<SelectVo> list = Lists.newLinkedList();
		if (CollUtil.isNotEmpty(dictList)) {
			for (Dict item : dictList) {
				if (CommonConstants.YES.equals(item.getAvailable()) &&
					ObjectUtil.isNotEmpty(item.getParentId())
					&& item.getParentId().equals(dict.getId()) && StringUtil.isNotEmpty(item.getVal())) {
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
