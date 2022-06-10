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

package com.albedo.java.modules.gen.service;

import com.albedo.java.modules.gen.domain.TableColumnDo;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.plugins.database.mybatis.service.DataCacheService;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
public interface TableColumnService extends DataCacheService<TableColumnDo, TableColumnDto> {

	/**
	 * deleteByTableId
	 *
	 * @param id
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	void deleteByTableId(String id);

}
