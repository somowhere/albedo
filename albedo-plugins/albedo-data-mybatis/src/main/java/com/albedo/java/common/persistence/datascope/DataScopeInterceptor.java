/*
 *  Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.persistence.datascope;

import cn.hutool.core.collection.CollectionUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.toolkit.PluginUtils;
import com.baomidou.mybatisplus.extension.handlers.AbstractSqlParserHandler;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Alias;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.StringValue;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ExpressionList;
import net.sf.jsqlparser.expression.operators.relational.InExpression;
import net.sf.jsqlparser.expression.operators.relational.ItemsList;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.mapping.StatementType;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import java.sql.Connection;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.stream.Collectors;


/**
 * @author somewhere
 * @date 2019/2/1
 * <p>
 * mybatis 数据权限拦截器
 */
@Slf4j
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class, Integer.class})})
public class DataScopeInterceptor extends AbstractSqlParserHandler implements Interceptor {

	@Override
	@SneakyThrows
	public Object intercept(Invocation invocation) {
		StatementHandler statementHandler = PluginUtils.realTarget(invocation.getTarget());
		MetaObject metaObject = SystemMetaObject.forObject(statementHandler);
		this.sqlParser(metaObject);
		// 先判断是不是SELECT操作  (2019-04-10 00:37:31 跳过存储过程)
		MappedStatement mappedStatement = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
		if (SqlCommandType.SELECT != mappedStatement.getSqlCommandType()

			|| StatementType.CALLABLE == mappedStatement.getStatementType()) {
			return invocation.proceed();
		}

		BoundSql boundSql = (BoundSql) metaObject.getValue("delegate.boundSql");
		Object parameterObject = boundSql.getParameterObject();

		//查找参数中包含DataScope类型的参数
		DataScope dataScope = findDataScopeObject(parameterObject);

		if (dataScope == null || dataScope.isAll()) {
			return invocation.proceed();
		} else {
			String scopeName = dataScope.getScopeName(),
				creatorName = dataScope.getCreatorName(),
				userId = dataScope.getUserId();
			Set<String> deptIds = dataScope.getDeptIds();
			String originalSql = boundSql.getSql();
			Select selectStatement = (Select) CCJSqlParserUtil.parse(originalSql);
			if (selectStatement.getSelectBody() instanceof PlainSelect) {
				PlainSelect plainSelect = (PlainSelect) selectStatement.getSelectBody();
				Expression expression = null;
				Alias alias = plainSelect.getFromItem().getAlias();
				String aliaName = "";
				if (alias != null && StringUtil.isNotEmpty(alias.getName())) {
					aliaName = alias.getName() + ".";
				}
				if (StringUtil.isNotBlank(scopeName) && CollectionUtil.isNotEmpty(deptIds)) {
					ItemsList itemsList = new ExpressionList(deptIds.stream().map(deptId -> new StringValue(deptId)).collect(Collectors.toList()));
					expression = new InExpression(new Column(aliaName + scopeName), itemsList);
				} else if (StringUtil.isNotEmpty(creatorName)) {
					EqualsTo equalsTo = new EqualsTo();
					equalsTo.setLeftExpression(new Column(aliaName + creatorName));
					equalsTo.setRightExpression(new StringValue(userId));
					expression = equalsTo;
				}
				AndExpression andExpression = new AndExpression(plainSelect.getWhere(), expression);
				plainSelect.setWhere(andExpression);
				metaObject.setValue("delegate.boundSql.sql", plainSelect.toString());
			}
			return invocation.proceed();
		}
	}

	/**
	 * 生成拦截对象的代理
	 *
	 * @param target 目标对象
	 * @return 代理对象
	 */
	@Override
	public Object plugin(Object target) {
		if (target instanceof StatementHandler) {
			return Plugin.wrap(target, this);
		}
		return target;
	}

	/**
	 * mybatis配置的属性
	 *
	 * @param properties mybatis配置的属性
	 */
	@Override
	public void setProperties(Properties properties) {

	}

	/**
	 * 查找参数是否包括DataScope对象
	 *
	 * @param parameterObj 参数列表
	 * @return DataScope
	 */
	private DataScope findDataScopeObject(Object parameterObj) {
		if (parameterObj instanceof DataScope) {
			return (DataScope) parameterObj;
		} else if (parameterObj instanceof Map) {
			for (Object val : ((Map<?, ?>) parameterObj).values()) {
				if (val instanceof DataScope) {
					return (DataScope) val;
				}
			}
		}
		return null;
	}

}
