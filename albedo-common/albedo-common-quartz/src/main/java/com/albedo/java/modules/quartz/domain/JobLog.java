/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.quartz.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.annotation.SearchField;
import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 任务调度日志Entity 任务调度日志
 *
 * @author admin
 * @version 2019-08-14 11:25:03
 */
@TableName(value = "sys_job_log")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class JobLog extends GeneralEntity<JobLog> {

	/**
	 * F_JOBNAME job_name  :  任务名称
	 */
	public static final String F_JOBNAME = "jobName";
	/**
	 * F_SQL_JOBNAME job_name  :  任务名称
	 */
	public static final String F_SQL_JOBNAME = "job_name";
	/**
	 * F_JOBGROUP job_group  :  任务组名
	 */
	public static final String F_JOBGROUP = "jobGroup";
	/**
	 * F_SQL_JOBGROUP job_group  :  任务组名
	 */
	public static final String F_SQL_JOBGROUP = "job_group";
	/**
	 * F_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	public static final String F_INVOKETARGET = "invokeTarget";
	/**
	 * F_SQL_INVOKETARGET invoke_target  :  调用目标字符串
	 */
	public static final String F_SQL_INVOKETARGET = "invoke_target";
	/**
	 * F_JOBMESSAGE job_message  :  日志信息
	 */
	public static final String F_JOBMESSAGE = "jobMessage";
	/**
	 * F_SQL_JOBMESSAGE job_message  :  日志信息
	 */
	public static final String F_SQL_JOBMESSAGE = "job_message";
	/**
	 * F_STATUS status  :  执行状态（1正常 1失败）
	 */
	public static final String F_STATUS = "status";
	/**
	 * F_SQL_STATUS status  :  执行状态（1正常 1失败）
	 */
	public static final String F_SQL_STATUS = "status";
	/**
	 * F_STARTTIME start_time  :  开始时间
	 */
	public static final String F_STARTTIME = "startTime";
	/**
	 * F_SQL_STARTTIME start_time  :  开始时间
	 */
	public static final String F_SQL_STARTTIME = "start_time";
	/**
	 * F_ENDTIME end_time  :  结束时间
	 */
	public static final String F_ENDTIME = "endTime";
	/**
	 * F_SQL_ENDTIME end_time  :  结束时间
	 */
	public static final String F_SQL_ENDTIME = "end_time";
	/**
	 * F_CREATETIME create_time  :  创建时间
	 */
	public static final String F_CREATETIME = "createTime";
	/**
	 * F_SQL_CREATETIME create_time  :  创建时间
	 */
	public static final String F_SQL_CREATETIME = "create_time";
	/**
	 * F_EXCEPTIONINFO exception_info  :  异常信息
	 */
	public static final String F_EXCEPTIONINFO = "exceptionInfo";
	/**
	 * F_SQL_EXCEPTIONINFO exception_info  :  异常信息
	 */
	public static final String F_SQL_EXCEPTIONINFO = "exception_info";
	private static final long serialVersionUID = 1L;
	//columns START
	@TableId(value = GeneralEntity.F_SQL_ID, type = IdType.AUTO)
	@SearchField
	protected Long id;
	@TableField(GeneralEntity.F_SQL_DESCRIPTION)
	protected String description;
	/**
	 * jobName 任务名称
	 */
	@NotBlank
	@Size(max = 64)
	@TableField(F_SQL_JOBNAME)
	private String jobName;
	/**
	 * jobGroup 任务组名
	 */
	@NotBlank
	@Size(max = 64)
	@TableField(F_SQL_JOBGROUP)
	private String jobGroup;
	/**
	 * invokeTarget 调用目标字符串
	 */
	@NotBlank
	@Size(max = 500)
	@TableField(F_SQL_INVOKETARGET)
	private String invokeTarget;
	/**
	 * jobMessage 日志信息
	 */
	@Size(max = 500)
	@TableField(F_SQL_JOBMESSAGE)
	private String jobMessage;
	/**
	 * status 执行状态（1正常 1失败）
	 */
	@Size(max = 1)
	@TableField("status")
	@DictType("sys_status")
	private String status;
	/**
	 * startTime 开始时间
	 */
	@TableField("start_time")
	private Date startTime;
	/**
	 * endTime 结束时间
	 */
	@TableField("end_time")
	private Date endTime;
	/**
	 * createTime 创建时间
	 */
	@TableField("create_time")
	private Date createTime;
	/**
	 * exceptionInfo 异常信息
	 */
	@Size(max = 2000)
	@TableField("exception_info")
	private String exceptionInfo;
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
