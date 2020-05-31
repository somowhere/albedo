package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
public interface TableColumnService extends DataService<TableColumn, TableColumnDto, String> {
	/**
	 * deleteByTableId
	 *
	 * @param id
	 * @author somewhere
	 * @updateTime 2020/5/31 17:34
	 */
	void deleteByTableId(String id);
}
