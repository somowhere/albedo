package com.albedo.java.modules.file.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.ToString;

/**
 * 封建分片合并DTO
 *
 * @author somewhere
 * @date 2018/08/28
 */
@Data
@ToString
@Schema(name = "FileChunksMerge", description = "文件合并实体")
public class FileChunksMergeDto {

	@Schema(name = "文件唯一名 md5.js 生成的, 与后端生成的一致")
	private String name;
	@Schema(name = "原始文件名")
	private String submittedFileName;

	@Schema(name = "md5", description = "webuploader 自带的md5算法值， 与后端生成的不一致")
	private String md5;

	@Schema(name = "分片总数")
	private Integer chunks;
	@Schema(name = "后缀")
	private String ext;
	@Schema(name = "文件夹id")
	private Long folderId;

	@Schema(name = "大小")
	private Long size;
	@Schema(name = "类型")
	private String contextType;
}
