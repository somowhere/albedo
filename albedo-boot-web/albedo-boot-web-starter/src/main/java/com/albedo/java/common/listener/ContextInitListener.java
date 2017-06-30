package com.albedo.java.common.listener;

import com.albedo.java.common.config.template.FreeMarkerConfig;
import com.albedo.java.common.security.service.InvocationSecurityMetadataSourceService;
import com.albedo.java.util.spring.SpringContextHolder;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

/**
 * Created by lijie on 2017/5/17.
 *
 * @author 837158334@qq.com
 */

public class ContextInitListener implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        //初始化权限数据
        ((InvocationSecurityMetadataSourceService) SpringContextHolder.
                getBean("invocationSecurityMetadataSourceService")).afterPropertiesSet();
        //初始化freeMarker引擎数据
        SpringContextHolder.getBean(FreeMarkerConfig.class).afterPropertiesSet();
        //初始化任务
//        SpringContextHolder.getBean(TaskScheduleJobService.class).init();

    }




}
