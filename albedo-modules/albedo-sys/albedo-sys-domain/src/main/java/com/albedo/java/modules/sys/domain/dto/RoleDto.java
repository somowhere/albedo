
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

package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.core.domain.vo.DataDto;
import com.albedo.java.modules.sys.domain.enums.DataScopeType;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1 角色Dto
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class RoleDto extends DataDto<Long> {

	@Size(max = 64, message = "编码长度不能超过64")
	@NotBlank(message = "角色名称 不能为空")
	private String name;
	@Size(max = 32, message = "编码长度不能超过32")
	@NotBlank(message = "角色编码 不能为空")
	private String code;
	/**
	 * 数据权限 1全部 2所在机构及以下数据 3 所在机构数据 4仅本人数据 5 按明细设置
	 */
	@DictType(DictNameConstants.SYS_DATA_SCOPE)
	@NotNull(message = "数据权限 不能为空")
	private DataScopeType dataScope;

	@NotNull(message = "角色级别 不能为空")
	private Integer level = 3;


	/**
	 * 角色ID
	 */
	private List<Long> menuIdList;

	/**
	 * 部门ID
	 */
	private List<Long> deptIdList;

}
