package com.albedo.java.common.persistence.injector.methods;

import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.injector.SqlInjectorUtil;
import com.baomidou.mybatisplus.core.metadata.TableInfo;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlSource;

public class LogicFindRelationPage extends LogicAbstractCustomMethod {
	@Override
	public MappedStatement injectMappedStatement(Class<?> mapperClass, Class<?> modelClass, TableInfo tableInfo) {
		String tableNameAlias = StringUtil.lowerCase(modelClass.getSimpleName());
		String sql = SqlInjectorUtil.parseSql(builderAssistant, SqlCustomMethod.FIND_RELATION_PAGE, modelClass, tableInfo,
			sqlWhereEntityWrapper(tableInfo, tableNameAlias));
		SqlSource sqlSource = this.languageDriver.createSqlSource(this.configuration, sql, modelClass);
		return this.addSelectMappedStatementForTable(mapperClass, SqlCustomMethod.FIND_RELATION_PAGE.getMethod(), sqlSource, tableInfo);
	}
}
