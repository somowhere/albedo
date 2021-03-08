package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.baomidou.dynamic.datasource.annotation.DS;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 *
 * @author somewhere
 */
public interface TableRepository extends BaseRepository<Table> {
	/**
	 * 查询表列表
	 *
	 * @param tableQuery
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<Table> findTableList(@Param("tableQuery") TableQuery tableQuery, String dsName);

	/**
	 * 获取数据表字段
	 *
	 * @param tableName
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<TableColumnDto> findTableColumnList(@Param("tableName") String tableName, String dsName);

	/**
	 * 获取数据表主键
	 *
	 * @param tableName
	 * @param dsName
	 * @return
	 */
	@DS("#last")
	List<String> findTablePk(@Param("tableName") String tableName, String dsName);

}
