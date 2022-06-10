package com.albedo.java.modules.file.domain;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * <p>
 * 实体类
 * 附件
 * </p>
 *
 * @author somewhere
 * @since 2021-06-15
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = false)
@Builder
@Schema(name = "FileGetUrlVO", description = "附件查询")
public class FileGetUrlBo implements Serializable {
	private static final long serialVersionUID = 1L;

	@NotBlank(message = "请传入文件路径")
	private String path;
	private String originalFileName;

	private String bucket;
}
