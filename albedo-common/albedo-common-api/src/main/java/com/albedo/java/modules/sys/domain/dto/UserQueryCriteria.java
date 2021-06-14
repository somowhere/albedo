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

package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 * @date 2020-05-10
 */
@Data
public class UserQueryCriteria implements Serializable {

	@Query(propName = "b.id", operator = Query.Operator.in)
	private Set<String> deptIds;

	@Query(blurry = "a.email,a.username,a.phone")
	private String blurry;

	@Query(propName = "a.available")
	private Integer available;

	@Query(propName = "a.dept_id")
	private String deptId;

	@Query(propName = "a.created_date", operator = Query.Operator.between)
	private List<Date> createdDate;
}
