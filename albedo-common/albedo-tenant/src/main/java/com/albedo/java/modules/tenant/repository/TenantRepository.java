package com.albedo.java.modules.tenant.repository;

import com.albedo.java.plugins.mybatis.repository.BaseRepository;
import com.albedo.java.modules.tenant.domain.Tenant;
import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * Mapper 接口
 * 企业
 * </p>
 *
 * @author zuihou
 * @date 2019-10-25
 */
@Repository
@InterceptorIgnore(tenantLine = "true", dynamicTableName = "true")
public interface TenantRepository extends BaseRepository<Tenant> {

    /**
     * 根据租户编码查询
     *
     * @param code 租户编码
     * @return 租户
     */
    Tenant getByCode(@Param("code") String code);
}
