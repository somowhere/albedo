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

package com.albedo.java.plugins.database.mybatis.service.impl;

import com.albedo.java.common.core.basic.domain.TreeDo;
import com.albedo.java.common.core.vo.TreeDto;
import com.albedo.java.plugins.database.mybatis.repository.TreeRepository;
import com.albedo.java.plugins.database.mybatis.service.TreeService;
import lombok.Data;

/**
 * @param <Repository>
 * @param <T>
 * @param <D>
 * @author somewhere
 */
@Data
public abstract class AbstractTreeCacheServiceImpl<Repository extends TreeRepository<T>, T extends TreeDo, D extends TreeDto>
	extends AbstractDataCacheServiceImpl<Repository, T, D> implements TreeService<T, D> {

}
