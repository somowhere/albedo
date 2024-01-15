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

package com.albedo.java.plugins.database.mybatis.repository;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
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

	default T selectOne(String field, Object value) {
		return selectOne(new QueryWrapper<T>().eq(field, value));
	}

	default T selectOne(SFunction<T, ?> field, Object value) {
		return selectOne(new LambdaQueryWrapper<T>().eq(field, value));
	}

	default T selectOne(String field1, Object value1, String field2, Object value2) {
		return selectOne(new QueryWrapper<T>().eq(field1, value1).eq(field2, value2));
	}

	default T selectOne(SFunction<T, ?> field1, Object value1, SFunction<T, ?> field2, Object value2) {
		return selectOne(new LambdaQueryWrapper<T>().eq(field1, value1).eq(field2, value2));
	}

	default Long selectCount() {
		return selectCount(new QueryWrapper<T>());
	}

	default Long selectCount(String field, Object value) {
		return selectCount(new QueryWrapper<T>().eq(field, value));
	}

	default Long selectCount(SFunction<T, ?> field, Object value) {
		return selectCount(new LambdaQueryWrapper<T>().eq(field, value));
	}

	default List<T> selectList() {
		return selectList(new QueryWrapper<>());
	}

	default List<T> selectList(String field, Object value) {
		return selectList(new QueryWrapper<T>().eq(field, value));
	}

	default List<T> selectList(SFunction<T, ?> field, Object value) {
		return selectList(new LambdaQueryWrapper<T>().eq(field, value));
	}

	default List<T> selectList(String field, Collection<?> values) {
		return selectList(new QueryWrapper<T>().in(field, values));
	}

	default List<T> selectList(SFunction<T, ?> field, Collection<?> values) {
		return selectList(new LambdaQueryWrapper<T>().in(field, values));
	}

	/**
	 * 逐条插入，适合少量数据插入，或者对性能要求不高的场景
	 * <p>
	 * 如果大量，请使用 {@link com.baomidou.mybatisplus.extension.service.impl.ServiceImpl#saveBatch(Collection)} 方法
	 * 使用示例，可见 RoleMenuBatchInsertMapper、UserRoleBatchInsertMapper 类
	 *
	 * @param entities 实体们
	 */
	default void insertBatch(Collection<T> entities) {
		entities.forEach(this::insert);
	}

	default void updateBatch(T update) {
		update(update, new QueryWrapper<>());
	}

}
