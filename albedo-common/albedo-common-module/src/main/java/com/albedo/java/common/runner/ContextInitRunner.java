package com.albedo.java.common.runner;

import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.AnnotationUtils;

import java.lang.reflect.Method;
import java.util.Map;

/**
 * Created by somewhere on 2017/5/17.
 *
 * @author 837158334@qq.com
 */
@Slf4j
public class ContextInitRunner implements ApplicationRunner {

	@Override
	public void run(ApplicationArguments args) throws Exception {
		log.debug(">>>>> spring afterPropertiesSet init start <<<<<");
		// spring初始化完毕后，通过反射调用所有使用BaseInit注解的afterPropertiesSet方法
		Map<String, Object> baseServices = SpringContextHolder.getApplicationContext().getBeansWithAnnotation(BaseInit.class);
		if (ObjectUtil.isNotEmpty(baseServices)) {
			for (Object service : baseServices.values()) {
				log.debug(">>>>> {}.afterPropertiesSet()", service.getClass().getName());
				try {
					BaseInit annotation = AnnotationUtils.findAnnotation(service.getClass(), BaseInit.class);
					Method initMapper = service.getClass().getMethod(annotation.method());
					initMapper.invoke(service);
				} catch (Exception e) {
                    log.error("failed init", e);
				}
			}
		}
		log.debug(">>>>> spring afterPropertiesSet init end <<<<<");

	}
}
