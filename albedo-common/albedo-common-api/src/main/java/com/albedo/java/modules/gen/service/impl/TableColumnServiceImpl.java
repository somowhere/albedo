package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.repository.TableColumnRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableColumnServiceImpl extends
	DataVoServiceImpl<TableColumnRepository, TableColumn, String, TableColumnVo> implements com.albedo.java.modules.gen.service.TableColumnService {

	List<TableColumn> findAllByGenTableIdOrderBySort(String id) {
		return findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_GENTABLEID, id)
			.orderByAsc(TableColumn.F_SORT));
	}


	@Override
	public void deleteByTableId(String id, String currentAuditor) {
		List<TableColumn> tableColumnList = findAllByGenTableIdOrderBySort(id);
		Assert.notNull(tableColumnList, "id " + id + " tableColumn 不能为空");
		super.deleteBatchIds(tableColumnList.stream().map(item -> item.getId()).collect(Collectors.toList()));

	}


}
