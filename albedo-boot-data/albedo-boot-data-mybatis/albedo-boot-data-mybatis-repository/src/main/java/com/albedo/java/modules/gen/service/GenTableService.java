package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTableService extends DataService<GenTableRepository, GenTable, String> {

	@Autowired
	private GenTableColumnService genTableColumnService;

	public GenTable save(GenTable genTable) {
		genTable.setColumnList(genTable.getColumnFormList());
		genTable = repository.save(genTable);
		log.debug("Save Information for GenTable: {}", genTable);

		return genTable;
	}


	@Transactional(readOnly = true)
	public List<GenTable> findAll() {
		return findAll(DynamicSpecifications
				.bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
	}

	
	@Transactional(readOnly = true)
	public boolean checkTableName(String tableName) {
		if (StringUtil.isBlank(tableName)) {
			return true;
		}
		List<GenTable> list = findAll(
				DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL),
						QueryCondition.eq(GenTable.F_NAME, tableName)));
		return list.size() == 0;
	}

	public GenTable getTableFormDb(GenTable genTable) {
		// 如果有表名，则获取物理表
		if (StringUtil.isNotBlank(genTable.getName())) {

			List<GenTable> list = findTableListFormDb(genTable);
			if (list.size() > 0) {

				// 如果是新增，初始化表属性
				if (StringUtil.isBlank(genTable.getId())) {
					genTable = list.get(0);
					// 设置字段说明
					if (StringUtil.isBlank(genTable.getComments())) {
						genTable.setComments(genTable.getName());
					}
					genTable.setClassName(StringUtil.toCapitalizeCamelCase(genTable.getName()));
				}

				// 添加新列
				List<GenTableColumn> columnList = findTableColumnList(genTable);
				for (GenTableColumn column : columnList) {
					boolean b = false;
					for (GenTableColumn e : genTable.getColumnList()) {
						if (e.getName().equals(column.getName())) {
							b = true;
						}
					}
					if (!b) {
						genTable.getColumnList().add(column);
					}
				}
				// 删除已删除的列
				for (GenTableColumn e : genTable.getColumnList()) {
					boolean b = false;
					for (GenTableColumn column : columnList) {
						if (column.getName().equals(e.getName())) {
							b = true;
						}
					}
					if (!b) {
						e.setStatus(GenTableColumn.FLAG_DELETE);
					}
				}

				// 获取主键
				genTable.setPkList(findTablePK(genTable));

				// 初始化列属性字段
				GenUtil.initColumnField(genTable);

			}
		}
		return genTable;
	}
	@Transactional(readOnly = true)
	public List<String> findTablePK(GenTable genTable) {
		List<String> pkList = null;
//		String sql = "";
//		if (SystemConfig.isMySql()) {
//			sql = "SELECT lower(au.COLUMN_NAME) AS columnName FROM information_schema.`COLUMNS` au WHERE au.TABLE_SCHEMA = (select database()) AND au.COLUMN_KEY='PRI' AND au.TABLE_NAME = :p1";
//		} else if (SystemConfig.isOracle()) {
//			sql = "SELECT lower(cu.COLUMN_NAME) AS columnName FROM user_cons_columns cu, user_constraints au WHERE cu.constraint_name = au.constraint_name AND au.constraint_type = 'P' AND au.table_name = :p1";
//		}

		pkList =repository.findTablePK(genTable);
		return pkList;
	}
	@Transactional(readOnly = true)
	public List<GenTableColumn> findTableColumnList(GenTable genTable) {
		List<String[]> GenString = null;
		List<GenTableColumn> list = null;
//		String sql = "";
//		if (SystemConfig.isMySql()) {
//			sql = "SELECT t.COLUMN_NAME AS name, (CASE WHEN t.IS_NULLABLE = 'YES' THEN '1' ELSE '0' END) AS isNull, (t.ORDINAL_POSITION * 10) AS sort,t.COLUMN_COMMENT AS comments,t.COLUMN_TYPE AS jdbcType FROM information_schema.`COLUMNS` t WHERE t.TABLE_SCHEMA = (select database()) AND t.TABLE_NAME = :p1 ORDER BY t.ORDINAL_POSITION";
//		} else if (SystemConfig.isOracle()) {
//			sql = "SELECT t.COLUMN_NAME AS name, (CASE WHEN t.NULLABLE = 'Y' THEN '1' ELSE '0' END) AS isNull, (t.COLUMN_ID * 10) AS sort, c.COMMENTS AS comments, decode(t.DATA_TYPE, 'DATE', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')', 'VARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','VARCHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','NVARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH/2 || ')','CHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','NUMBER',t.DATA_TYPE || (nvl2(t.DATA_PRECISION,nvl2(decode(t.DATA_SCALE,0,null,t.DATA_SCALE),'(' || t.DATA_PRECISION || ',' || t.DATA_SCALE || ')', '(' || t.DATA_PRECISION || ')'),'(18)')),t.DATA_TYPE) AS jdbcType FROM user_tab_columns t, user_col_comments c WHERE t.TABLE_NAME = c.table_name AND t.COLUMN_NAME = c.column_name AND t.TABLE_NAME = :p1 ORDER BY t.COLUMN_ID";
//		}
		list = repository.findTableColumnList(genTable);
//		if (PublicUtil.isNotEmpty(GenString)) {
//			list = Lists.newArrayList();
//			for (Object[] str : GenString) {
//				list.add(new GenTableColumn(String.valueOf(str[0]), Integer.parseInt(String.valueOf(str[1])),
//						Integer.parseInt(String.valueOf(str[2])), String.valueOf(str[3]), String.valueOf(str[4])));
//			}
//		}else{
		if(PublicUtil.isEmpty(list)){
			throw new RuntimeMsgException(PublicUtil.toAppendStr("无法获取[", genTable.getName(), "]表的列信息"));
		}
		return list;
	}
	@Transactional(readOnly = true)
	public List<GenTable> findTableListFormDb(GenTable genTable) {
//		List<String[]> GenString = null;
		List<GenTable> list = repository.findTableList(genTable);
//		String sql = "";
//		if (SystemConfig.isMySql()) {
//			sql = "SELECT t.table_name AS name,t.TABLE_COMMENT AS comments FROM information_schema.`TABLES` t WHERE t.TABLE_SCHEMA = (select database()) AND t.TABLE_NAME=:p1 ORDER BY t.TABLE_NAME";
//		} else if (SystemConfig.isOracle()) {
//			sql = "SELECT t.TABLE_NAME AS name, c.COMMENTS AS comments FROM user_tables t, user_tab_comments c WHERE t.table_name = c.table_name AND t.TABLE_NAME=:p1 ORDER BY t.TABLE_NAME";
//		}
//		if (PublicUtil.isNotEmpty(genTable.getName())) {
//			GenString = baseRepository.createSqlQuery(sql, StringUtil.upperCase(genTable.getName())).list();
//		}
//		if(PublicUtil.isEmpty(GenString)){
//			GenString = baseRepository.createSqlQuery(sql.replace(" AND t.TABLE_NAME=:p1", "")).list();
//		}
//
//		if (PublicUtil.isNotEmpty(GenString)) {
//			for (Object[] str : GenString) {
//				list.add(new GenTable((String) str[0], (String) str[1]));
//			}
//		}
		return list;
	}
	@Transactional(readOnly = true)
	public Map<String, Object> findFormData(GenTable genTable) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("tableList",  PublicUtil.convertComboDataList(findTableListFormDb(new GenTable()), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));
		// 验证表是否存在
		if (StringUtil.isBlank(genTable.getId()) && !checkTableName(genTable.getName())) {
			throw new RuntimeMsgException(PublicUtil.toAppendStr("下一步失败！", genTable.getName(), " 表已经添加！"));
		}
		if(PublicUtil.isNotEmpty(genTable.getId())){
			genTable = findOne(genTable.getId());
		}
		// 获取物理表字段
		genTable = getTableFormDb(genTable);
		map.put("columnList",  PublicUtil.convertComboDataList(genTable.getColumnList(), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));
		
		
		map.put("genTable", genTable);
		GenConfig config = GenUtil.getConfig();
		map.put("config", config);
		
		map.put("queryTypeList",  PublicUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("showTypeList",  PublicUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("javaTypeList",  PublicUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));
		
		
		return map;
	}
}
