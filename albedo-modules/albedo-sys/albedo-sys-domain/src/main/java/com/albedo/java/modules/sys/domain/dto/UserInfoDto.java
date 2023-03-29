
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

package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.domain.vo.DataDto;
import com.albedo.java.modules.sys.domain.enums.Sex;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class UserInfoDto extends DataDto<String> {

	private String nickname;

	/**
	 * 电话
	 */
	@NotEmpty
	private String phone;
	@NotEmpty
	private String email;
	@NotNull
	private Sex sex;

}
