package com.albedo.java.common.core.domain.vo;

import com.albedo.java.common.core.enumeration.FileType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * <p>
 * 实体类
 * 业务附件
 * </p>
 *
 * @author somewhere
 * @date 2021-06-30
 * @create [2021-06-30] [somewhere] [初始创建]
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = false)
@Builder
@Schema(name = "AppendixSaveVO", description = "业务附件")
public class AppendixDto extends DataDto<Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 业务id
	 */
	@Schema(name = "业务id")
	private Long bizId;
	/**
	 * 业务类型
	 */
	@Schema(name = "业务类型")
	@Size(max = 255, message = "业务类型长度不能超过255")
	private String bizType;

	/**
	 * 文件类型
	 */
	@Schema(name = "文件类型")
	private FileType fileType;
	/**
	 * 桶
	 */
	@Schema(name = "桶")
	@Size(max = 255, message = "桶长度不能超过255")
	private String bucket;
	/**
	 * 文件相对地址
	 */
	@Schema(name = "文件相对地址")
	@Size(max = 255, message = "文件相对地址长度不能超过255")
	@NotBlank(message = "请先上传文件")
	private String path;
	/**
	 * 原始文件名
	 */
	@Schema(name = "原始文件名")
	@Size(max = 255, message = "原始文件名长度不能超过255")
	@NotBlank(message = "请先上传文件")
	private String originalFileName;

	/**
	 * 文件类型
	 */
	@Schema(name = "文件类型")
	@Size(max = 255, message = "文件类型长度不能超过255")
	private String contentType;
	/**
	 * 大小
	 */
	@Schema(name = "大小")
	private Long size;

}
