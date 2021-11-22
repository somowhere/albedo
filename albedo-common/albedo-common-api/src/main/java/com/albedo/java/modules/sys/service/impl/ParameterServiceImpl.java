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

package com.albedo.java.modules.sys.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.event.listener.ParameterUpdateEvent;
import com.albedo.java.common.event.model.ParameterUpdate;
import com.albedo.java.modules.sys.cache.ParameterKeyCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.Parameter;
import com.albedo.java.modules.sys.domain.dto.ParameterDto;
import com.albedo.java.modules.sys.repository.ParameterRepository;
import com.albedo.java.modules.sys.service.ParameterService;
import com.albedo.java.plugins.cache.repository.CacheOps;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.service.impl.DataServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.*;
import java.util.function.Function;

/**
 * <p>
 * 日志表 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@RequiredArgsConstructor
public class ParameterServiceImpl extends DataServiceImpl<ParameterRepository, Parameter, ParameterDto>
	implements ParameterService {

	private final CacheOps cacheOps;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean save(Parameter model) {
		ArgumentAssert.isFalse(check(model.getKey()), "参数key重复");

		boolean bool = SqlHelper.retBool(baseMapper.insert(model));
		if (bool) {
			CacheKey cacheKey = new ParameterKeyCacheKeyBuilder().key(model.getKey());
			cacheOps.set(cacheKey, model.getValue());
		}
		return bool;
	}

	@Transactional(readOnly = true)
	public boolean check(String key) {
		return count(Wraps.<Parameter>lbQ().eq(Parameter::getKey, key)) > 0;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateById(Parameter model) {
		long count = count(Wraps.<Parameter>lbQ().eq(Parameter::getKey, model.getKey()).ne(Parameter::getId, model.getId()));
		ArgumentAssert.isFalse(count > 0, StrUtil.format("参数key[{}]已经存在，请勿重复创建", model.getKey()));

		boolean bool = SqlHelper.retBool(getBaseMapper().updateById(model));
		if (bool) {

			CacheKey cacheKey = new ParameterKeyCacheKeyBuilder().key(model.getKey());
			cacheOps.set(cacheKey, model.getValue());

			SpringContextHolder.publishEvent(new ParameterUpdateEvent(
				new ParameterUpdate(model.getKey(), model.getValue(), null, ContextUtil.getTenant())
			));
		}
		return bool;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		if (CollectionUtils.isEmpty(idList)) {
			return true;
		}
		List<Parameter> parameterList = super.listByIds(idList);
		if (parameterList.isEmpty()) {
			return true;
		}
		boolean bool = SqlHelper.retBool(getBaseMapper().deleteBatchIds(idList));
		CacheKey[] keys = parameterList.stream()
			.map(item -> new ParameterKeyCacheKeyBuilder().key(item.getKey()))
			.toArray(CacheKey[]::new);
		cacheOps.del(keys);

		parameterList.forEach(model ->
			SpringContextHolder.publishEvent(new ParameterUpdateEvent(
				new ParameterUpdate(model.getKey(), model.getValue(), null, ContextUtil.getTenant())
			))
		);
		return bool;
	}

	@Override
	public String getValue(String key, String defVal) {
		if (StrUtil.isEmpty(key)) {
			return defVal;
		}

		Function<CacheKey, String> loader = k -> {
			Parameter parameter = getOne(Wraps.<Parameter>lbQ().eq(Parameter::getKey, key));
			return parameter == null ? defVal : parameter.getValue();
		};
		CacheKey cacheKey = new ParameterKeyCacheKeyBuilder().key(key);
		return cacheOps.get(cacheKey, loader);
	}

	@Override
	public Map<String, String> findParams(List<String> keys) {
		if (CollUtil.isEmpty(keys)) {
			return Collections.emptyMap();
		}
		List<Parameter> list = list(Wraps.<Parameter>lbQ().in(Parameter::getKey, keys));
		Map<String, String> map = new HashMap<>();
		list.forEach(item -> map.put(item.getKey(), item.getValue()));
		return map;
	}


}
