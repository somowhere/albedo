package com.albedo.java.modules.tenant.strategy;

import com.albedo.java.modules.tenant.domain.dto.TenantConnectDto;

import java.util.List;

/**
 * 初始化系统
 * <p>
 *
 * @author zuihou
 * @date 2019/10/25
 */
public interface InitSystemStrategy {

    /**
     * 初始化 服务链接
     *
     * @param tenantConnect 链接信息
     * @return 是否成功
     */
    boolean initConnect(TenantConnectDto tenantConnect);

    /**
     * 重置系统
     *
     * @param tenant 租户编码
     * @return 是否成功
     */
    boolean reset(String tenant);

    /**
     * 删除租户数据
     *
     * @param ids            租户id
     * @param tenantCodeList 租户编码
     * @return 是否成功
     */
    boolean delete(List<Long> ids, List<String> tenantCodeList);
}
