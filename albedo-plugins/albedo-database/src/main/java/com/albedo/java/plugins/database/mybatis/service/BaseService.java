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

package com.albedo.java.plugins.database.mybatis.service;

import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.exception.code.ResponseCode;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;

import java.util.List;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:42
 */
public interface BaseService<T> extends IService<T> {
	/**
	 * 获取实体的类型
	 *
	 * @return
	 */
	@Override
	Class<T> getEntityClass();
	/**
	 * 根据id修改 entity 的所有字段
	 *
	 * @param entity
	 * @return
	 */
	boolean updateAllById(T entity);

	BaseRepository<T> getRepository();
}
