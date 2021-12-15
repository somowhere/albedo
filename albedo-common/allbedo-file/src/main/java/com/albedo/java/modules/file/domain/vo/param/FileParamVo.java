package com.albedo.java.modules.file.domain.vo.param;

import com.albedo.java.common.core.enumeration.FileType;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "FileFileParamVO", description = "增量文件上传日志")
public class FileParamVo implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 业务类型
	 */
	@ApiModelProperty(value = "业务类型")
	private String bizType;
	/**
	 * 文件类型
	 */
	@ApiModelProperty(value = "文件类型")
	private FileType fileType;
	/**
	 * 存储类型
	 * LOCAL FAST_DFS MIN_IO ALI
	 */
	@ApiModelProperty(value = "存储类型")
	private FileStorageType storageType;
	/**
	 * 桶
	 */
	@ApiModelProperty(value = "桶")
	private String bucket;
	/**
	 * 文件相对地址
	 */
	@ApiModelProperty(value = "文件相对地址")
	private String path;
	/**
	 * 文件访问地址
	 */
	@ApiModelProperty(value = "文件访问地址")
	private String url;
	/**
	 * 唯一文件名
	 */
	@ApiModelProperty(value = "唯一文件名")
	private String uniqueFileName;
	/**
	 * 文件md5
	 */
	@ApiModelProperty(value = "文件md5")
	private String fileMd5;
	/**
	 * 原始文件名
	 */
	@ApiModelProperty(value = "原始文件名")
	private String originalFileName;
	/**
	 * 文件类型
	 */
	@ApiModelProperty(value = "文件类型")
	private String contentType;
	/**
	 * 后缀
	 */
	@ApiModelProperty(value = "后缀")
	private String suffix;
	/**
	 * 大小
	 */
	@ApiModelProperty(value = "大小")
	private Long size;

	@ApiModelProperty("主键")
	private Long id;

}
