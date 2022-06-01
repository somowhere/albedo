package com.albedo.java.modules.file.domain.vo.result;

import com.albedo.java.common.core.enumeration.FileType;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 * <p>
 * 实体类
 * 增量文件上传日志
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
@Schema(name = "FileFileResultVO", description = "增量文件上传日志")
public class FileResultVo implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 业务类型
	 */
	@Schema(name = "业务类型")
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
	private String bucket;
	/**
	 * 文件相对地址
	 */
	@Schema(name = "文件相对地址")
	private String path;
	/**
	 * 文件访问地址
	 * 当bucket设置为私有桶时，可能无法访问
	 */
	@Schema(name = "文件访问地址")
	private String url;
	/**
	 * 唯一文件名
	 */
	@Schema(name = "唯一文件名")
	private String uniqueFileName;
	/**
	 * 文件md5
	 */
	@Schema(name = "文件md5")
	private String fileMd5;
	/**
	 * 原始文件名
	 */
	@Schema(name = "原始文件名")
	private String originalFileName;
	/**
	 * 文件类型
	 */
	@Schema(name = "文件类型")
	private String contentType;
	/**
	 * 后缀
	 */
	@Schema(name = "后缀")
	private String suffix;
	/**
	 * 大小
	 */
	@Schema(name = "大小")
	private Long size;

	@Schema(name = "主键")
	private Long id;
}
