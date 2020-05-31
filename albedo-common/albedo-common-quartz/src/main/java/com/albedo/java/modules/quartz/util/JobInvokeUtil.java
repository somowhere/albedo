package com.albedo.java.modules.quartz.util;

import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.modules.quartz.domain.Job;
import com.albedo.java.modules.quartz.service.JobService;
import com.google.common.collect.Sets;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.LinkedList;
import java.util.List;

/**
 * 任务执行工具
 *
 * @author somewhere
 */
public class JobInvokeUtil {

	public static JobService jobService = SpringContextHolder.getBean(JobService.class);

	/**
	 * 执行方法
	 *
	 * @param job 系统任务
	 */
	public static void invokeMethod(Job job) throws Exception {
		String invokeTarget = job.getInvokeTarget();
		String beanName = getBeanName(invokeTarget);
		String methodName = getMethodName(invokeTarget);
		List<Object[]> methodParams = getMethodParams(invokeTarget);

		if (!isValidClassName(beanName)) {
			Object bean = SpringContextHolder.getBean(beanName);
			invokeMethod(bean, methodName, methodParams);
		} else {
			Object bean = Class.forName(beanName).newInstance();
			invokeMethod(bean, methodName, methodParams);
		}
		// 判断是否存在子任务
		if (job.getSubTask() != null) {
			String[] tasks = job.getSubTask().split("[,，]");
			jobService.runByIds(Sets.newHashSet(tasks));
		}
	}

	/**
	 * 调用任务方法
	 *
	 * @param bean         目标对象
	 * @param methodName   方法名称
	 * @param methodParams 方法参数
	 */
	private static void invokeMethod(Object bean, String methodName, List<Object[]> methodParams)
		throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException,
		InvocationTargetException {
		if (ObjectUtil.isNotEmpty(methodParams)) {
			Method method = bean.getClass().getDeclaredMethod(methodName, getMethodParamsType(methodParams));
			method.invoke(bean, getMethodParamsValue(methodParams));
		} else {
			Method method = bean.getClass().getDeclaredMethod(methodName);
			method.invoke(bean);
		}
	}

	/**
	 * 校验是否为为class包名
	 *
	 * @param invokeTarget 名称
	 * @return true是 false否
	 */
	public static boolean isValidClassName(String invokeTarget) {
		return StringUtil.contains(invokeTarget, StringUtil.DOT);
	}

	/**
	 * 获取bean名称
	 *
	 * @param invokeTarget 目标字符串
	 * @return bean名称
	 */
	public static String getBeanName(String invokeTarget) {
		String beanName = StringUtil.subBefore(invokeTarget, StringUtil.BRACKETS_START, false);
		return StringUtil.subBefore(beanName, StringUtil.DOT, true);
	}

	/**
	 * 获取bean方法
	 *
	 * @param invokeTarget 目标字符串
	 * @return method方法
	 */
	public static String getMethodName(String invokeTarget) {
		String methodName = StringUtil.subBefore(invokeTarget, StringUtil.BRACKETS_START, false);
		return StringUtil.subAfter(methodName, StringUtil.DOT, true);
	}

	/**
	 * 获取method方法参数相关列表
	 *
	 * @param invokeTarget 目标字符串
	 * @return method方法相关参数列表
	 */
	public static List<Object[]> getMethodParams(String invokeTarget) {
		String methodStr = StringUtil.subBetween(invokeTarget, StringUtil.BRACKETS_START, StringUtil.BRACKETS_END);
		if (StringUtil.isEmpty(methodStr)) {
			return null;
		}
		String[] methodParams = methodStr.split(",");
		List<Object[]> classs = new LinkedList<>();
		for (int i = 0; i < methodParams.length; i++) {
			String str = StringUtil.trimToEmpty(methodParams[i]);
			// String字符串类型，包含'
			if (StringUtil.contains(str, "'")) {
				classs.add(new Object[]{StringUtil.replace(str, "'", ""), String.class});
			}
			// boolean布尔类型，等于true或者false
			else if (StringUtil.equals(str, "true") || StringUtil.equalsIgnoreCase(str, "false")) {
				classs.add(new Object[]{Boolean.valueOf(str), Boolean.class});
			}
			// long长整形，包含L
			else if (StringUtil.containsIgnoreCase(str, "L")) {
				classs.add(new Object[]{Long.valueOf(StringUtil.replaceIgnoreCase(str, "L", "")), Long.class});
			}
			// double浮点类型，包含D
			else if (StringUtil.containsIgnoreCase(str, "D")) {
				classs.add(new Object[]{Double.valueOf(StringUtil.replaceIgnoreCase(str, "D", "")), Double.class});
			}
			// 其他类型归类为整形
			else {
				classs.add(new Object[]{Integer.valueOf(str), Integer.class});
			}
		}
		return classs;
	}

	/**
	 * 获取参数类型
	 *
	 * @param methodParams 参数相关列表
	 * @return 参数类型列表
	 */
	public static Class<?>[] getMethodParamsType(List<Object[]> methodParams) {
		Class<?>[] classs = new Class<?>[methodParams.size()];
		int index = 0;
		for (Object[] os : methodParams) {
			classs[index] = (Class<?>) os[1];
			index++;
		}
		return classs;
	}

	/**
	 * 获取参数值
	 *
	 * @param methodParams 参数相关列表
	 * @return 参数值列表
	 */
	public static Object[] getMethodParamsValue(List<Object[]> methodParams) {
		Object[] classs = new Object[methodParams.size()];
		int index = 0;
		for (Object[] os : methodParams) {
			classs[index] = os[0];
			index++;
		}
		return classs;
	}
}
