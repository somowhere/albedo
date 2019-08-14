package com.albedo.java.modules.sys.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;

/**
 * @author somewhere
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserExcelVo {
	@NotBlank
	private String deptName;
	@NotBlank
	private String username;

	private String password;
	@NotBlank
	private String name;
	@NotBlank
	private String phone;
	private String email;
	@NotBlank
	private String roleName;
}
