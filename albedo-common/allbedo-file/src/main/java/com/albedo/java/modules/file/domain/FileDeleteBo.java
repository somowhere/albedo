package com.albedo.java.modules.file.domain;

import com.albedo.java.modules.file.enumeration.FileStorageType;
import lombok.Builder;
import lombok.Data;

/**
 * 文件删除
 *
 * @author somewhere
 * @date 2019/05/07
 */
@Data
@Builder
public class FileDeleteBo {
	/**
	 * 桶
	 */
	private String bucket;
	/**
	 * 相对路径
	 */
	private String path;
	/**
	 * 存储类型
	 */
	private FileStorageType storageType;
}
