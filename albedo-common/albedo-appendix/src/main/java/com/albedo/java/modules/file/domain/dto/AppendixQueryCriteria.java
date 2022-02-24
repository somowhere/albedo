package com.albedo.java.modules.file.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;

/**
 * @author somewhere
 */
@Data
public class AppendixQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * F_NAME name : 名称
	 */
	@Query(operator = Query.Operator.like, propName = "original_file_name")
	private String originalFileName;

}
