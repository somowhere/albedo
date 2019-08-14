package com.albedo.java.modules.gen.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotEmpty;
import java.io.Serializable;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class SchemeGenDataVo implements Serializable {

	@NotEmpty
	private String id;
	/**
	 * 上级模块 ID
	 */
	@NotEmpty
	private String parentMenuId;
}
