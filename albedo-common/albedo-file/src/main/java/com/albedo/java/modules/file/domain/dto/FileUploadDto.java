package com.albedo.java.modules.file.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.ToString;

/**
 * 文件分片上传实体
 *
 * @author somewhere
 * @date 2018/08/29
 */
@Data
@Schema(name = "FileUpload", description = "文件分片上传实体")
@ToString
public class FileUploadDto {
	@Schema(name = "md5", description = "webuploader 自带的md5算法值， 与后端生成的不一致")
	private String md5;
	@Schema(name = "大小")
	private Long size;
	@Schema(name = "文件唯一名 md5.js生成的, 与后端生成的一致")
	private String name;
	@Schema(name = "分片总数")
	private Integer chunks;
	@Schema(name = "当前分片")
	private Integer chunk;
	@Schema(name = "最后更新时间")
	private String lastModifiedDate;
	@Schema(name = "类型")
	private String type;
	@Schema(name = "后缀")
	private String ext;
	@Schema(name = "文件夹id")
	private Long folderId;
}
