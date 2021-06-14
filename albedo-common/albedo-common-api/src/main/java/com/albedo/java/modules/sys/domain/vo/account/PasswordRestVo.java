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

package com.albedo.java.modules.sys.domain.vo.account;


import com.albedo.java.modules.sys.domain.dto.UserDto;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * View Model object for storing a user's credentials.
 *
 * @author somewhere
 */
@Data
@ToString
public class PasswordRestVo implements Serializable {

	@ApiModelProperty(hidden = true)
	String passwordPlaintext;
	@NotBlank
	@ApiModelProperty("登录ID")
	private String username;
	@NotBlank
	@ApiModelProperty("姓名")
	private String name;
	@NotBlank
	@ApiModelProperty("手机")
	private String phone;
	@NotBlank
	@ApiModelProperty("验证码")
	private String code;
	@NotBlank
	@Size(min = UserDto.PASSWORD_MIN_LENGTH, max = UserDto.PASSWORD_MAX_LENGTH)
	@ApiModelProperty("新密码")
	private String newPassword;
	@NotBlank
	@Size(min = UserDto.PASSWORD_MIN_LENGTH, max = UserDto.PASSWORD_MAX_LENGTH)
	private String confirmPassword;

}
