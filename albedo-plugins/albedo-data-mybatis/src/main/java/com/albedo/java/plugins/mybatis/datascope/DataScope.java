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

package com.albedo.java.plugins.mybatis.datascope;

import com.albedo.java.common.core.basic.domain.BaseEntity;
import com.google.common.collect.Sets;
import lombok.Data;

import java.io.Serializable;
import java.util.Set;

/**
 * @author somewhere
 * @date 2019/2/1 数据权限查询参数
 */
@Data
public class DataScope implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 限制范围的字段名称
	 */
	private String scopeName = "dept_id";

	/**
	 * 限制范围的字段名称
	 */
	private String creatorName = BaseEntity.F_SQL_CREATED_BY;

	/**
	 * 具体的数据范围
	 */
	private Set<Long> deptIds = Sets.newLinkedHashSet();

	/**
	 * 全部数据
	 */
	private boolean isAll;

	/**
	 * 本人数据
	 */
	private boolean isSelf;

	private Long userId;

}
