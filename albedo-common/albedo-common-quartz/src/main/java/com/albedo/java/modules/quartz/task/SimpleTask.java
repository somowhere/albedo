package com.albedo.java.modules.quartz.task;

import com.albedo.java.common.core.util.StringUtil;
import org.springframework.stereotype.Component;

/**
 * 定时任务调度测试
 *
 * @author somewhere
 */
@Component
public class SimpleTask {
	public void doMultipleParams(String s, Boolean b, Long l, Double d, Integer i) {
		System.out.println(StringUtil.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
	}

	public void doParams(String params) {
		System.out.println("执行有参方法：" + params);
	}

	public void doNoParams() {
		System.out.println("执行无参方法");
	}
}
