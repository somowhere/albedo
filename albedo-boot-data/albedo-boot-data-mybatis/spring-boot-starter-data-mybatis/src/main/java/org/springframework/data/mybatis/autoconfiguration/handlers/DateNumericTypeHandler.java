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

package org.springframework.data.mybatis.autoconfiguration.handlers;

import org.apache.ibatis.type.*;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * 日期和数字转换器.转换成unix时间戳.
 *
 * @author jarvis@caomeitu.com
 * @since 15/9/30
 */
@MappedJdbcTypes(value = {JdbcType.NUMERIC, JdbcType.INTEGER, JdbcType.BIGINT}, includeNullJdbcType = true)
@MappedTypes({Date.class})
public class DateNumericTypeHandler extends BaseTypeHandler<Date> {

    @Override
    public void setParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
        if (parameter == null) {
            if (jdbcType == null) {
                throw new TypeException("JDBC requires that the JdbcType must be specified for all nullable parameters.");
            }
            try {
                ps.setNull(i, JdbcType.NUMERIC.TYPE_CODE);
            } catch (SQLException e) {
                throw new TypeException("Error setting null for parameter #" + i + " with JdbcType " + jdbcType + " . " +
                        "Try setting a different JdbcType for this parameter or a different jdbcTypeForNull configuration property. " +
                        "Cause: " + e, e);
            }
        } else {
            setNonNullParameter(ps, i, parameter, jdbcType);
        }
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
        long time = parameter.getTime();
        ps.setLong(i, time);
    }

    private Date convertLongToDate(Long val) throws SQLException {
        if (null == val) {
            return null;
        }
        return new Date(val);
    }

    @Override
    public Date getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return convertLongToDate(rs.getLong(columnName));
    }

    @Override
    public Date getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return convertLongToDate(rs.getLong(columnIndex));
    }

    @Override
    public Date getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return convertLongToDate(cs.getLong(columnIndex));
    }
}
