package com.albedo.java.modules.tenant.domain.dto;

import com.albedo.java.common.core.vo.AppendixDto;
import com.albedo.java.common.core.vo.DataDto;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 * 实体类
 * 企业
 * </p>
 *
 * @author somewhere
 * @since 2020-11-19
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@AllArgsConstructor
public class TenantDto extends DataDto<Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 企业编码
	 */
	@Schema(name = "企业编码")
	@NotEmpty(message = "企业编码不能为空")
	@Size(max = 20, message = "企业编码长度不能超过20")
	private String code;
	/**
	 * 企业名称
	 */
	@Schema(name = "企业名称")
	@Size(max = 255, message = "企业名称长度不能超过255")
	private String name;
	/**
	 * 责任人
	 */
	@Schema(name = "责任人")
	@Size(max = 50, message = "责任人长度不能超过50")
	private String duty;
	/**
	 * 有效期
	 * 为空表示永久
	 */
	@Schema(name = "有效期")
	private LocalDateTime expirationTime;
	/**
	 * logo地址
	 */
	@Schema(name = "logo地址")
	@Size(max = 1, message = "只能上传1个logo")
	private List<AppendixDto> logos;
	/**
	 * 企业简介
	 */
	@Schema(name = "企业简介")
	@Size(max = 255, message = "企业简介长度不能超过255")
	private String describe;


}
