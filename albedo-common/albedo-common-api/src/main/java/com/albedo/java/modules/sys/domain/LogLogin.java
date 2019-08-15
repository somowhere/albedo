/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 登录日志Entity 登录日志
 *
 * @author admin
 * @version 2019-08-15 09:32:16
 */
@TableName(value = "sys_log_login")
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class LogLogin extends BaseEntity<LogLogin> {

	/**
	 * F_LOGINNAME login_name  :  登录账号
	 */
	public static final String F_LOGINNAME = "loginName";
	/**
	 * F_SQL_LOGINNAME login_name  :  登录账号
	 */
	public static final String F_SQL_LOGINNAME = "login_name";
	/**
	 * F_IPADDRESS ip_address  :  登录IP地址
	 */
	public static final String F_IPADDRESS = "ipAddress";
	/**
	 * F_SQL_IPADDRESS ip_address  :  登录IP地址
	 */
	public static final String F_SQL_IPADDRESS = "ip_address";
	/**
	 * F_LOGINLOCATION login_location  :  登录地点
	 */
	public static final String F_LOGINLOCATION = "loginLocation";
	/**
	 * F_SQL_LOGINLOCATION login_location  :  登录地点
	 */
	public static final String F_SQL_LOGINLOCATION = "login_location";
	/**
	 * F_USERAGENT user_agent  :  用户代理
	 */
	public static final String F_USERAGENT = "userAgent";
	/**
	 * F_SQL_USERAGENT user_agent  :  用户代理
	 */
	public static final String F_SQL_USERAGENT = "user_agent";
	/**
	 * F_BROWSER browser  :  浏览器类型
	 */
	public static final String F_BROWSER = "browser";
	/**
	 * F_SQL_BROWSER browser  :  浏览器类型
	 */
	public static final String F_SQL_BROWSER = "browser";
	/**
	 * F_OS os  :  操作系统
	 */
	public static final String F_OS = "os";
	/**
	 * F_SQL_OS os  :  操作系统
	 */
	public static final String F_SQL_OS = "os";
	/**
	 * F_STATUS status  :  登录状态
	 */
	public static final String F_STATUS = "status";
	/**
	 * F_SQL_STATUS status  :  登录状态
	 */
	public static final String F_SQL_STATUS = "status";
	/**
	 * F_MESSAGE message  :  提示消息
	 */
	public static final String F_MESSAGE = "message";
	/**
	 * F_SQL_MESSAGE message  :  提示消息
	 */
	public static final String F_SQL_MESSAGE = "message";
	/**
	 * F_LOGINTIME login_time  :  访问时间
	 */
	public static final String F_LOGINTIME = "loginTime";
	/**
	 * F_SQL_LOGINTIME login_time  :  访问时间
	 */
	public static final String F_SQL_LOGINTIME = "login_time";
	private static final long serialVersionUID = 1L;

	//columns START
	/**
	 * loginName 登录账号
	 */
	@Size(max = 50)
	@TableField(F_SQL_LOGINNAME)
	private String loginName;
	/**
	 * ipAddress 登录IP地址
	 */
	@Size(max = 50)
	@TableField(F_SQL_IPADDRESS)
	private String ipAddress;
	/**
	 * loginLocation 登录地点
	 */
	@Size(max = 255)
	@TableField(F_SQL_LOGINLOCATION)
	private String loginLocation;
	/**
	 * userAgent 用户代理
	 */
	@Size(max = 1000)
	@TableField(F_SQL_USERAGENT)
	private String userAgent;
	/**
	 * browser 浏览器类型
	 */
	@Size(max = 50)
	@TableField(F_SQL_BROWSER)
	private String browser;
	/**
	 * os 操作系统
	 */
	@Size(max = 50)
	@TableField(F_SQL_OS)
	private String os;
	/**
	 * status 登录状态
	 */
	@Size(max = 1)
	@TableField(F_SQL_STATUS)
	@DictType("sys_status")
	private String status;
	/**
	 * message 提示消息
	 */
	@Size(max = 255)
	@TableField(F_SQL_MESSAGE)
	private String message;
	/**
	 * loginTime 访问时间
	 */
	@TableField(F_SQL_LOGINTIME)
	private Date loginTime;
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
