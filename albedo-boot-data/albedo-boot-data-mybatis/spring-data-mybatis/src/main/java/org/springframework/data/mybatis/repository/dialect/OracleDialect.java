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
import org.springframework.data.mybatis.repository.dialect.identity.OracleIdentityColumnSupport;
import org.springframework.data.mybatis.repository.dialect.pagination.AbstractLimitHandler;
import org.springframework.data.mybatis.repository.dialect.pagination.LimitHandler;

/**
 * @author Jarvis Song
 */
public class OracleDialect extends Dialect {

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
        public String processSql(boolean hasOffset, String columns, String from, String condition, String sorts) {


            final StringBuilder pagingSelect = new StringBuilder();
            if (hasOffset) {
                pagingSelect.append("select * from ( select row_.*, rownum rownum_ from ( ");
            } else {
                pagingSelect.append("select * from ( ");
            }
            pagingSelect.append("select " + columns + from + condition + sorts);
            if (hasOffset) {
                pagingSelect.append(" ) row_ where rownum <![CDATA[<=]]> #{offsetEnd}) where rownum_ <![CDATA[>]]> #{offset}");
            } else {
                pagingSelect.append(" ) where rownum <![CDATA[<=]]> #{offsetEnd}");
            }

            return pagingSelect.toString();

        }
    };

    @Override
    public boolean supportsSequences() {
        return true;
    }

    @Override
    public String getDatabaseId() {
        return "oracle";
    }

    @Override
    public LimitHandler getLimitHandler() {
        return LIMIT_HANDLER;
    }

    @Override
    public char closeQuote() {
        return '"';
    }

    @Override
    public char openQuote() {
        return '"';
    }

    @Override
    public IdentityColumnSupport getIdentityColumnSupport() {
        return new OracleIdentityColumnSupport();
    }

    @Override
    public String getSequenceNextValString(String sequenceName) {
        return "select " + getSelectSequenceNextValString(sequenceName) + " from dual";
    }

    @Override
    public String getSelectSequenceNextValString(String sequenceName) {
        return sequenceName + ".nextval";
    }

    @Override
    public boolean supportsDeleteAlias() {
        return false;
    }
}
