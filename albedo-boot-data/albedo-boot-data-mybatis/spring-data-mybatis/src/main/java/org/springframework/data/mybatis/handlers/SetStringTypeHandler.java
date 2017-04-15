/*
 *
 *   Copyright 2017 the original author or authors.
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

package org.springframework.data.mybatis.handlers;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Jarvis Song
 */
@MappedJdbcTypes(value = {JdbcType.VARCHAR, JdbcType.CLOB, JdbcType.LONGVARCHAR, JdbcType.NVARCHAR}, includeNullJdbcType = true)
@MappedTypes({Set.class})
public class SetStringTypeHandler extends BaseTypeHandler<Set> {


    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Set parameter, JdbcType jdbcType) throws SQLException {
        StringBuilder builder = new StringBuilder();
        if (!parameter.isEmpty()) {
            for (Object o : parameter) {
                builder.append(o).append(",");
            }
            builder.deleteCharAt(builder.length() - 1);
        }
        ps.setString(i, builder.toString());
    }

    private Set<String> convertStringToSet(String str) {
        if (null == str) {
            return null;
        }
        Set<String> set = new HashSet<String>();
        String[] split = str.split(",");
        if (null != split && split.length > 0) {
            for (String s : split) {
                if (null == s || s.length() == 0) {
                    continue;
                }
                set.add(s);
            }
        }
        return set;
    }

    @Override
    public Set getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return convertStringToSet(rs.getString(columnName));
    }

    @Override
    public Set getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return convertStringToSet(rs.getString(columnIndex));
    }

    @Override
    public Set getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return convertStringToSet(cs.getString(columnIndex));
    }
}
