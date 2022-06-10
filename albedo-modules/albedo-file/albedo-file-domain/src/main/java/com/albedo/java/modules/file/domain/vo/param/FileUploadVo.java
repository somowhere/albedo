package com.albedo.java.modules.file.domain.vo.param;


import com.albedo.java.modules.file.domain.enums.FileStorageType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 附件上传
 *
 * @author somewhere
 * @date 2019-05-12 18:49
 */
@Data
@Schema(name = "FileUploadVO", description = "附件上传")
public class FileUploadVo implements Serializable {

	@Schema(name = "业务类型")
	@NotBlank(message = "请填写业务类型")
	private String bizType;

	@Schema(name = "桶")
	private String bucket;

	@Schema(name = "存储类型")
	private FileStorageType storageType;
}
