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

package com.albedo.java.modules.gen.repository;

import com.albedo.java.plugins.mybatis.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 *
 * @author somewhere
 */
public interface TableRepository extends BaseRepository<Table> {

	/**
	 * 查询表列表
	 *
	 * @param tableQuery
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<Table> findTableList(@Param("tableQuery") TableQuery tableQuery, String dsName);

	/**
	 * 获取数据表字段
	 *
	 * @param tableName
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<TableColumnDto> findTableColumnList(@Param("tableName") String tableName, String dsName);

	/**
	 * 获取数据表主键
	 *
	 * @param tableName
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<String> findTablePk(@Param("tableName") String tableName, String dsName);

}
