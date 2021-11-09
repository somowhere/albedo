package com.albedo.java.modules.file.domain;

import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.common.core.enumeration.FileTypeEnum;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;
import lombok.experimental.Accessors;

import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.SqlCondition.LIKE;


/**
 * <p>
 * 实体类
 * 业务附件
 * </p>
 *
 * @author tangyh
 * @date 2021-06-30
 * @create [2021-06-30] [tangyh] [初始创建]
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("c_appendix")
@AllArgsConstructor
public class Appendix extends IdEntity<Appendix, Long> {

	private static final long serialVersionUID = 1L;
	/**
	 * 业务id
	 */
	@TableField(value = "biz_id")
	private Long bizId;

	/**
	 * 业务类型
	 */
	@TableField(value = "biz_type", condition = LIKE)
	private String bizType;

	/**
	 * 文件类型
	 */
	@TableField(value = "file_type", condition = LIKE)
	private FileTypeEnum fileType;

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
	 * 大小
	 */
	@TableField(value = "size")
	private Long size;


	@Builder
	public Appendix(Long id, LocalDateTime createdDate, Long createdBy, LocalDateTime lastModifiedDate, Long lastModifiedBy,
					Long bizId, String bizType, FileTypeEnum fileType, String bucket, String path,
					String originalFileName, String contentType, Long size) {
		this.id = id;
		this.createdDate = createdDate;
		this.createdBy = createdBy;
		this.lastModifiedDate = lastModifiedDate;
		this.lastModifiedBy = lastModifiedBy;
		this.bizId = bizId;
		this.bizType = bizType;
		this.fileType = fileType;
		this.bucket = bucket;
		this.path = path;
		this.originalFileName = originalFileName;
		this.contentType = contentType;
		this.size = size;
	}

}
