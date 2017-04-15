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
import org.springframework.data.mybatis.repository.dialect.identity.MySQLIdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.pagination.AbstractLimitHandler;
import org.springframework.data.mybatis.repository.dialect.pagination.LimitHandler;

import java.sql.Types;

/**
 * @author Jarvis Song
 */
public class MySQLDialect extends Dialect {

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

    public MySQLDialect() {
        super();
        registerColumnType(Types.BIT, "bit");
        registerColumnType(Types.BIGINT, "bigint");
        registerColumnType(Types.SMALLINT, "smallint");
        registerColumnType(Types.TINYINT, "tinyint");
        registerColumnType(Types.INTEGER, "integer");
        registerColumnType(Types.CHAR, "char(1)");
        registerColumnType(Types.FLOAT, "float");
        registerColumnType(Types.DOUBLE, "double precision");
        registerColumnType(Types.BOOLEAN, "bit"); // HHH-6935
        registerColumnType(Types.DATE, "date");
        registerColumnType(Types.TIME, "time");
        registerColumnType(Types.TIMESTAMP, "datetime");
        registerColumnType(Types.VARBINARY, "longblob");
        registerColumnType(Types.VARBINARY, 16777215, "mediumblob");
        registerColumnType(Types.VARBINARY, 65535, "blob");
        registerColumnType(Types.VARBINARY, 255, "tinyblob");
        registerColumnType(Types.BINARY, "binary($l)");
        registerColumnType(Types.LONGVARBINARY, "longblob");
        registerColumnType(Types.LONGVARBINARY, 16777215, "mediumblob");
        registerColumnType(Types.NUMERIC, "decimal($p,$s)");
        registerColumnType(Types.BLOB, "longblob");
//		registerColumnType( Types.BLOB, 16777215, "mediumblob" );
//		registerColumnType( Types.BLOB, 65535, "blob" );
        registerColumnType(Types.CLOB, "longtext");
        registerColumnType(Types.NCLOB, "longtext");
//		registerColumnType( Types.CLOB, 16777215, "mediumtext" );
//		registerColumnType( Types.CLOB, 65535, "text" );
    }

    @Override
    public String getDatabaseId() {
        return "mysql";
    }

    @Override
    public LimitHandler getLimitHandler() {
        return LIMIT_HANDLER;
    }

    @Override
    public char closeQuote() {
        return '`';
    }

    @Override
    public char openQuote() {
        return '`';
    }

    @Override
    public IdentityColumnSupport getIdentityColumnSupport() {
        return new MySQLIdentityColumnSupport();
    }

    @Override
    public boolean supportsDeleteAlias() {
        return true;
    }
}
