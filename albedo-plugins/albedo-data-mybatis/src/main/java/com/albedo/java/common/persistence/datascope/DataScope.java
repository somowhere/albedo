/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.persistence.datascope;

import com.albedo.java.common.persistence.domain.BaseEntity;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 * @date 2019/2/1
 * 数据权限查询参数
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class DataScope extends HashMap {
	/**
	 * 限制范围的字段名称
	 */
	private String scopeName = "deptId";
	/**
	 * 限制范围的字段名称
	 */
	private String creatorName = BaseEntity.F_SQL_CREATEDBY;

	/**
	 * 具体的数据范围
	 */
	private Set<String> deptIds= Sets.newLinkedHashSet();
	/**
	 * 全部数据
	 */
	private boolean isAll;
	/**
	 * 本人数据
	 */
	private boolean isSelf;

	private String userId;

}
