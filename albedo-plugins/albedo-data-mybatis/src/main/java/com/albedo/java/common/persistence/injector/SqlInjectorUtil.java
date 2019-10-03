package com.albedo.java.common.persistence.injector;

import com.albedo.java.common.core.util.BeanVoUtil;
import com.albedo.java.common.core.util.ClassUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.annotation.ManyToOne;
import com.albedo.java.common.persistence.domain.TreeEntity;
import com.albedo.java.common.persistence.injector.methods.SqlCustomMethod;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.core.metadata.TableFieldInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import com.baomidou.mybatisplus.core.toolkit.GlobalConfigUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.builder.MapperBuilderAssistant;
import org.apache.ibatis.session.Configuration;

import java.beans.PropertyDescriptor;
import java.util.Iterator;
import java.util.List;

@Slf4j
public class SqlInjectorUtil {
	public static String sqlWordConvert(String column) {
		return String.format("`%s`", column);
	}

	public static String sqlSelectColumns(TableInfo table, boolean entityWrapper, String columnPrefix, String selectProfix) {
		StringBuilder columns = new StringBuilder();
		if (null != table.getResultMap()) {
			if (entityWrapper) {
				columns.append("<choose><when test=\"ew != null and ew.sqlSelect != null\">${ew.sqlSelect}</when><otherwise>");
			}

			columns.append("*");
			if (entityWrapper) {
				columns.append("</otherwise></choose>");
			}
		} else {
			if (entityWrapper) {
				columns.append("<choose><when test=\"ew != null and ew.sqlSelect != null\">${ew.sqlSelect}</when><otherwise>");
			}

			List<TableFieldInfo> fieldList = table.getFieldList();
			int size = 0;
			if (null != fieldList) {
				size = fieldList.size();
			}

			if (StringUtils.isNotEmpty(table.getKeyProperty())) {
				if (StringUtil.isNotEmpty(columnPrefix)) {
					columns.append('`').append(columnPrefix).append("`.");
				}
				String keyProperty = table.getKeyProperty();
				if (StringUtil.isNotEmpty(selectProfix)) {
					keyProperty = selectProfix + "." + keyProperty;
				}
				columns.append(table.getKeyColumn()).append(" AS ").append(sqlWordConvert(keyProperty));

				if (size >= 1) {
					columns.append(",");
				}
			}

			if (size >= 1) {
				int i = 0;

				for (Iterator iterator = fieldList.iterator(); iterator.hasNext(); ++i) {
					TableFieldInfo fieldInfo = (TableFieldInfo) iterator.next();
					String property = fieldInfo.getProperty();
					if (StringUtil.isNotEmpty(selectProfix)) {
						property = selectProfix + "." + property;
					}
					String wordConvert = sqlWordConvert(property);
					if (StringUtil.isNotEmpty(columnPrefix)) {
						columns.append('`').append(columnPrefix).append("`.");
					}
					columns.append(fieldInfo.getColumn());
					columns.append(" AS ").append(wordConvert);

					if (i + 1 < size) {
						columns.append(",");
					}
				}
			}

			if (entityWrapper) {
				columns.append("</otherwise></choose>");
			}
		}

		return columns.toString();
	}

	public static String parseSql(MapperBuilderAssistant builderAssistant,
								  SqlCustomMethod sqlMethod, Class<?> modelClass, TableInfo tableInfo, String sqlWhereEntityWrapper) {
		String tableNameAlias = StringUtil.lowerCase(modelClass.getSimpleName()), tempNameAlias;
		TableInfo tableAlias;
		PropertyDescriptor[] ps = BeanVoUtil.getPropertyDescriptors(modelClass);
		StringBuffer sbSelectCoumns = new StringBuffer(SqlInjectorUtil.sqlSelectColumns(tableInfo, false, tableNameAlias, null)),
			sbLeftJoin = new StringBuffer(tableInfo.getTableName()).append(" `").append(tableNameAlias).append("`");
		for (PropertyDescriptor p : ps) {

			ManyToOne annotation = ClassUtil.findAnnotation(modelClass, p.getName(), ManyToOne.class);
			if (annotation != null) {
				tableAlias = TableInfoHelper.initTableInfo(builderAssistant, p.getPropertyType());
				sbSelectCoumns.append(",")
					.append(SqlInjectorUtil.sqlSelectColumns(tableAlias, false, p.getName(), p.getName()));
				sbLeftJoin.append(" LEFT JOIN ").append(tableAlias.getTableName()).append(" `").append(p.getName())
					.append("` ON `").append(tableNameAlias).append("`.").append(annotation.name())
					.append(" = `").append(p.getName()).append("`.").append(TreeEntity.F_SQL_ID);
			}
		}

		String sql = String.format(sqlMethod.getSql(),
			sbSelectCoumns.toString(),
			sbLeftJoin.toString(),
			sqlWhereEntityWrapper);
		return sql;
	}


}
