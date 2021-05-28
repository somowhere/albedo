package com.albedo.java.modules.sys.domain.vo.account;

import lombok.Data;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * View Model object for storing a user's credentials.
 *
 * @author somewhere
 */
@Data
@ToString
public class PasswordChangeVo implements Serializable {

	@NotBlank
	private String oldPassword;

	@NotBlank
	private String newPassword;

	@NotBlank
	private String confirmPassword;

}
