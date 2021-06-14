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

package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.common.persistence.domain.BaseDataEntity;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public interface DataService<T extends BaseDataEntity, D extends DataDto, PK extends Serializable>
	extends BaseService<T> {

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	/**
	 * getOneDto
	 * @author somewhere
	 * @param id
	 * @updateTime 2020/5/31 17:33
	 * @return D
	 */
	D getOneDto(PK id);

	/**
	 * saveOrUpdate
	 *
	 * @param form
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	void saveOrUpdate(D form);

	/**
	 * copyBeanToDto
	 *
	 * @param module
	 * @param result
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	void copyBeanToDto(T module, D result);

	/**
	 * copyBeanToDto
	 *
	 * @param module
	 * @return D
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	D copyBeanToDto(T module);

	/**
	 * copyDtoToBean
	 *
	 * @param form
	 * @param entity
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	void copyDtoToBean(D form, T entity);

	/**
	 * copyDtoToBean
	 *
	 * @param form
	 * @return T
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	T copyDtoToBean(D form);

}
