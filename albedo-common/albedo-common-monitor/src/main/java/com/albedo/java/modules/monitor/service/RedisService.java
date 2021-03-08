package com.albedo.java.modules.monitor.service;

import com.albedo.java.modules.monitor.domain.RedisInfo;
import com.albedo.java.modules.monitor.domain.ReportSearchType;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.Map;

/**
 * @author somewhere
 * @date 2021-03-08
 */
public interface RedisService {

	/**
	 * 获取 redis 的详细信息
	 *
	 * @return List
	 */
	IPage<RedisInfo> getRedisInfo();

	/**
	 * 获取 redis key 数量
	 *
	 * @return Map
	 */
	Long getKeySize();

	/**
	 * 获取 redis 内存信息
	 *
	 * @return Map
	 */
	String getUsedMemory();

	/**
	 * 获取 报表需要个redis信息
	 *
	 * @param reportSearchType
	 * @return Map
	 */
	Map<String, JSONArray> getMapForReport(ReportSearchType reportSearchType);
}
