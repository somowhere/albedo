package com.albedo.java.common.listener;

import com.albedo.java.common.config.template.FreeMarkerConfig;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.common.security.service.InvocationSecurityMetadataSourceService;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.spring.SpringContextHolder;
import com.google.common.collect.Maps;
import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.TemplateHashModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

import java.util.Map;

/**
 * Created by lijie on 2017/5/17.
 *
 * @author 837158334@qq.com
 */

public class ContextInitListener implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        ((InvocationSecurityMetadataSourceService) SpringContextHolder.
                getBean("invocationSecurityMetadataSourceService")).afterPropertiesSet();
        SpringContextHolder.getBean(FreeMarkerConfig.class).afterPropertiesSet();

//        SpringContextHolder.getBean(TaskScheduleJobService.class).init();

    }




}
