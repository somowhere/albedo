/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.TaskScheduleJob;

import java.util.List;

/**
 * 任务调度管理Repository 任务调度
 *
 * @author lj
 * @version 2017-01-23
 */
public interface TaskScheduleJobRepository extends BaseRepository<TaskScheduleJob, String> {

    List<TaskScheduleJob> findByStatusAndJobStatus(Integer status, String jobStatus);

    TaskScheduleJob findTopBySourceIdAndStatusNot(String soruceId, Integer flagDelete);

    List<TaskScheduleJob> findAllBySourceId(String sourceId);
}