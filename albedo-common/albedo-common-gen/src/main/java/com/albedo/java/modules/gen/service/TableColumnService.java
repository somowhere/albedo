package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;

/**
* @Description: 
* @Author: somewhere
* @Date: 2020/5/30 11:25 下午
*/
public interface TableColumnService extends DataService<TableColumn, TableColumnDto, String> {
	/**
	* @Description: 删除列信息
	* @Param: [id]
	* @return: void
	* @Author: somewhere
	* @Date: 2020/5/30 11:25 下午
	*/
	void deleteByTableId(String id);
}
