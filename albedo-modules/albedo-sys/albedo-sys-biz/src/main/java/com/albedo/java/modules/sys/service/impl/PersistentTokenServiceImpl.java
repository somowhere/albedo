
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

package com.albedo.java.modules.sys.service.impl;

import com.albedo.java.modules.sys.domain.PersistentTokenDo;
import com.albedo.java.modules.sys.feign.RemotePersistentTokenService;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.modules.sys.service.PersistentTokenService;
import com.albedo.java.plugins.database.mybatis.service.impl.BaseServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.Serializable;

/**
 * <p>
 * token 服务实现类
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Service
@Slf4j
public class PersistentTokenServiceImpl extends BaseServiceImpl<PersistentTokenRepository, PersistentTokenDo>
	implements PersistentTokenService, RemotePersistentTokenService {

	@Override
	public void insert(PersistentTokenDo persistentTokenDo) {
		super.save(persistentTokenDo);
	}

	@Override
	public PersistentTokenDo selectById(Serializable presentedSeries) {
		return super.getById(presentedSeries);
	}

	@Override
	public void deleteById(Serializable series) {
		super.removeById(series);
	}

	@Override
	public boolean updateById(PersistentTokenDo entity) {
		return super.updateById(entity);
	}
}
