package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.modules.sys.domain.LoggingEvent;
import com.albedo.java.modules.sys.service.LoggingEventService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.web.rest.base.BaseResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;

/**
 * 操作日志Controller 操作日志
 * @author admin
 * @version 2017-01-03
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/loggingEvent")
public class LoggingEventResource extends BaseResource {

	@Resource
	private LoggingEventService loggingEventService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/loggingEventList";
	}

	/**
	 * GET / : get all loggingEvent.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all loggingEvent
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<LoggingEvent> pm, HttpServletResponse response) {
		SpecificationDetail<LoggingEvent> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson());
		Page<LoggingEvent> page = loggingEventService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr().toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}

}