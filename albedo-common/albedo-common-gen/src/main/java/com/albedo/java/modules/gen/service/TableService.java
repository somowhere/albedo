package com.albedo.java.modules.gen.service;

import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.service.DataVoService;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.domain.vo.TableFormVo;
import com.albedo.java.modules.gen.repository.TableRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface TableService extends DataVoService<TableRepository, Table, String, TableDataVo> {
	@Transactional(readOnly = true)
	PageModel<Table> findPage(PageModel<Table> pm, List<QueryCondition> authQueryConditions);

	void save(TableDataVo tableDataVo);

	void copyVoToBean(TableDataVo form, Table table);

	void copyBeanToVo(Table table, TableDataVo result);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	boolean checkTableName(String tableName);

	TableDataVo getTableFormDb(TableDataVo tableDataVo);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<String> findTablePK(TableDataVo tableDataVo);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableColumnVo> findTableColumnList(TableDataVo tableDataVo);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableDataVo> findTableListFormDb(TableDataVo tableDataVo);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Map<String, Object> findFormData(TableFormVo tableFormVo);

	void delete(List<String> ids, String currentAuditor);
}
