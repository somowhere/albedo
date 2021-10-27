package com.albedo.java.common.event.listener;

import com.albedo.java.common.core.constant.ParameterKey;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.common.event.model.ParameterUpdate;
import com.albedo.java.modules.sys.service.UserOnlineService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
/**
 * 参数修改事件监听，用于调整具体的业务
 *
 * @author zuihou
 * @date 2020年03月18日17:39:59
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class ParameterUpdateListener {

    private final UserOnlineService onlineService;

    @Async
    @EventListener({ParameterUpdateEvent.class})
    public void saveSysLog(ParameterUpdateEvent event) {
        ParameterUpdate source = (ParameterUpdate) event.getSource();

        ContextUtil.setTenant(source.getTenant());
        if (ParameterKey.LOGIN_POLICY.equals(source.getKey())) {
            onlineService.reset();
        }
    }
}
