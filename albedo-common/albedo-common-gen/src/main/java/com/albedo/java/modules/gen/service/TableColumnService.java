package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;

public interface TableColumnService extends DataService<TableColumn, TableColumnDto, String> {
	void deleteByTableId(String id);
}
