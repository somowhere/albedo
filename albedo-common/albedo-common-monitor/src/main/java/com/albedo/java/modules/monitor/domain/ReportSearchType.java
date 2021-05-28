package com.albedo.java.modules.monitor.domain;

/**
 * redis key数量 / 占用内存 /redis信息
 *
 * @author somewhere
 * @date 2021-03-08
 */
public enum ReportSearchType {

	/**
	 * key数量
	 */
	KEY,
	/**
	 * 占用内存
	 */
	RAM,
	/**
	 * redis信息
	 */
	INFO

}
