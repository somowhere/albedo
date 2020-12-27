/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.gen.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;

/**
 * 数据源QueryCriteria 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
@Data
public class DatasourceConfQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * F_NAME name  :  名称
	 */
	@Query(operator = Query.Operator.like)
	private String name;

}
