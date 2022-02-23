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

import cn.hutool.core.convert.Convert;
import com.albedo.java.common.core.cache.model.CacheKey;
import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.modules.sys.cache.ApplicationClientCacheKeyBuilder;
import com.albedo.java.modules.sys.domain.Application;
import com.albedo.java.modules.sys.domain.dto.ApplicationDto;
import com.albedo.java.modules.sys.repository.ApplicationRepository;
import com.albedo.java.modules.sys.service.ApplicationService;
import com.albedo.java.plugins.database.mybatis.conditions.Wraps;
import com.albedo.java.plugins.database.mybatis.conditions.query.LbqWrapper;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import org.springframework.stereotype.Service;

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
public class ApplicationServiceImpl extends AbstractDataCacheServiceImpl<ApplicationRepository, Application, ApplicationDto>
	implements ApplicationService {

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return null;
	}

	@Override
	public Application getByClient(String clientId, String clientSecret) {
		LbqWrapper<Application> wrapper = Wraps.<Application>lbQ()
			.select(Application::getId).eq(Application::getClientId, clientId).eq(Application::getClientSecret, clientSecret);
		Function<CacheKey, Object> loader = k -> super.getObj(wrapper, Convert::toLong);
		CacheKey cacheKey = new ApplicationClientCacheKeyBuilder().key(clientId, clientSecret);
		return getByKey(cacheKey, loader);
	}

}
