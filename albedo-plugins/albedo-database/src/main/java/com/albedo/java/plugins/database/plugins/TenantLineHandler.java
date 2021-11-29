package com.albedo.java.plugins.database.plugins;

import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.schema.Column;

import java.util.List;

/**
 * 租户处理器（ TenantId 行级 ）
 *
 * @author hubin
 * @since 3.4.0
 */
public interface TenantLineHandler {

	/**
	 * 获取租户 ID 值表达式，只支持单个 ID 值
	 * <p>
	 *
	 * @return 租户 ID 值表达式
	 */
	Expression getTenantId();

	/**
	 * 获取租户字段名
	 * <p>
	 * 默认字段名叫: tenant_id
	 *
	 * @return 租户字段名
	 */
	default String getTenantIdColumn() {
		return "tenant_id";
	}

	/**
	 * 根据表名判断是否忽略拼接多租户条件
	 * <p>
	 * 默认都要进行解析并拼接多租户条件
	 *
	 * @param tableName 表名
	 * @return 是否忽略, true:表示忽略，false:需要解析并拼接多租户条件
	 */
	default boolean ignoreTable(String tableName) {
		return false;
	}

	/**
	 * 根据mapperId判断是否忽略拼接多租户条件
	 * <p>
	 * 默认都要进行解析并拼接多租户条件
	 *
	 * @param mapperId
	 * @return 是否忽略, true:表示忽略，false:需要解析并拼接多租户条件
	 */
	default boolean ignoreMapId(String mapperId) {
		return false;
	}

	/**
	 * 忽略插入租户字段逻辑
	 *
	 * @param columns        插入字段
	 * @param tenantIdColumn 租户 ID 字段
	 * @return
	 */
	default boolean ignoreInsert(List<Column> columns, String tenantIdColumn) {
		return columns.stream().map(Column::getColumnName).anyMatch(i -> i.equalsIgnoreCase(tenantIdColumn));
	}
}

