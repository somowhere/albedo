package com.albedo.java.modules.sys.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * @author somewhere
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UserExcelVo implements Serializable {
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
