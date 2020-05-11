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

package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.vo.DataDto;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 * 角色Dto
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class RoleDto extends DataDto<String> {


	/**
	 * 锁定标记
	 */
	@DictType("sys_flag")
	@NotBlank(message = "锁定标记 不能为空")
	private String available;

	/**
	 * 数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置
	 */
	@DictType("sys_data_scope")
	@NotBlank(message = "数据权限 不能为空")
	private String dataScope;
	@NotBlank(message = "角色级别 不能为空")
	private Integer level = 3;

	@NotBlank(message = "角色名称 不能为空")
	private String name;

	@NotBlank(message = "角色标识 不能为空")
	private String code;

	/**
	 * 角色ID
	 */
	@NotNull
	private List<String> menuIdList;
	/**
	 * 部门ID
	 */
	private List<String> deptIdList;
}
