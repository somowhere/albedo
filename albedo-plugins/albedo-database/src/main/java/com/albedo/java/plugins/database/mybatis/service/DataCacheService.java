/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.plugins.database.mybatis.service;

import com.albedo.java.common.core.basic.domain.BaseDataDo;
import com.albedo.java.common.core.vo.DataDto;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public interface DataCacheService<T extends BaseDataDo, D extends DataDto>
	extends DataService<T, D>, CacheService<T> {

	/**
	 * getOneDto
	 *
	 * @param id
	 * @return D
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default D getOneDto(Serializable id) {
		return copyBeanToDto(getByIdCache(id));
	}

}
