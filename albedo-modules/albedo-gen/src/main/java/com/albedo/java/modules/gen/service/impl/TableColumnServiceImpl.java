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

package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.modules.gen.cache.TableColumnCacheKeyBuilder;
import com.albedo.java.modules.gen.domain.TableColumnDo;
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
public class TableColumnServiceImpl extends AbstractDataCacheServiceImpl<TableColumnRepository, TableColumnDo, TableColumnDto>
	implements TableColumnService {

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new TableColumnCacheKeyBuilder();
	}

	List<TableColumnDo> findAllByGenTableIdOrderBySort(String id) {
		return list(Wrappers.<TableColumnDo>query().eq(TableColumnDo.F_SQL_GENTABLEID, id).orderByAsc(TableColumnDo.F_SORT));
	}

	@Override
	public void deleteByTableId(String id) {
		List<TableColumnDo> tableColumnDoList = findAllByGenTableIdOrderBySort(id);
		ArgumentAssert.notNull(tableColumnDoList, "id " + id + " tableColumn 不能为空");
		super.removeByIds(tableColumnDoList.stream().map(item -> item.getId()).collect(Collectors.toList()));

	}

}
