/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.persistence.domain.IdEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

/**
 * 任务调度Entity 任务调度
 *
 * @author admin
 * @version 2019-08-14 11:24:16
 */
@TableName(value = "sys_job")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class Job extends IdEntity<Job> {

	/**
	 * F_NAME name  :  任务名称
	 */
	public static final String F_NAME = "name";
	/**
	 * F_SQL_NAME name  :  任务名称
	 */
	public static final String F_SQL_NAME = "name";
	/**
	 * F_GROUP group  :  任务组名
	 */
	public static final String F_GROUP = "group";
	/**
	 * F_SQL_GROUP group  :  任务组名
	 */
	public static final String F_SQL_GROUP = "group";
	/**
	 * F_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	public static final String F_INVOKETARGET = "invokeTarget";
	/**
	 * F_SQL_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	public static final String F_SQL_INVOKETARGET = "invoke_target";
	/**
	 * F_CRONEXPRESSION cron_expression  :  cron执行表达式
	 */
	public static final String F_CRONEXPRESSION = "cronExpression";
	/**
	 * F_SQL_CRONEXPRESSION cron_expression  :  cron执行表达式
	 */
	public static final String F_SQL_CRONEXPRESSION = "cron_expression";
	/**
	 * F_MISFIREPOLICY misfire_policy  :  计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	public static final String F_MISFIREPOLICY = "misfirePolicy";
	/**
	 * F_SQL_MISFIREPOLICY misfire_policy  :  计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	public static final String F_SQL_MISFIREPOLICY = "misfire_policy";
	/**
	 * F_CONCURRENT concurrent  :  是否并发执行（1允许 0禁止）
	 */
	public static final String F_CONCURRENT = "concurrent";
	/**
	 * F_SQL_CONCURRENT concurrent  :  是否并发执行（1允许 0禁止）
	 */
	public static final String F_SQL_CONCURRENT = "concurrent";
	/**
	 * F_AVAILABLE available  :  状态(1-正常，0-锁定)
	 */
	public static final String F_AVAILABLE = "available";
	/**
	 * F_SQL_AVAILABLE available  :  状态(1-正常，0-锁定)
	 */
	public static final String F_SQL_AVAILABLE = "available";
	private static final long serialVersionUID = 1L;

	//columns START
	/**
	 * name 任务名称
	 */
	@NotBlank
	@Size(max = 64)
	@TableField("name")
	private String name;
	/**
	 * group 任务组名
	 */
	@NotBlank
	@Size(max = 64)
	@TableField("`group`")
	@DictType("sys_job_group")
	private String group;
	/**
	 * invokeTarget 调用目标字符串
	 */
	@NotBlank
	@Size(max = 500)
	@TableField("invoke_target")
	private String invokeTarget;
	/**
	 * cronExpression cron执行表达式
	 */
	@Size(max = 255)
	@TableField("cron_expression")
	private String cronExpression;
	/**
	 * misfirePolicy 计划执行错误策略（1立即执行 2执行一次 3放弃执行）
	 */
	@Size(max = 20)
	@TableField("misfire_policy")
	@DictType("sys_misfire_policy")
	private String misfirePolicy;
	/**
	 * concurrent 是否并发执行（1允许 0禁止）
	 */
	@Size(max = 1)
	@TableField("concurrent")
	@DictType("sys_flag")
	private String concurrent;
	/**
	 * available 状态(1-正常，0-锁定)
	 */
	@Size(max = 1)
	@TableField("available")
	@DictType("sys_flag")
	private String available;
	//columns END

	@Override
	public boolean equals(Object o) {
		return super.equals(o);
	}

	@Override
	public int hashCode() {
		return super.hashCode();
	}
}
