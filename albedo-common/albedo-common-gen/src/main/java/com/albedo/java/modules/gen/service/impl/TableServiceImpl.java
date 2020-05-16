package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.TableRepository;
import com.albedo.java.modules.gen.service.TableColumnService;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableServiceImpl extends
	DataServiceImpl<TableRepository, Table, TableDto, String> implements com.albedo.java.modules.gen.service.TableService {

	@Autowired
	private TableColumnService tableColumnService;


	@Override
	public void save(TableDto tableDto) {
		boolean isNew = StringUtil.isEmpty(tableDto.getId());
		Table table = new Table();
		copyDtoToBean(tableDto, table);
		super.saveOrUpdate(table);
		log.debug("Save Information for Table: {}", table);
		if (isNew) {
			for (TableColumn item : table.getColumnFormList()) {
				item.setTableId(table.getId());
			}
		} else {
			List<TableColumn> tableColumnEntities = tableColumnService.list(
				Wrappers.<TableColumn>query().eq(TableColumn.F_SQL_GENTABLEID, table.getId()));
			for (TableColumn item : table.getColumnFormList()) {
				for (TableColumn tableColumn : tableColumnEntities) {
					if (tableColumn.getId().equals(item.getId())) {
						item.setVersion(tableColumn.getVersion());
						break;
					}
				}
			}
		}

		tableColumnService.saveOrUpdateBatch(table.getColumnFormList());

	}

	@Override
	public void copyDtoToBean(TableDto form, Table table) {
		super.copyDtoToBean(form, table);
		if (table != null) {
			if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
				table.setColumnFormList(form.getColumnFormList().stream()
					.map(item -> tableColumnService.copyDtoToBean(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(form.getColumnList())) {
				table.setColumnList(form.getColumnList().stream()
					.map(item -> tableColumnService.copyDtoToBean(item)).collect(Collectors.toList()));
			}
		}
	}

	@Override
	public void copyBeanToDto(Table table, TableDto result) {
		super.copyBeanToDto(table, result);
		if (table != null) {
			if (ObjectUtil.isNotEmpty(table.getColumnFormList())) {
				result.setColumnFormList(table.getColumnFormList().stream()
					.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(table.getColumnList())) {
				result.setColumnList(table.getColumnList().stream()
					.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
			}
		}
	}


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public boolean checkTableName(String tableName) {
		if (StringUtil.isBlank(tableName)) {
			return true;
		}
		List<Table> list = super.list(Wrappers.<Table>query().eq(Table.F_NAME, tableName));
		return list.size() == 0;
	}

	@Override
	public TableDto getTableFormDb(TableDto tableDto) {
		// 如果有表名，则获取物理表
		if (StringUtil.isNotBlank(tableDto.getName())) {

			List<TableDto> list = findTableListFormDb(tableDto);
			if (list.size() > 0) {

				// 如果是新增，初始化表属性
				if (ObjectUtil.isEmpty(tableDto.getId())) {
					tableDto = list.get(0);
					// 设置字段说明
					if (StringUtil.isBlank(tableDto.getComments())) {
						tableDto.setComments(tableDto.getName());
					}
					tableDto.setClassName(StringUtil.toCapitalizeCamelCase(tableDto.getName()));
				}

				// 添加新列
				List<TableColumnDto> columnList = findTableColumnList(tableDto);
				for (TableColumnDto column : columnList) {
					boolean b = false;
					for (TableColumnDto e : tableDto.getColumnList()) {
						if (e.getName().equals(column.getName())) {
							b = true;
							break;
						}
					}
					if (!b) {
						tableDto.getColumnList().add(column);
					}
				}
				// 删除已删除的列
				for (TableColumnDto e : tableDto.getColumnList()) {
					boolean b = false;
					for (TableColumnDto column : columnList) {
						if (column.getName().equals(e.getName())) {
							b = true;
						}
					}
					if (!b) {
						e.setDelFlag(TableColumnDto.FLAG_DELETE);
					}
				}

				// 获取主键
				tableDto.setPkList(findTablePK(tableDto));

				// 初始化列属性字段
				GenUtil.initColumnField(tableDto);

			}
		}
		return tableDto;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<String> findTablePK(TableDto tableDto) {
		List<String> pkList = null;

		pkList = repository.findTablePK(tableDto);
		return pkList;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TableColumnDto> findTableColumnList(TableDto tableDto) {
		List<String[]> GenString = null;
		List<TableColumnDto> list = null;
		list = repository.findTableColumnList(tableDto);
		Assert.notNull(list, StringUtil.toAppendStr("无法获取[", tableDto.getName(), "]表的列信息"));
		if (ObjectUtil.isNotEmpty(tableDto.getId())) {
			Collections.sort(list);
		}
		return list;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TableDto> findTableListFormDb(TableDto tableDto) {
		List<Table> tableEntities = list();
		TableQuery tableQuery = new TableQuery();
		if (tableDto != null) {
			tableQuery.setName(tableDto.getName());
		}
		List<String> tempNames = Lists.newArrayList("gen_");
		tableQuery.setNotLikeNames(tempNames);
		if (ObjectUtil.isNotEmpty(tableEntities)) {
			tableQuery.setNotNames(CollUtil.extractToList(tableEntities, Table.F_NAME));
		}
		List<Table> list = repository.findTableList(tableQuery);
		return list.stream().map(item -> copyBeanToDto(item)).collect(Collectors.toList());
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, Object> findFormData(TableFromDto tableFromDto) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("tableList", CollUtil.convertComboDataList(findTableListFormDb(new TableDto()), Table.F_NAME, Table.F_NAMESANDTITLE));
		// 验证参数缺失
		Assert.isTrue(StringUtil.isNotEmpty(tableFromDto.getId()) || StringUtil.isNotEmpty(tableFromDto.getName()),
			"参数缺失！");
		// 验证表是否存在
		Assert.isTrue(
			StringUtil.isNotEmpty(tableFromDto.getId()) || checkTableName(tableFromDto.getName()),
			StringUtil.toAppendStr("下一步失败！", tableFromDto.getName(), " 表已经添加！"));
		TableDto tableDto = new TableDto(tableFromDto);
		if (ObjectUtil.isNotEmpty(tableFromDto.getId())) {
			tableDto = getOneDto(tableFromDto.getId());
			tableDto.setColumnList(tableColumnService.list(Wrappers.<TableColumn>query().eq(TableColumn.F_SQL_GENTABLEID, tableFromDto.getId()))
				.stream().map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList())
			);
		}
		// 获取物理表字段
		tableDto = getTableFormDb(tableDto);
		map.put("columnList", CollUtil.convertComboDataList(tableDto.getColumnList(),
			Table.F_NAME, Table.F_NAMESANDTITLE));


		map.put("tableVo", tableDto);
		GenConfig config = GenUtil.getConfig();
		map.put("config", config);

		map.put("queryTypeList", CollUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("showTypeList", CollUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("javaTypeList", CollUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));
		if (ObjectUtil.isNotEmpty(tableDto.getId())) {
			Collections.sort(tableDto.getColumnList());
		}

		return map;
	}

	@Override
	public void delete(Set<String> ids) {
		ids.forEach(id -> {
			Table entity = repository.selectById(id);
			Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
			removeById(id);
			tableColumnService.deleteByTableId(id);
			log.debug("Deleted TableDto: {}", entity);
		});
	}
}
