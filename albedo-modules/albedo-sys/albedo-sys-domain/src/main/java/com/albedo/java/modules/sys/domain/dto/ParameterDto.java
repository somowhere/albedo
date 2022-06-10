package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.vo.DataDto;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

/**
 * <p>
 * 实体类
 * 应用
 * </p>
 *
 * @author somewhere
 * @since 2020-11-20
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@AllArgsConstructor
public class ParameterDto extends DataDto<Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 参数键
	 */
	@NotEmpty(message = "参数键不能为空")
	@Size(max = 255, message = "参数键长度不能超过255")
	private String key;

	/**
	 * 参数值
	 */
	@NotEmpty(message = "参数值不能为空")
	@Size(max = 255, message = "参数值长度不能超过255")
	private String value;

	/**
	 * 参数名称
	 */
	@NotEmpty(message = "参数名称不能为空")
	@Size(max = 255, message = "参数名称长度不能超过255")
	private String name;

	/**
	 * 描述
	 */
	@Size(max = 255, message = "描述长度不能超过255")
	private String describe;

	/**
	 * 状态
	 */
	private Boolean state;

	/**
	 * 内置
	 */
	private Boolean readonly;


	@Builder
	public ParameterDto(Long id, String key, String value, String name, String describe, Boolean state, Boolean readonly) {
		this.setId(id);
		this.key = key;
		this.value = value;
		this.name = name;
		this.describe = describe;
		this.state = state;
		this.readonly = readonly;
	}

}
