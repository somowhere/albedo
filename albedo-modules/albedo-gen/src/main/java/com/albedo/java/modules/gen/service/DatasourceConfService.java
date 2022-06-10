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

import com.albedo.java.modules.gen.domain.DatasourceConfDo;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfDto;
import com.albedo.java.plugins.database.mybatis.service.DataCacheService;

/**
 * 数据源Service 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
public interface DatasourceConfService extends DataCacheService<DatasourceConfDo, DatasourceConfDto> {

}
