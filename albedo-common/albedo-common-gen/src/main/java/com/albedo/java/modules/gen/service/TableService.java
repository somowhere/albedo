package com.albedo.java.modules.gen.service;

import com.albedo.java.common.persistence.service.DataService;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.vo.TableFormDataVo;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

/**
 * @author somewhere
 */
public interface TableService extends DataService<Table, TableDto, String> {

	/**
	 * 判断表名是否存在
	 *
	 * @param tableName
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	boolean checkTableName(String tableName);

	/**
	 * 获取物理表信息
	 *
	 * @param tableDto
	 * @return
	 */
	TableDto getTableFormDb(TableDto tableDto);

	/**
	 * 获取主键
	 *
	 * @param tableDto
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<String> findTablePk(TableDto tableDto);

	/**
	 * 获取表列信息
	 *
	 * @param tableDto
	 * @return
	 */
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	List<TableColumnDto> findTableColumnList(TableDto tableDto);

	/**
	 * 读取数据库表集合信息
	 *
	 * @param tableDto
	 * @return
	 */
	List<TableDto> findTableListFormDb(TableDto tableDto);

	/**
	 * 获取编辑所需要得表对象信息
	 *
	 * @param tableFromDto
	 * @return
	 */
	TableFormDataVo findFormData(TableFromDto tableFromDto);

	/**
	 * 批量删除
	 *
	 * @param ids
	 */
	void delete(Set<String> ids);

	/**
	 * 同步对于表在数据库中表列信息
	 *
	 * @param tableDto
	 */
	void refreshColumn(TableDto tableDto);

}
