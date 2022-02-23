package com.albedo.java.modules.sys.domain.vo.account;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 *
 * @author somewhere
 */
@Data
public class AvatarInfo implements Serializable {

	@NotBlank
	private String avatar;

}
