/*
 * Copyright (c) 2017 Baidu, Inc. All Rights Reserve.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.albedo.java.plugins.uid;

import com.baidu.fsg.uid.worker.entity.WorkerNodeEntity;
import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

/**
 * DAO for M_WORKER_NODE
 *
 * @author yutianbao
 */
@Mapper
@InterceptorIgnore(tenantLine = "true", dynamicTableName = "true")
public interface WorkerNodeDao {

	/**
	 * Get {@link WorkerNodeEntity} by node host
	 *
	 * @param host
	 * @param port
	 * @return
	 */
//    @Select("SELECT id, host_name, port, type,launch_date, modified, created FROM worker_node WHERE host_name = #{host} AND port = #{port}")
//    WorkerNodeEntity getWorkerNodeByHostPort(@Param("host") String host, @Param("port") String port);

	/**
	 * Add {@link WorkerNodeEntity}
	 *
	 * @param workerNodeEntity
	 */
	@Insert("INSERT INTO worker_node(host_name,port, type, launch_date,modified,created) " +
		"VALUES (#{hostName},#{port},#{type},#{launchDate},NOW(),NOW())")
	void addWorkerNode(WorkerNodeEntity workerNodeEntity);

}
