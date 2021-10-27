package com.albedo.java.plugins.database.plugins;

import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import net.sf.jsqlparser.expression.ValueListExpression;

/**
 * @author zuihou
 * @version v1.0
 * @date 2021/5/17 8:52 下午
 * @create [2021/5/17 8:52 下午 ] [zuihou] [初始创建]
 */
public interface MultiTenantLineHandler extends TenantLineHandler {
    /**
     * 获取租户 ID 值表达式，支持多个 ID 值
     * <p>
     *
     * @return 租户 ID 值表达式
     */
    ValueListExpression getTenantIdList();
}
