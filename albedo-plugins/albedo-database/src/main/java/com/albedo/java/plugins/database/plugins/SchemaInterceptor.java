package com.albedo.java.plugins.database.plugins;

import cn.hutool.core.util.StrUtil;
import com.albedo.java.common.core.context.ContextUtil;
import com.albedo.java.plugins.database.parsers.ReplaceSql;
import com.baomidou.mybatisplus.core.plugins.InterceptorIgnoreHelper;
import com.baomidou.mybatisplus.core.toolkit.PluginUtils;
import com.baomidou.mybatisplus.extension.plugins.inner.InnerInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * SCHEMA模式插件
 *
 * @author somewhere
 * @date 2020/8/26 上午10:00
 */
@Slf4j
public class SchemaInterceptor implements InnerInterceptor {

	private final String tenantDatabasePrefix;

	public SchemaInterceptor(String tenantDatabasePrefix) {
		this.tenantDatabasePrefix = tenantDatabasePrefix;
	}

	protected String changeTable(String sql) {
		// 想要 执行sql时， 不切换到 albedo_base_{TENANT} 库, 请直接返回null
		String tenantCode = ContextUtil.getTenant();
		if (StrUtil.isEmpty(tenantCode)) {
			return sql;
		}

		String schemaName = StrUtil.format("{}_{}", tenantDatabasePrefix, tenantCode);
		// 想要 执行sql时， 切换到 切换到自己指定的库， 直接修改 setSchemaName
		return ReplaceSql.replaceSql(schemaName, sql);
	}

	@Override
	public void beforeQuery(Executor executor, MappedStatement ms, Object parameter, RowBounds rowBounds, ResultHandler resultHandler, BoundSql boundSql) throws SQLException {
		// 统一交给 beforePrepare 处理,防止某些sql解析不到，又被beforePrepare重复处理
	}


	@Override
	public void beforePrepare(StatementHandler sh, Connection connection, Integer transactionTimeout) {
		PluginUtils.MPStatementHandler mpSh = PluginUtils.mpStatementHandler(sh);
		MappedStatement ms = mpSh.mappedStatement();
		SqlCommandType sct = ms.getSqlCommandType();
		if (sct == SqlCommandType.INSERT || sct == SqlCommandType.UPDATE || sct == SqlCommandType.DELETE || sct == SqlCommandType.SELECT) {
			if (InterceptorIgnoreHelper.willIgnoreDynamicTableName(ms.getId())) {
				return;
			}
			PluginUtils.MPBoundSql mpBs = mpSh.mPBoundSql();
			log.debug("未替换前的sql: {}", mpBs.sql());
			mpBs.sql(this.changeTable(mpBs.sql()));
		}
	}
}
