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

import com.albedo.java.common.core.vo.GeneralDto;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Set;

/**
 * <p>
 * 角色菜单表
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Data
public class RoleMenuDto extends GeneralDto {

	private static final long serialVersionUID = 1L;

	/**
	 * 角色ID
	 */
	@NotBlank
	private String roleId;
	/**
	 * 菜单IDs
	 */
	@NotNull
	private Set<String> menuIdList;
}
