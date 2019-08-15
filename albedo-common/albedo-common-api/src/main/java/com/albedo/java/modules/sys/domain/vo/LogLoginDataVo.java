/**
 * Copyright &copy; 2018 <a href="https://github.com/somewhereMrli/albedo-boot">albedo-boot</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain.vo;

import com.albedo.java.common.core.vo.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.Size;
import java.util.Date;

/**
 * 登录日志EntityVo 登录日志
 *
 * @author admin
 * @version 2019-08-15 09:32:16
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LogLoginDataVo extends DataEntityVo<Long> {

	/**
	 * F_LOGINNAME login_name  :  登录账号
	 */
	public static final String F_LOGINNAME = "loginName";
	/**
	 * F_IPADDRESS ip_address  :  登录IP地址
	 */
	public static final String F_IPADDRESS = "ipAddress";
	/**
	 * F_LOGINLOCATION login_location  :  登录地点
	 */
	public static final String F_LOGINLOCATION = "loginLocation";
	/**
	 * F_USERAGENT user_agent  :  用户代理
	 */
	public static final String F_USERAGENT = "userAgent";
	/**
	 * F_BROWSER browser  :  浏览器类型
	 */
	public static final String F_BROWSER = "browser";
	/**
	 * F_OS os  :  操作系统
	 */
	public static final String F_OS = "os";
	/**
	 * F_STATUS status  :  登录状态
	 */
	public static final String F_STATUS = "status";
	/**
	 * F_MESSAGE message  :  提示消息
	 */
	public static final String F_MESSAGE = "message";
	/**
	 * F_LOGINTIME login_time  :  访问时间
	 */
	public static final String F_LOGINTIME = "loginTime";
	private static final long serialVersionUID = 1L;

	//columns START
	/**
	 * loginName 登录账号
	 */
	@Size(max = 50)
	private String loginName;
	/**
	 * ipAddress 登录IP地址
	 */
	@Size(max = 50)
	private String ipAddress;
	/**
	 * loginLocation 登录地点
	 */
	@Size(max = 255)
	private String loginLocation;
	/**
	 * userAgent 用户代理
	 */
	@Size(max = 1000)
	private String userAgent;
	/**
	 * browser 浏览器类型
	 */
	@Size(max = 50)
	private String browser;
	/**
	 * os 操作系统
	 */
	@Size(max = 50)
	private String os;
	/**
	 * status 登录状态
	 */
	@Size(max = 1)
	private String status;
	/**
	 * message 提示消息
	 */
	@Size(max = 255)
	private String message;
	/**
	 * loginTime 访问时间
	 */

	private Date loginTime;
	//columns END

}
