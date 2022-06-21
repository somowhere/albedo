/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.plugins.database.mybatis.service.impl;

import com.albedo.java.common.core.domain.BaseDataDo;
import com.albedo.java.common.core.domain.vo.DataDto;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import com.albedo.java.plugins.database.mybatis.service.DataService;
import lombok.Data;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * Service基类
 *
 * @author somewhere
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
@Data
public class DataServiceImpl<Repository extends BaseRepository<T>, T extends BaseDataDo, D extends DataDto>
	extends BaseServiceImpl<Repository, T> implements DataService<T, D> {

	public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());

	private Class<D> entityDtoClz;

	public DataServiceImpl() {
		super();
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			entityDtoClz = (Class<D>) parameterizedType[2];
		}
	}

}
