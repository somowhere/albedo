package com.albedo.java.common.log.enums;

/**
 * 业务操作类型
 *
 * @author somewhere
 */
public enum BusinessType {

	/**
	 * 查看
	 */
	VIEW,

	/**
	 * 编辑
	 */
	EDIT,
	/**
	 * 锁定
	 */
	LOCK,

	/**
	 * 删除
	 */
	DELETE,

	/**
	 * 导出
	 */
	EXPORT,

	/**
	 * 导入
	 */
	IMPORT,

	/**
	 * 强退
	 */
	FORCE_LOGOUT,
	/**
	 * 登录
	 */
	LOGIN,

	/**
	 * 生成代码
	 */
	GENCODE,
	/**
	 * 清空
	 */
	CLEAN,

	/**
	 * 其它
	 */
	OTHER

}
