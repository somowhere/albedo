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

package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.modules.gen.cache.TableColumnCacheKeyBuilder;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.repository.TableColumnRepository;
import com.albedo.java.modules.gen.service.TableColumnService;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableColumnServiceImpl extends AbstractDataCacheServiceImpl<TableColumnRepository, TableColumn, TableColumnDto>
	implements TableColumnService {

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new TableColumnCacheKeyBuilder();
	}

	List<TableColumn> findAllByGenTableIdOrderBySort(String id) {
		return list(Wrappers.<TableColumn>query().eq(TableColumn.F_SQL_GENTABLEID, id).orderByAsc(TableColumn.F_SORT));
	}

	@Override
	public void deleteByTableId(String id) {
		List<TableColumn> tableColumnList = findAllByGenTableIdOrderBySort(id);
		ArgumentAssert.notNull(tableColumnList, "id " + id + " tableColumn 不能为空");
		super.removeByIds(tableColumnList.stream().map(item -> item.getId()).collect(Collectors.toList()));

	}

}
