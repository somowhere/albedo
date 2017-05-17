package com.albedo.java.common;

import com.albedo.java.common.config.template.FreeMarkerConfig;
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
        SpringContextHolder.getBean(FreeMarkerConfig.class).afterPropertiesSet();

//        SpringContextHolder.getBean(TaskScheduleJobService.class).init();

    }




}
