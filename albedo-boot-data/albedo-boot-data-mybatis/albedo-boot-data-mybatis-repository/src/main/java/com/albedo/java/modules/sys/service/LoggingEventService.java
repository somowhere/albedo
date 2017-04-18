/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.data.mybatis.persistence.SpecificationDetail;
import com.albedo.java.common.data.mybatis.persistence.service.BaseService;
import com.albedo.java.modules.sys.domain.LoggingEvent;
import com.albedo.java.modules.sys.repository.LoggingEventRepository;
import com.albedo.java.util.domain.PageModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * 操作日志Service 操作日志
 * @author admin
 * @version 2017-01-03
 */
@Service
@Transactional
public class LoggingEventService extends BaseService<LoggingEventRepository, LoggingEvent, String>{

	@Transactional(readOnly=true)
	public LoggingEvent findOne(String id) {
		return repository.findOne(id);
	}

	@Transactional(readOnly=true)
	public PageModel<LoggingEvent> findPage(PageModel<LoggingEvent> pm) {
		SpecificationDetail<LoggingEvent> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson());
		return findPage(pm, spec);
	}
}