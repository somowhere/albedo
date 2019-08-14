package com.albedo.java.common.runner;

import com.albedo.java.common.core.annotation.BaseInit;
import com.albedo.java.common.core.annotation.BaseInterface;
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
		log.debug(">>>>> spring afterPropertiesSet 初始化开始 <<<<<");
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
					log.error("初始化BaseInit的afterPropertiesSet方法异常{}", e);
					e.printStackTrace();
				}
			}
		}
		log.debug(">>>>> spring afterPropertiesSet 初始化完毕 <<<<<");
		// 系统入口初始化
		log.debug(">>>>> spring init 初始化开始 <<<<<");
		Map<String, BaseInterface> baseInterfaceBeans = SpringContextHolder.getApplicationContext().getBeansOfType(BaseInterface.class);
		if (ObjectUtil.isNotEmpty(baseInterfaceBeans)) {
			for (Object service : baseInterfaceBeans.values()) {
				log.debug(">>>>> {}.init()", service.getClass().getName());
				try {
					Method init = service.getClass().getMethod("init");
					init.invoke(service);
				} catch (Exception e) {
					log.error("初始化BaseInterface的init方法异常{}", e);
					e.printStackTrace();
				}
			}
		}

		log.debug(">>>>> spring init 初始化完毕 <<<<<");
	}
}
