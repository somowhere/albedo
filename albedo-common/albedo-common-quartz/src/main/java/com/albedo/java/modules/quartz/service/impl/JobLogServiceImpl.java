/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.service.impl;

import com.albedo.java.common.persistence.service.impl.BaseServiceImpl;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.albedo.java.modules.quartz.repository.JobLogRepository;
import com.albedo.java.modules.quartz.service.JobLogService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 任务调度日志ServiceImpl 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class JobLogServiceImpl extends BaseServiceImpl<JobLogRepository, JobLog, String> implements JobLogService {

	@Override
	public void cleanJobLog() {
		repository.cleanJobLog();
	}

	@Override
	public List<JobLogExcelVo> findExcelVo(QueryWrapper<JobLog> toEntityWrapper) {
		return repository.findExcelVo(toEntityWrapper);
	}
}
