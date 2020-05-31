package com.albedo.java.modules.sys.web;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import com.albedo.java.common.core.util.ResponseEntityBuilder;
import com.albedo.java.common.web.resource.vm.LoggerVo;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Controller for view and managing Log Level at runtime.
 *
 * @author somewhere
 */
@RestController
@RequestMapping("/management")
public class LogsResource {

	@GetMapping("/logs")
	public List<LoggerVo> getList() {
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		return context.getLoggerList()
			.stream()
			.map(LoggerVo::new)
			.collect(Collectors.toList());
	}

	@PutMapping("/logs")
	public ResponseEntity changeLevel(@RequestBody LoggerVo jsonLogger) {
		LoggerContext context = (LoggerContext) LoggerFactory.getILoggerFactory();
		context.getLogger(jsonLogger.getName()).setLevel(Level.valueOf(jsonLogger.getLevel()));
		return ResponseEntityBuilder.buildOk("操作成功");
	}
}
