package com.albedo.java.modules.sys.util;

import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.spring.SpringContextHolder;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class TaskScheduleUtils {
    protected static Logger logger = LoggerFactory.getLogger(TaskScheduleUtils.class);

    /**
     * 通过反射调用scheduleJob中定义的方法
     *
     * @param scheduleJob
     */
    public static void invokMethod(TaskScheduleJob scheduleJob) {
        Object object = null;
        Class clazz = null;
        if (StringUtils.isNotBlank(scheduleJob.getSpringId())) {
            object = SpringContextHolder.getBean(scheduleJob.getSpringId());
            if (object != null && object.getClass().getName().contains("$Proxy")) {
                try {
                    object = Reflections.getTargetClass(object).newInstance();
                } catch (Exception e) {
                    logger.warn("msg : {}", e.getMessage());
                }
            }
        } else if (StringUtils.isNotBlank(scheduleJob.getBeanClass())) {
            try {
                clazz = Class.forName(scheduleJob.getBeanClass());
                object = clazz.newInstance();
            } catch (Exception e) {
                logger.warn("msg : {}", e.getMessage());
            }

        }
        if (object == null) {
            logger.error("任务名称 = [{}]---------------未启动成功，请检查是否配置正确！！！", scheduleJob.getName());
            return;
        }
        try {
            List<Object> paramsList = Lists.newArrayList();
            String params = StringEscapeUtils.unescapeHtml4(scheduleJob.getMethodParams());
            if (PublicUtil.isNotEmpty(params)) {
                try {
                    if (params.startsWith("[")) {
                        JSON.parseArray(params, TaskTargetParam.class).forEach(item -> {
                            paramsList.add(item.getRelValue());
                        });
                    } else {
                        paramsList.add(JSON.parseObject(params, TaskTargetParam.class).getRelValue());
                    }
                } catch (Exception e) {
                    logger.warn("msg {}", e);
                }
            }
            logger.info("任务 = [{}] [{}]---------------启动", scheduleJob.getGroup(), scheduleJob.getName());
            Reflections.invokeMethodByName(object, scheduleJob.getMethodName(), paramsList.toArray());
        } catch (SecurityException e) {
            e.printStackTrace();
            logger.warn("msg : {}", e.getMessage());
        }
        logger.info("任务 = [{}] [{}]---------------执行成功", scheduleJob.getGroup(), scheduleJob.getName());
    }
}
