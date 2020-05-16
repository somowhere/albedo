/*
 *  Copyright 2019-2020 Zheng Jie
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */
package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 * @date 2020-05-10
 */
@Data
public class DeptQueryCriteria implements Serializable {

	@Query(propName = "id", operator = Query.Operator.ne)
	private String notId;

	@Query(propName = "id", operator = Query.Operator.in)
	private Set<String> deptIds;

	@Query(operator = Query.Operator.like)
	private String name;
	@Query
	private Boolean available;
	@Query(blurry = "name,description")
	private String blurry;
	@Query
	private String parentId;

	@Query(operator = Query.Operator.between)
	private List<Timestamp> createdDate;
}
