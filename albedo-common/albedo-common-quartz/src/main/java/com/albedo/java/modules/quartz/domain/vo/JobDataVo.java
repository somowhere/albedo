/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.domain.vo;

import com.albedo.java.common.core.vo.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 任务调度EntityVo 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class JobDataVo extends DataEntityVo<String> {

	/**
	 * F_NAME name  :  任务名称
	 */
	public static final String F_NAME = "name";
	/**
	 * F_GROUP group  :  任务组名
	 */
	public static final String F_GROUP = "group";
	/**
	 * F_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	public static final String F_INVOKETARGET = "invokeTarget";
	/**
	 * F_CRONEXPRESSION cron_expression  :  cron执行表达式
	 */
	public static final String F_CRONEXPRESSION = "cronExpression";
	/**
	 * F_MISFIREPOLICY misfire_policy  :  计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	public static final String F_MISFIREPOLICY = "misfirePolicy";
	/**
	 * F_CONCURRENT concurrent  :  是否并发执行（1允许 0禁止）
	 */
	public static final String F_CONCURRENT = "concurrent";
	/**
	 * F_AVAILABLE available  :  状态(1-正常，0-锁定)
	 */
	public static final String F_AVAILABLE = "available";
	private static final long serialVersionUID = 1L;

	//columns START
	/**
	 * name 任务名称
	 */
	@NotBlank
	@Size(max = 64)
	private String name;
	/**
	 * group 任务组名
	 */
	@NotBlank
	@Size(max = 64)
	private String group;
	/**
	 * invokeTarget 调用目标字符串
	 */
	@NotBlank
	@Size(max = 500)
	private String invokeTarget;
	/**
	 * cronExpression cron执行表达式
	 */
	@Size(max = 255)
	private String cronExpression;
	/**
	 * misfirePolicy 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	@Size(max = 20)
	private String misfirePolicy;
	/**
	 * concurrent 是否并发执行（1允许 0禁止）
	 */
	@Size(max = 1)
	private String concurrent;
	/**
	 * available 状态(1-正常，0-锁定)
	 */
	@Size(max = 1)
	private String available;
	//columns END

}
