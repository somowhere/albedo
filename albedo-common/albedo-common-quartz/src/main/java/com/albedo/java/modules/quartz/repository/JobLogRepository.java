/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.repository;


import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.quartz.domain.JobLog;
import com.albedo.java.modules.quartz.domain.vo.JobLogExcelVo;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 任务调度日志Repository 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
public interface JobLogRepository extends BaseRepository<JobLog> {

	void cleanJobLog();

	List<JobLogExcelVo> findExcelVo(@Param("ew") Wrapper wrapper);
}
