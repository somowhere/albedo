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
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * View Model object for storing a user's credentials.
 *
 * @author somewhere
 */
@Data
@ToString
public class LoginVo implements Serializable {

	@Pattern(regexp = UserDto.USERNAME_REGEX, message = "登录名格式不合法")
	@NotEmpty
	@Size(min = 1, max = 50)
	private String username;

	@NotEmpty
	@Size(min = UserDto.PASSWORD_MIN_LENGTH, max = UserDto.PASSWORD_MAX_LENGTH,
		message = "允许的密码长度区间为[" + UserDto.PASSWORD_MIN_LENGTH + "-" + UserDto.PASSWORD_MAX_LENGTH + "]")
	private String password;

	private String code;

	private String randomStr;

	private Boolean rememberMe;

}
