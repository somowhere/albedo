/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.modules.sys.domain.LoggingEvent;
import com.albedo.java.modules.sys.repository.LoggingEventRepository;
import com.albedo.java.util.domain.PageModel;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


/**
 * 操作日志Service 操作日志
 * @author admin
 * @version 2017-01-03
 */
@Service
@Transactional
public class LoggingEventService{

	@Resource
    private LoggingEventRepository loggingEventRepository;

	@Transactional(readOnly=true)
	public LoggingEvent findOne(String id) {
		return loggingEventRepository.findOne(id);
	}

	@Transactional(readOnly=true)
	public Page<LoggingEvent> findAll(SpecificationDetail<LoggingEvent> spec, PageModel<LoggingEvent> pm) {
		return loggingEventRepository.findAll(spec, pm);
	}
}