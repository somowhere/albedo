package com.albedo.java.modules.sys.domain.vo.account;


import com.albedo.java.modules.sys.domain.vo.UserDataVo;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

/**
 * View Model object for storing a user's credentials.
 */
@Data
@ToString
public class LoginVo {

	@Pattern(regexp = UserDataVo.USERNAME_REGEX, message = "登录名格式不合法")
	@NotEmpty
	@Size(min = 1, max = 50)
	private String username;

	@NotEmpty
	@Size(min = UserDataVo.PASSWORD_MIN_LENGTH, max = UserDataVo.PASSWORD_MAX_LENGTH, message =
		"允许的密码长度区间为[" + UserDataVo.PASSWORD_MIN_LENGTH + "-" + UserDataVo.PASSWORD_MAX_LENGTH + "]")
	private String password;

	private String code;

	private String randomStr;

	private Boolean rememberMe;


}
