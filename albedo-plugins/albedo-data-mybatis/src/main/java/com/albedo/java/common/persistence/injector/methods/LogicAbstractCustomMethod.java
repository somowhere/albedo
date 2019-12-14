package com.albedo.java.common.persistence.injector.methods;

import com.baomidou.mybatisplus.core.injector.AbstractMethod;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.sql.SqlScriptUtils;

import java.util.stream.Collectors;

public abstract class LogicAbstractCustomMethod extends AbstractMethod {

	public String getAllSqlWhere(TableInfo table, boolean ignoreLogicDelFiled, boolean withId, String prefix, String columnPrefix) {
		String newPrefix = prefix == null ? "" : prefix;
		String filedSqlScript = table.getFieldList().stream().filter((i) -> {
			if (!ignoreLogicDelFiled) {
				return true;
			} else {
				return !table.isLogicDelete() || !i.isLogicDelete();
			}
		}).map((i) -> i.getSqlWhere(newPrefix)).collect(Collectors.joining("\n"));
		if (withId && !StringUtils.isEmpty(table.getKeyProperty())) {
			String newKeyProperty = newPrefix + table.getKeyProperty();
			String keySqlScript = columnPrefix + table.getKeyColumn() + "=" + SqlScriptUtils.safeParam(newKeyProperty);
			return SqlScriptUtils.convertIf(keySqlScript, String.format("%s != null", newKeyProperty), false) + "\n" + filedSqlScript;
		} else {
			return filedSqlScript;
		}
	}

	protected String getLogicDeleteSql(TableInfo table, boolean startWithAnd, boolean deleteValue, String columnPrefix) {
		return columnPrefix + "." + table.getLogicDeleteSql(startWithAnd, deleteValue);
	}

	protected String sqlWhereEntityWrapper(TableInfo table, String columnPrefix) {
		if (table.isLogicDelete()) {
			String sqlScript = getAllSqlWhere(table, true, true, "ew.entity.", columnPrefix);
			sqlScript = SqlScriptUtils.convertIf(sqlScript, String.format("%s != null", "ew.entity"), true);
			sqlScript = sqlScript + "\n" + getLogicDeleteSql(table, false, true, columnPrefix) + "\n";
			String normalSqlScript = SqlScriptUtils.convertIf(String.format("AND ${%s}", "ew.sqlSegment"), String.format("%s != null and %s != '' and %s", "ew.sqlSegment", "ew.sqlSegment", "ew.nonEmptyOfNormal"), true);
			normalSqlScript = normalSqlScript + "\n";
			normalSqlScript = normalSqlScript + SqlScriptUtils.convertIf(String.format(" ${%s}", "ew.sqlSegment"), String.format("%s != null and %s != '' and %s", "ew.sqlSegment", "ew.sqlSegment", "ew.emptyOfNormal"), true);
			sqlScript = sqlScript + normalSqlScript;
			sqlScript = SqlScriptUtils.convertChoose(String.format("%s != null", "ew"), sqlScript, getLogicDeleteSql(table, false, true, columnPrefix));
			sqlScript = SqlScriptUtils.convertWhere(sqlScript);
			return "\n" + sqlScript;
		} else {
			String sqlScript = getAllSqlWhere(table, false, true, "ew.entity.", columnPrefix);
			sqlScript = SqlScriptUtils.convertIf(sqlScript, String.format("%s != null", "ew.entity"), true);
			sqlScript = sqlScript + "\n";
			sqlScript = sqlScript + SqlScriptUtils.convertIf(String.format(SqlScriptUtils.convertIf(" AND", String.format("%s and %s", "ew.nonEmptyOfEntity", "ew.nonEmptyOfNormal"), false) + " ${%s}", "ew.sqlSegment"), String.format("%s != null and %s != '' and %s", "ew.sqlSegment", "ew.sqlSegment", "ew.nonEmptyOfWhere"), true);
			sqlScript = SqlScriptUtils.convertWhere(sqlScript) + "\n";
			sqlScript = sqlScript + SqlScriptUtils.convertIf(String.format(" ${%s}", "ew.sqlSegment"), String.format("%s != null and %s != '' and %s", "ew.sqlSegment", "ew.sqlSegment", "ew.emptyOfWhere"), true);
			sqlScript = SqlScriptUtils.convertIf(sqlScript, String.format("%s != null", "ew"), true);
			return "\n" + sqlScript;
		}
	}

}
