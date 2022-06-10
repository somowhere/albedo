package com.albedo.java.modules.file.domain;

import com.albedo.java.common.core.basic.domain.IdDo;
import com.albedo.java.common.core.enumeration.FileType;
import com.albedo.java.modules.file.domain.enums.FileStorageType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.SqlCondition.LIKE;


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
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_file")
@AllArgsConstructor
public class FileDo extends IdDo<FileDo, Long> {

	private static final long serialVersionUID = 1L;

	/**
	 * 业务类型
	 */
	@TableField(value = "biz_type")
	private String bizType;

	/**
	 * 文件类型
	 */
	@TableField(value = "file_type", condition = LIKE)
	private FileType fileType;

	/**
	 * 存储类型
	 * LOCAL FAST_DFS MIN_IO ALI
	 */
	@TableField(value = "storage_type", condition = LIKE)
	private FileStorageType storageType;

	/**
	 * 桶
	 */
	@TableField(value = "bucket", condition = LIKE)
	private String bucket;

	/**
	 * 文件相对地址
	 */
	@TableField(value = "path", condition = LIKE)
	private String path;

	/**
	 * 文件访问地址
	 */
	@TableField(value = "url", condition = LIKE)
	private String url;

	/**
	 * 唯一文件名
	 */
	@TableField(value = "unique_file_name", condition = LIKE)
	private String uniqueFileName;

	/**
	 * 文件md5
	 */
	@TableField(value = "file_md5", condition = LIKE)
	private String fileMd5;

	/**
	 * 原始文件名
	 */
	@TableField(value = "original_file_name", condition = LIKE)
	private String originalFileName;

	/**
	 * 文件类型
	 */
	@TableField(value = "content_type", condition = LIKE)
	private String contentType;

	/**
	 * 后缀
	 */
	@TableField(value = "suffix", condition = LIKE)
	private String suffix;

	/**
	 * 大小
	 */
	@TableField(value = "size")
	private Long size;


	@Builder
	public FileDo(Long id, LocalDateTime createdDate, Long createdBy, LocalDateTime lastModifiedDate, Long lastModifiedBy,
				  String bizType, FileType fileType, FileStorageType storageType, String bucket,
				  String path, String url, String uniqueFileName, String fileMd5, String originalFileName, String contentType,
				  String suffix, Long size) {
		this.id = id;
		this.createdDate = createdDate;
		this.createdBy = createdBy;
		this.lastModifiedBy = lastModifiedBy;
		this.lastModifiedDate = lastModifiedDate;
		this.bizType = bizType;
		this.fileType = fileType;
		this.storageType = storageType;
		this.bucket = bucket;
		this.path = path;
		this.url = url;
		this.uniqueFileName = uniqueFileName;
		this.fileMd5 = fileMd5;
		this.originalFileName = originalFileName;
		this.contentType = contentType;
		this.suffix = suffix;
		this.size = size;
	}

}
