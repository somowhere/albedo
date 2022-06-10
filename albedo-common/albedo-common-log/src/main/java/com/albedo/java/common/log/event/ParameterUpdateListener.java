package com.albedo.java.common.log.event;

import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.log.event.model.ParameterUpdate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

/**
 * 参数修改事件监听，用于调整具体的业务
 *
 * @author somewhere
 * @date 2020年03月18日17:39:59
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class ParameterUpdateListener {

	@Async
	@EventListener({ParameterUpdateEvent.class})
	public void saveSysLog(ParameterUpdateEvent event) {
		ParameterUpdate source = (ParameterUpdate) event.getSource();

		ContextUtil.setTenant(source.getTenant());
	}
}
