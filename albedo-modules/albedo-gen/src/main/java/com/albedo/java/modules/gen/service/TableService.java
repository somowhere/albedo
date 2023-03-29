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

package com.albedo.java.modules.gen.service;

import com.albedo.java.modules.gen.domain.TableDo;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.vo.TableFormDataVo;
import com.albedo.java.plugins.database.mybatis.service.DataCacheService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 */
public interface TableService extends DataCacheService<TableDo, TableDto> {

	/**
	 * 判断表名是否存在
	 *
	 * @param tableName
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	boolean checkTableName(String tableName);

	/**
	 * 获取物理表信息
	 *
	 * @param tableDto
	 * @return
	 */
	TableDto getTableFormDb(TableDto tableDto);

	/**
	 * 获取主键
	 *
	 * @param tableDto
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<String> findTablePk(TableDto tableDto);

	/**
	 * 获取表列信息
	 *
	 * @param tableDto
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableColumnDto> findTableColumnList(TableDto tableDto);

	/**
	 * 读取数据库表集合信息
	 *
	 * @param tableDto
	 * @return
	 */
	List<TableDto> findTableListFormDb(TableDto tableDto);

	/**
	 * 获取编辑所需要得表对象信息
	 *
	 * @param tableFromDto
	 * @return
	 */
	TableFormDataVo findFormData(TableFromDto tableFromDto);

	/**
	 * 批量删除
	 *
	 * @param ids
	 */
	void delete(Set<String> ids);

	/**
	 * 同步对于表在数据库中表列信息
	 *
	 * @param tableDto
	 */
	void refreshColumn(TableDto tableDto);

}
