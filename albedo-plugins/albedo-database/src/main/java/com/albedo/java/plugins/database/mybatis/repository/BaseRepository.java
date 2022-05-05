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

package com.albedo.java.plugins.database.mybatis.repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * DAO支持类实现
 *
 * @author somewhere
 * @version 2018-03-07
 */
public interface BaseRepository<T> extends BaseMapper<T> {

	/**
	 * 全量修改所有字段
	 *
	 * @param entity 实体
	 * @return 修改数量
	 */
	int updateAllById(@Param(Constants.ENTITY) T entity);

	/**
	 * 批量插入所有字段
	 * <p>
	 * 只测试过MySQL！只测试过MySQL！只测试过MySQL！
	 *
	 * @param entityList 实体集合
	 * @return 插入数量
	 */
	int insertBatchSomeColumn(List<T> entityList);
}
