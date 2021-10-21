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

import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.common.persistence.domain.BaseDataEntity;
import lombok.SneakyThrows;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public interface DataService<T extends BaseDataEntity, D extends DataDto>
	extends BaseService<T> {

	Class<D> getEntityDtoClz();

	/**
	 * getOneDto
	 *
	 * @param id
	 * @return D
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	default D getOneDto(Serializable id) {
		return copyBeanToDto(getById(id));
	}

	/**
	 * saveOrUpdate
	 *
	 * @param entityDto
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	@SneakyThrows
	default void saveOrUpdate(D entityDto) {
		T entity;
		entity = ObjectUtil.isNotEmpty(entityDto.getId()) ? getById(entityDto.getId())
			: getEntityClass().newInstance();
		copyDtoToBean(entityDto, entity);
		saveOrUpdate(entity);
		entityDto.setId(entity.pkVal());
	}

	/**
	 * copyBeanToDto
	 *
	 * @param module
	 * @param result
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	default void copyBeanToDto(T module, D result) {
		if (result != null && module != null) {
			BeanUtil.copyProperties(module, result, true);
			if (ObjectUtil.isNotEmpty(module.pkVal())) {
				result.setId(module.pkVal());
			}
		}
	}

	/**
	 * copyDtoToBean
	 *
	 * @param entityDto
	 * @param entity
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	default void copyDtoToBean(D entityDto, T entity) {
		if (entityDto != null && entity != null) {
			BeanUtil.copyProperties(entityDto, entity, true);
			if (ObjectUtil.isNotEmpty(entityDto.getId())) {
				entity.setPk(entityDto.getId());
			}
		}
	}

	/**
	 * copyDtoToBean
	 *
	 * @param entityDto
	 * @return T
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	@SneakyThrows
	default T copyDtoToBean(D entityDto) {
		T result = null;
		if (entityDto != null && getEntityClass() != null) {
			result = getEntityClass().newInstance();
			copyDtoToBean(entityDto, result);
			if (ObjectUtil.isNotEmpty(entityDto.getId())) {
				result.setPk(entityDto.getId());
			}
		}
		return result;
	}


	/**
	 * copyBeanToDto
	 *
	 * @param module
	 * @return D
	 * @author somewhere
	 * @updateTime 2020/5/31 17:33
	 */
	@SneakyThrows
	default D copyBeanToDto(T module) {
		D result = null;
		if (module != null && getEntityDtoClz() != null) {
			result = getEntityDtoClz().newInstance();
			copyBeanToDto(module, result);
			if (ObjectUtil.isNotEmpty(module.pkVal())) {
				result.setId(module.pkVal());
			}
		}
		return result;
	}
}
