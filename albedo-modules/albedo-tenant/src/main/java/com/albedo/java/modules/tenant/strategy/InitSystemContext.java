package com.albedo.java.modules.tenant.strategy;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.modules.tenant.domain.dto.TenantConnectDto;
import com.albedo.java.plugins.database.properties.DatabaseProperties;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 初始化系统上下文
 *
 * @author somewhere
 * @date 2020年03月15日11:58:47
 */
@Component
public class InitSystemContext {
	private final Map<String, InitSystemStrategy> initSystemStrategyMap = new ConcurrentHashMap<>();
	private final DatabaseProperties databaseProperties;

	public InitSystemContext(Map<String, InitSystemStrategy> strategyMap, DatabaseProperties databaseProperties) {
		strategyMap.forEach(this.initSystemStrategyMap::put);
		this.databaseProperties = databaseProperties;
	}

	/**
	 * 初始化链接
	 *
	 * @param tenantConnect 链接参数
	 */
	public boolean initConnect(TenantConnectDto tenantConnect) {
		InitSystemStrategy initSystemStrategy = initSystemStrategyMap.get(databaseProperties.getMultiTenantType().name());
		ArgumentAssert.notNull(initSystemStrategy, StrUtil.format("您配置的租户模式:{}不可用", databaseProperties.getMultiTenantType().name()));

		return initSystemStrategy.initConnect(tenantConnect);
	}

	/**
	 * 重置系统
	 *
	 * @param tenant 租户编码
	 */
	public boolean reset(String tenant) {
		InitSystemStrategy initSystemStrategy = initSystemStrategyMap.get(databaseProperties.getMultiTenantType().name());
		ArgumentAssert.notNull(initSystemStrategy, StrUtil.format("您配置的租户模式:{}不可用", databaseProperties.getMultiTenantType().name()));
		return initSystemStrategy.reset(tenant);
	}

	/**
	 * 删除租户数据
	 *
	 * @param tenantCodeList 租户编码
	 */
	public boolean delete(List<Long> ids, List<String> tenantCodeList) {
		InitSystemStrategy initSystemStrategy = initSystemStrategyMap.get(databaseProperties.getMultiTenantType().name());
		ArgumentAssert.notNull(initSystemStrategy, StrUtil.format("您配置的租户模式:{}不可用", databaseProperties.getMultiTenantType().name()));

		return initSystemStrategy.delete(ids, tenantCodeList);
	}
}
