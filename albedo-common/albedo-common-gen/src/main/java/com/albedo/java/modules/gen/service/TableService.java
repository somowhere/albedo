package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface TableService extends DataService<Table, TableDto, String> {


	@Transactional(readOnly = true, rollbackFor = Exception.class)
	boolean checkTableName(String tableName);

	TableDto getTableFormDb(TableDto tableDto);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<String> findTablePK(TableDto tableDto);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableColumnDto> findTableColumnList(TableDto tableDto);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableDto> findTableListFormDb(TableDto tableDto);

	@Transactional(readOnly = true, rollbackFor = Exception.class)
	Map<String, Object> findFormData(TableFromDto tableFromDto);

	void delete(Set<String> ids);
}
