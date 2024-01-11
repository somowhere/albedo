package com.albedo.java.plugins.database.interceptor;

import com.albedo.java.plugins.database.handler.AlbedoTenantLineHandler;
import com.baomidou.mybatisplus.core.plugins.InterceptorIgnoreHelper;
import com.baomidou.mybatisplus.core.toolkit.*;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.baomidou.mybatisplus.extension.toolkit.PropertyMapper;
import lombok.*;
import net.sf.jsqlparser.expression.*;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.conditional.OrExpression;
import net.sf.jsqlparser.expression.operators.relational.*;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.delete.Delete;
import net.sf.jsqlparser.statement.insert.Insert;
import net.sf.jsqlparser.statement.select.*;
import net.sf.jsqlparser.statement.update.Update;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.sql.Connection;
import java.util.*;

/**
 * @author hubin
 * @since 3.4.0
 */
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
public class AlbedoTenantLineInnerInterceptor extends TenantLineInnerInterceptor {

	private AlbedoTenantLineHandler albedoTenantLineHandler;

	@Override
	public void beforeQuery(Executor executor, MappedStatement ms, Object parameter, RowBounds rowBounds, ResultHandler resultHandler, BoundSql boundSql) {
		if (InterceptorIgnoreHelper.willIgnoreTenantLine(ms.getId()) || albedoTenantLineHandler.ignoreMapId(ms.getId())) {
			return;
		}

		PluginUtils.MPBoundSql mpBs = PluginUtils.mpBoundSql(boundSql);
		mpBs.sql(parserSingle(mpBs.sql(), null));
	}

	@Override
	public void beforePrepare(StatementHandler sh, Connection connection, Integer transactionTimeout) {
		PluginUtils.MPStatementHandler mpSh = PluginUtils.mpStatementHandler(sh);
		MappedStatement ms = mpSh.mappedStatement();
		if (!albedoTenantLineHandler.ignoreMapId(ms.getId())) {
			SqlCommandType sct = ms.getSqlCommandType();
			if (sct == SqlCommandType.INSERT || sct == SqlCommandType.UPDATE || sct == SqlCommandType.DELETE) {
				if (InterceptorIgnoreHelper.willIgnoreTenantLine(ms.getId())) {
					return;
				}
				PluginUtils.MPBoundSql mpBs = mpSh.mPBoundSql();
				mpBs.sql(parserMulti(mpBs.sql(), null));
			}
		}

	}

	@Override
	public void setProperties(Properties properties) {
		super.setProperties(properties);
		PropertyMapper.newInstance(properties).whenNotBlank("albedoTenantLineHandler",
			ClassUtils::newInstance, this::setAlbedoTenantLineHandler);
	}

	public void setAlbedoTenantLineHandler(AlbedoTenantLineHandler albedoTenantLineHandler) {
		this.albedoTenantLineHandler = albedoTenantLineHandler;
		setTenantLineHandler(albedoTenantLineHandler);
	}
}



