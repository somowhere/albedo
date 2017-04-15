/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository.dialect;

import org.springframework.data.mybatis.repository.dialect.identity.IdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.identity.SqlServerIdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.pagination.AbstractLimitHandler;
import org.springframework.data.mybatis.repository.dialect.pagination.LimitHandler;

/**
 * @author Jarvis Song
 */
public class SQLServerDialect extends Dialect {

    private static final AbstractLimitHandler LIMIT_HANDLER = new AbstractLimitHandler() {
        @Override
        public boolean supportsLimit() {
            return true;
        }

        /**
         *  * <pre>
         * WITH query AS (
         *   SELECT inner_query.*
         *        , ROW_NUMBER() OVER (ORDER BY CURRENT_TIMESTAMP) as __hibernate_row_nr__
         *     FROM ( original_query_with_top_if_order_by_present_and_all_aliased_columns ) inner_query
         * )
         * SELECT alias_list FROM query WHERE __hibernate_row_nr__ >= offset AND __hibernate_row_nr__ < offset + last
         * </pre>
         * @return
         */
        @Override
        public boolean bindLimitParametersInReverseOrder() {
            return true;
        }

        @Override
        public String processSql(boolean hasFirstRow, String columns, String from, String condition, String sorts) {
            StringBuilder sql = new StringBuilder();

            String[] cs = columns.split(",");
            StringBuilder alias = new StringBuilder();
            for (int i = 0; i < cs.length; i++) {
                String c = cs[i];
                String[] ass = c.split(" as ");
                if (ass.length == 1) {
                    alias.append(c).append(",");
                } else {
                    alias.append(ass[1]).append(",");
                }
            }

            if (alias.length() > 0) {
                alias.deleteCharAt(alias.length() - 1);
            }


            sql.append("WITH query AS (SELECT inner_query.*, ROW_NUMBER() OVER (ORDER BY CURRENT_TIMESTAMP) as __mybatis_row_nr__ FROM ( select ");
//            if (!hasFirstRow) {
//                sql.append("top(#{pageSize}) ");
//            }
            sql.append(columns + from + condition + sorts);
            sql.append(" ) inner_query ) ");
            sql.append("select ").append(alias.toString());
            sql.append(" from query where __mybatis_row_nr__ <![CDATA[>]]> #{offset} and __mybatis_row_nr__ <![CDATA[<=]]> #{offsetEnd}");
            return sql.toString();
        }
    };

    public SQLServerDialect() {
        super();

    }

    @Override
    public String getDatabaseId() {
        return "sqlserver";
    }

    @Override
    public LimitHandler getLimitHandler() {
        return LIMIT_HANDLER;
    }

    @Override
    public char closeQuote() {
        return ']';
    }

    @Override
    public char openQuote() {
        return '[';
    }

    @Override
    public IdentityColumnSupport getIdentityColumnSupport() {
        return new SqlServerIdentityColumnSupport();
    }

    @Override
    public boolean supportsDeleteAlias() {
        return true;
    }
}
