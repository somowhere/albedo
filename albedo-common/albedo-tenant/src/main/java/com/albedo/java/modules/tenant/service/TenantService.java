package com.albedo.java.modules.tenant.service;

import com.albedo.java.modules.tenant.domain.Tenant;
import com.albedo.java.modules.tenant.domain.dto.TenantConnectDto;
import com.albedo.java.modules.tenant.domain.dto.TenantDto;
import com.albedo.java.modules.tenant.enumeration.TenantStatusEnum;
import com.albedo.java.plugins.mybatis.service.DataCacheService;

import java.util.List;

/**
 * <p>
 * 业务接口
 * 企业
 * </p>
 *
 * @author somewhere
 * @date 2019-10-24
 */
public interface TenantService extends DataCacheService<Tenant, TenantDto> {
	/**
	 * 检测 租户编码是否存在
	 *
	 * @param tenantCode 租户编码
	 * @return 是否存在
	 */
	boolean check(String tenantCode);

	/**
	 * 保存/修改
	 *
	 * @param data 租户保存数据
	 * @return 租户
	 */
	void saveOrUpdate(TenantDto data);

	/**
	 * 根据编码获取
	 *
	 * @param tenant 租户编码
	 * @return 租户
	 */
	Tenant getByCode(String tenant);

	/**
	 * 通知所有服务链接数据源
	 *
	 * @param tenantConnect 链接信息
	 * @return 是否链接成功
	 */
	Boolean connect(TenantConnectDto tenantConnect);


	/**
	 * 删除租户数据
	 *
	 * @param ids id
	 * @return 是否成功
	 */
	Boolean delete(List<Long> ids);

	/**
	 * 删除租户和基础数据
	 *
	 * @param ids id
	 * @return 是否成功
	 */
	Boolean deleteAll(List<Long> ids);

	/**
	 * 查询所有可用的租户
	 *
	 * @return 租户信息
	 */
	List<Tenant> find();

	/**
	 * 修改租户状态
	 *
	 * @param ids
	 * @param status
	 * @return
	 */
	Boolean updateStatus(List<Long> ids, TenantStatusEnum status);
}
