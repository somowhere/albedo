package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.constant.DictNameConstants;
import com.albedo.java.common.persistence.domain.BaseEntity;
import com.albedo.java.modules.sys.domain.enums.OnlineStatus;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 当前在线会话 sys_user_online
 *
 * @author somewhere
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_user_online")
public class UserOnline extends BaseEntity<UserOnline> {

	private static final long serialVersionUID = 1L;

	/**
	 * 用户会话id
	 */
	@TableId(type = IdType.ASSIGN_ID)
	private String sessionId;

	/**
	 * 部门ID
	 */
	private String deptId;

	/**
	 * 部门名称
	 */
	private String deptName;

	/**
	 * 登录ID
	 */
	private String userId;

	/**
	 * 登录名称
	 */
	private String username;

	/**
	 * 登录IP地址
	 */
	private String ipAddress;

	/**
	 * 登录地址
	 */
	private String ipLocation;

	/**
	 * 操作系统
	 */
	private String userAgent;

	/**
	 * 浏览器类型
	 */
	private String browser;

	/**
	 * 操作系统
	 */
	private String os;

	/**
	 * session创建时间
	 */
	private Date startTimestamp;

	/**
	 * session最后访问时间
	 */
	private Date lastAccessTime;

	/**
	 * 超时时间，单位为分钟
	 */
	private Long expireTime;

	/**
	 * 在线状态
	 */
	@DictType(DictNameConstants.SYS_ONLINE_STATUS)
	private OnlineStatus status = OnlineStatus.on_line;

}
