/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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

package com.albedo.java.plugins.mybatis.datascope;

import cn.hutool.core.collection.CollectionUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.baomidou.mybatisplus.core.toolkit.PluginUtils;
import com.baomidou.mybatisplus.extension.plugins.inner.InnerInterceptor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Alias;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import net.sf.jsqlparser.expression.operators.conditional.AndExpression;
import net.sf.jsqlparser.expression.operators.relational.EqualsTo;
import net.sf.jsqlparser.expression.operators.relational.ExpressionList;
import net.sf.jsqlparser.expression.operators.relational.InExpression;
import net.sf.jsqlparser.expression.operators.relational.ItemsList;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Column;
import net.sf.jsqlparser.statement.select.PlainSelect;
import net.sf.jsqlparser.statement.select.Select;
import net.sf.jsqlparser.statement.select.SelectBody;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.mapping.StatementType;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author somewhere
 * @date 2019/2/1
 * <p>
 * mybatis 数据权限拦截器
 */
@Slf4j
public class DataScopeInterceptor implements InnerInterceptor {

	@SneakyThrows
	@Override
	public void beforeQuery(Executor executor, MappedStatement mappedStatement, Object parameter, RowBounds rowBounds,
							ResultHandler resultHandler, BoundSql boundSql) {
		if (SqlCommandType.SELECT == mappedStatement.getSqlCommandType()
			&& StatementType.CALLABLE != mappedStatement.getStatementType()) {
			// 查找参数中包含DataScope类型的参数
			DataScope dataScope = findDataScopeObject(parameter);

			if (dataScope != null && !dataScope.isAll()) {
				String scopeName = dataScope.getScopeName(), creatorName = dataScope.getCreatorName();
				Long userId = dataScope.getUserId();
				Set<Long> deptIds = dataScope.getDeptIds();
				String originalSql = boundSql.getSql();
				Select selectStatement = (Select) CCJSqlParserUtil.parse(originalSql);
				SelectBody selectBody = selectStatement.getSelectBody();
				if (selectBody instanceof PlainSelect) {
					PlainSelect plainSelect = (PlainSelect) selectBody;
					Expression expression = null;
					Alias alias = plainSelect.getFromItem().getAlias();
					String aliaName = "";
					if (alias != null && StringUtil.isNotEmpty(alias.getName())) {
						aliaName = alias.getName() + StringUtil.DOT;
					}
					if (StringUtil.isNotBlank(scopeName) && CollectionUtil.isNotEmpty(deptIds)) {
						ItemsList itemsList = new ExpressionList(
							deptIds.stream().map(deptId -> new LongValue(deptId)).collect(Collectors.toList()));
						expression = new InExpression(new Column(aliaName + scopeName), itemsList);
					} else if (StringUtil.isNotEmpty(creatorName) && dataScope.isSelf()) {
						EqualsTo equalsTo = new EqualsTo();
						equalsTo.setLeftExpression(new Column(aliaName + creatorName));
						equalsTo.setRightExpression(new LongValue(userId));
						expression = equalsTo;
					}
					if (expression != null) {
						AndExpression andExpression = new AndExpression(plainSelect.getWhere(), expression);
						plainSelect.setWhere(andExpression);
						PluginUtils.MPBoundSql mpBoundSql = PluginUtils.mpBoundSql(boundSql);
						mpBoundSql.sql(plainSelect.toString());
					}
				} else {
					// todo: don't known how to resole
					log.warn("can not parse " + selectBody);
				}
			}
		}
	}

	/**
	 * /** 查找参数是否包括DataScope对象
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
