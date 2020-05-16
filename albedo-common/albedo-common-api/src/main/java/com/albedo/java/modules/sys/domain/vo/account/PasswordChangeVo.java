package com.albedo.java.modules.sys.domain.vo.account;


import com.albedo.java.modules.sys.domain.dto.UserDto;
import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * View Model object for storing a user's credentials.
 */
@Data
@ToString
public class PasswordChangeVo implements Serializable {

	//    @NotBlank
//    private String avatar;
	@NotBlank
	private String oldPassword;

	@NotBlank
	@Size(min = 6, max = UserDto.PASSWORD_MAX_LENGTH)
	private String newPassword;

	@NotBlank
	@Size(min = 6, max = UserDto.PASSWORD_MAX_LENGTH)
	private String confirmPassword;

}
