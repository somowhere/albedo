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

import org.springframework.data.mapping.model.MappingException;
import org.springframework.data.mybatis.repository.dialect.identity.IdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.identity.IdentityColumnSupportImpl;
import org.springframework.data.mybatis.repository.dialect.pagination.LimitHandler;

import java.sql.Types;
import java.util.HashSet;
import java.util.Set;

/**
 * Database localism.
 *
 * @author Jarvis Song
 */
public class Dialect {

    public static final String QUOTE = "`\"[";

    public static final String CLOSED_QUOTE = "`\"]";

    private final TypeMappings typeMappings = new TypeMappings();
    private final Set<String>  sqlKeywords  = new HashSet<String>();

    protected Dialect() {
        registerColumnType(Types.BIT, "bit");
        registerColumnType(Types.BOOLEAN, "boolean");
        registerColumnType(Types.TINYINT, "tinyint");
        registerColumnType(Types.SMALLINT, "smallint");
        registerColumnType(Types.INTEGER, "integer");
        registerColumnType(Types.BIGINT, "bigint");
        registerColumnType(Types.FLOAT, "float($p)");
        registerColumnType(Types.DOUBLE, "double precision");
        registerColumnType(Types.NUMERIC, "numeric($p,$s)");
        registerColumnType(Types.REAL, "real");

        registerColumnType(Types.DATE, "date");
        registerColumnType(Types.TIME, "time");
        registerColumnType(Types.TIMESTAMP, "timestamp");

        registerColumnType(Types.VARBINARY, "bit varying($l)");
        registerColumnType(Types.LONGVARBINARY, "bit varying($l)");
        registerColumnType(Types.BLOB, "blob");

        registerColumnType(Types.CHAR, "char($l)");
        registerColumnType(Types.VARCHAR, "varchar($l)");
        registerColumnType(Types.LONGVARCHAR, "varchar($l)");
        registerColumnType(Types.CLOB, "clob");

        registerColumnType(Types.NCHAR, "nchar($l)");
        registerColumnType(Types.NVARCHAR, "nvarchar($l)");
        registerColumnType(Types.LONGNVARCHAR, "nvarchar($l)");
        registerColumnType(Types.NCLOB, "nclob");
    }

    protected void registerColumnType(int code, String name) {
        typeMappings.put(code, name);
    }

    protected void registerColumnType(int code, long capacity, String name) {
        typeMappings.put(code, capacity, name);
    }

    public String getDatabaseId() {
        return null;
    }

    public LimitHandler getLimitHandler() {
        return null;
    }

    public char openQuote() {
        return '"';
    }

    public char closeQuote() {
        return '"';
    }

    public final String quote(String name) {
        if (name == null) {
            return null;
        }

        if (name.charAt(0) == '`') {
            return openQuote() + name.substring(1, name.length() - 1) + closeQuote();
        } else {
            return name;
        }
    }

    public String wrapTableName(String tableName) {
        return tableName;
    }

    public String wrapColumnName(String columnName) {
        return columnName;
    }

    public boolean supportsSequences() {
        return false;
    }

    public String getSequenceNextValString(String sequenceName) throws MappingException {
        throw new MappingException(getClass().getName() + " does not support sequences");
    }

    public String getSelectSequenceNextValString(String sequenceName) throws MappingException {
        throw new MappingException(getClass().getName() + " does not support sequences");
    }

    public IdentityColumnSupport getIdentityColumnSupport() {
        return new IdentityColumnSupportImpl();
    }

    public boolean supportsDeleteAlias() {
        return false;
    }

    @Override
    public String toString() {
        return getClass().toString();
    }
}
