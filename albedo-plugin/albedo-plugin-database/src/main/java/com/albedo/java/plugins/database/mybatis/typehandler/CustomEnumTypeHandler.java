package com.albedo.java.plugins.database.mybatis.typehandler;


import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.enumeration.BaseEnum;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

/**
 * @author somewhere
 */
public class CustomEnumTypeHandler<E extends Enum<E>> extends BaseTypeHandler<E> {
	private final Class<E> type;

	public CustomEnumTypeHandler(Class<E> type) {
		if (type == null) {
			throw new IllegalArgumentException("Type argument cannot be null");
		} else {
			this.type = type;
		}
	}

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, E parameter, JdbcType jdbcType) throws SQLException {
		if (jdbcType == null) {
			ps.setString(i, getValue(parameter));
		} else {
			ps.setObject(i, getValue(parameter), jdbcType.TYPE_CODE);
		}

	}

	public String getValue(E parameter) {
		return parameter instanceof BaseEnum ? ((BaseEnum) parameter).getValue() : parameter.name();
	}

	public E getEnum(String value) {
		if (value == null) {
			return null;
		}
		return ArrayUtil.contains(this.type.getInterfaces(), BaseEnum.class) ? Arrays.stream(this.type.getEnumConstants()).filter(baseEnum -> ((BaseEnum) baseEnum).eq(value)).findFirst().orElse(null)
			: Enum.valueOf(this.type, value);
	}


	@Override
	public E getNullableResult(ResultSet rs, String columnName) throws SQLException {
		return getEnum(rs.getString(columnName));
	}

	@Override
	public E getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		return getEnum(rs.getString(columnIndex));
	}

	@Override
	public E getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		return getEnum(cs.getString(columnIndex));
	}
}

