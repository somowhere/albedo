package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 */
public interface TableRepository extends BaseRepository<Table> {
	/**
	 * 查询表列表
	 *
	 * @param tableQuery
	 * @return
	 */
	List<Table> findTableList(@Param("tableQuery") TableQuery tableQuery);

	/**
	 * 获取数据表字段
	 *
	 * @param tableDataVo
	 * @return
	 */
	List<TableColumnDto> findTableColumnList(@Param("tableDataVo") TableDto tableDataVo);

	/**
	 * 获取数据表主键
	 *
	 * @param tableDataVo
	 * @return
	 */
	List<String> findTablePK(@Param("tableDataVo") TableDto tableDataVo);

	List<Table> findAllByParentTable(String id);
}
