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

import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;
import java.util.List;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
public class UserDto extends DataDto<String> {

	public static final int PASSWORD_MIN_LENGTH = 4;

	public static final int PASSWORD_MAX_LENGTH = 64;
	public static final String USERNAME_REGEX = "^[_',.@A-Za-z0-9-]*$";
	public static final String F_USERNAME = "username";
	public static final String F_EMAIL = "email";
	public static final String F_PHONE = "phone";

	/**
	 * 用户名
	 */
	@NotEmpty
	@Pattern(regexp = UserDto.USERNAME_REGEX, message = "用户名格式不合法")
	private String username;

	private String nickname;

	@Size(max = PASSWORD_MAX_LENGTH)
	@JsonIgnore
	private String password;

	/**
	 * 邮箱
	 */
	@Email
	private String email;
	/**
	 * 电话
	 */
	private String phone;
	/**
	 * 头像
	 */
	private String avatar;

	/**
	 * 部门ID
	 */
	private String deptId;

	/**
	 * 微信openId
	 */
	private String wxOpenId;

	/**
	 * QQ openId
	 */
	private String qqOpenId;

	/**
	 * 角色ID
	 */
	@NotNull
	private List<String> roleIdList;


	public UserDto(UserVo userVo) {
		this.setId(userVo.getId());
		this.username = userVo.getUsername();
		this.password = userVo.getPassword();
		this.deptId = userVo.getDeptId();
		this.avatar = userVo.getAvatar();
		this.phone = userVo.getPhone();
		this.email = userVo.getEmail();
		this.qqOpenId = userVo.getQqOpenId();
		this.wxOpenId = userVo.getWxOpenId();
		this.roleIdList = userVo.getRoleIdList();
		this.setDescription(userVo.getDescription());
	}
}
