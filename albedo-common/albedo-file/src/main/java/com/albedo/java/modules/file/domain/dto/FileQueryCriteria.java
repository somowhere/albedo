package com.albedo.java.modules.file.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;

/**
 * @author somewhere
 */
@Data
public class FileQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 *
	 */
	@Query(operator = Query.Operator.like, propName = "biz_type")
	private String bizType;
	/**
	 *
	 */
	@Query(operator = Query.Operator.like, propName = "original_file_name")
	private String originalFileName;
	/**
	 *
	 */
	@Query(propName = "file_type")
	private String fileType;
	/**
	 *
	 */
	@Query(propName = "storage_type")
	private String storageType;

}
