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
import org.springframework.data.mybatis.repository.dialect.identity.PostgreSQLIdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.pagination.AbstractLimitHandler;
import org.springframework.data.mybatis.repository.dialect.pagination.LimitHandler;

/**
 * @author Jarvis Song
 */
public class PostgreSQLDialect extends Dialect {


    private static final AbstractLimitHandler LIMIT_HANDLER = new AbstractLimitHandler() {
        @Override
        public boolean supportsLimit() {
            return true;
        }

        @Override
        public boolean bindLimitParametersInReverseOrder() {
            return true;
        }


        @Override
        public String processSql(boolean hasFirstRow, String columns, String from, String condition, String sorts) {
            String sql = "select " + columns + from + condition + sorts;
            return sql + (hasFirstRow ? " limit #{pageSize} offset #{offset}" : " limit #{pageSize}");
        }
    };

    public PostgreSQLDialect() {
        super();
    }

    @Override
    public String wrapTableName(String tableName) {
        return "\"" + tableName + "\"";
    }

    @Override
    public String wrapColumnName(String columnName) {
        return "\"" + columnName + "\"";
    }

    @Override
    public String getDatabaseId() {
        return "postgresql";
    }

    @Override
    public LimitHandler getLimitHandler() {
        return LIMIT_HANDLER;
    }


    @Override
    public IdentityColumnSupport getIdentityColumnSupport() {
        return new PostgreSQLIdentityColumnSupport();
    }

    @Override
    public boolean supportsDeleteAlias() {
        return false;
    }
}
