/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.repository.JobLogRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import java.util.List;

/**
 * 任务调度日志Service 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
public interface JobLogService extends BaseService<JobLogRepository, JobLog, String> {

	void cleanJobLog();

	List<JobLogExcelVo> findExcelVo(QueryWrapper<JobLog> toEntityWrapper);
}
