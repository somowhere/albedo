package com.albedo.java.modules.file.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.ToString;

/**
 * 分片检测参数
 *
 * @author somewhere
 * @date 2018/08/28
 */
@Data
@ToString
@Schema(name = "FileChunkCheck", description = "文件分片信息")
public class FileChunkCheckDto {

	@Schema(name = "文件大小")
	private Long size;
	@Schema(name = "文件唯一名")
	private String name;
	@Schema(name = "分片索引")
	private Integer chunkIndex;
}
