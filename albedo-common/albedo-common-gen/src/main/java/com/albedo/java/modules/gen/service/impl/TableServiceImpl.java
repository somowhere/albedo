package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.core.vo.QueryCondition;
import com.albedo.java.common.persistence.DynamicSpecifications;
import com.albedo.java.common.persistence.SpecificationDetail;
import com.albedo.java.common.persistence.service.impl.DataVoServiceImpl;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.vo.TableColumnVo;
import com.albedo.java.modules.gen.domain.vo.TableDataVo;
import com.albedo.java.modules.gen.domain.vo.TableFormVo;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.TableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableServiceImpl extends
	DataVoServiceImpl<TableRepository, Table, String, TableDataVo> implements com.albedo.java.modules.gen.service.TableService {

	@Autowired
	private TableColumnServiceImpl tableColumnServiceImpl;

	@Override
	@Transactional(readOnly = true)
	public PageModel<Table> findPage(PageModel<Table> pm, List<QueryCondition> authQueryConditions) {
		//拼接查询动态对象
		SpecificationDetail<Table> spec = DynamicSpecifications.
			buildSpecification(pm.getQueryConditionJson());
		spec.orAll(authQueryConditions);
		findPage(pm, spec);
		return pm;
	}


	@Override
	public void save(TableDataVo tableDataVo) {
		boolean isNew = StringUtil.isEmpty(tableDataVo.getId());
		Table table = new Table();
		copyVoToBean(tableDataVo, table);
		super.saveOrUpdate(table);
		log.debug("Save Information for Table: {}", table);
		if (isNew) {
			for (TableColumn item : table.getColumnFormList()) {
				item.setTableId(table.getId());
			}
		} else {
			List<TableColumn> tableColumnEntities = tableColumnServiceImpl.findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_SQL_GENTABLEID, table.getId()));
			for (TableColumn item : table.getColumnFormList()) {
				for (TableColumn tableColumn : tableColumnEntities) {
					if (tableColumn.getId().equals(item.getId())) {
						item.setVersion(tableColumn.getVersion());
						break;
					}
				}
			}
		}

		tableColumnServiceImpl.saveOrUpdateBatch(table.getColumnFormList());

	}

	@Override
	public void copyVoToBean(TableDataVo form, Table table) {
		super.copyVoToBean(form, table);
		if (table != null) {
			if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
				table.setColumnFormList(form.getColumnFormList().stream()
					.map(item -> tableColumnServiceImpl.copyVoToBean(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(form.getColumnList())) {
				table.setColumnList(form.getColumnList().stream()
					.map(item -> tableColumnServiceImpl.copyVoToBean(item)).collect(Collectors.toList()));
			}
		}
	}

	@Override
	public void copyBeanToVo(Table table, TableDataVo result) {
		super.copyBeanToVo(table, result);
		if (table != null) {
			if (ObjectUtil.isNotEmpty(table.getColumnFormList())) {
				result.setColumnFormList(table.getColumnFormList().stream()
					.map(item -> tableColumnServiceImpl.copyBeanToVo(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(table.getColumnList())) {
				result.setColumnList(table.getColumnList().stream()
					.map(item -> tableColumnServiceImpl.copyBeanToVo(item)).collect(Collectors.toList()));
			}
		}
	}


	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public boolean checkTableName(String tableName) {
		if (StringUtil.isBlank(tableName)) {
			return true;
		}
		List<Table> list = findAll(
			DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(Table.F_NAME, tableName)));
		return list.size() == 0;
	}

	@Override
	public TableDataVo getTableFormDb(TableDataVo tableDataVo) {
		// 如果有表名，则获取物理表
		if (StringUtil.isNotBlank(tableDataVo.getName())) {

			List<TableDataVo> list = findTableListFormDb(tableDataVo);
			if (list.size() > 0) {

				// 如果是新增，初始化表属性
				if (ObjectUtil.isEmpty(tableDataVo.getId())) {
					tableDataVo = list.get(0);
					// 设置字段说明
					if (StringUtil.isBlank(tableDataVo.getComments())) {
						tableDataVo.setComments(tableDataVo.getName());
					}
					tableDataVo.setClassName(StringUtil.toCapitalizeCamelCase(tableDataVo.getName()));
				}

				// 添加新列
				List<TableColumnVo> columnList = findTableColumnList(tableDataVo);
				for (TableColumnVo column : columnList) {
					boolean b = false;
					for (TableColumnVo e : tableDataVo.getColumnList()) {
						if (e.getName().equals(column.getName())) {
							b = true;
							break;
						}
					}
					if (!b) {
						tableDataVo.getColumnList().add(column);
					}
				}
				// 删除已删除的列
				for (TableColumnVo e : tableDataVo.getColumnList()) {
					boolean b = false;
					for (TableColumnVo column : columnList) {
						if (column.getName().equals(e.getName())) {
							b = true;
						}
					}
					if (!b) {
						e.setDelFlag(TableColumnVo.FLAG_DELETE);
					}
				}

				// 获取主键
				tableDataVo.setPkList(findTablePK(tableDataVo));

				// 初始化列属性字段
				GenUtil.initColumnField(tableDataVo);

			}
		}
		return tableDataVo;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<String> findTablePK(TableDataVo tableDataVo) {
		List<String> pkList = null;

		pkList = repository.findTablePK(tableDataVo);
		return pkList;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TableColumnVo> findTableColumnList(TableDataVo tableDataVo) {
		List<String[]> GenString = null;
		List<TableColumnVo> list = null;
		list = repository.findTableColumnList(tableDataVo);
		Assert.notNull(list, StringUtil.toAppendStr("无法获取[", tableDataVo.getName(), "]表的列信息"));
		if (ObjectUtil.isNotEmpty(tableDataVo.getId())) {
			Collections.sort(list);
		}
		return list;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TableDataVo> findTableListFormDb(TableDataVo tableDataVo) {
		List<Table> tableEntities = findAll();
		TableQuery tableQuery = new TableQuery();
		if (tableDataVo != null) {
			tableQuery.setName(tableDataVo.getName());
		}
		List<String> tempNames = Lists.newArrayList("gen_");
		tableQuery.setNotLikeNames(tempNames);
		if (ObjectUtil.isNotEmpty(tableEntities)) {
			tableQuery.setNotNames(CollUtil.extractToList(tableEntities, Table.F_NAME));
		}
		List<Table> list = repository.findTableList(tableQuery);
		return list.stream().map(item -> copyBeanToVo(item)).collect(Collectors.toList());
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public Map<String, Object> findFormData(TableFormVo tableFormVo) {
		Map<String, Object> map = Maps.newHashMap();
		map.put("tableList", CollUtil.convertComboDataList(findTableListFormDb(new TableDataVo()), Table.F_NAME, Table.F_NAMESANDTITLE));
		// 验证参数缺失
		Assert.isTrue(StringUtil.isNotEmpty(tableFormVo.getId()) || StringUtil.isNotEmpty(tableFormVo.getName()),
			"参数缺失！");
		// 验证表是否存在
		Assert.isTrue(
			StringUtil.isNotEmpty(tableFormVo.getId()) || checkTableName(tableFormVo.getName()),
			StringUtil.toAppendStr("下一步失败！", tableFormVo.getName(), " 表已经添加！"));
		TableDataVo tableDataVo = new TableDataVo(tableFormVo);
		if (ObjectUtil.isNotEmpty(tableFormVo.getId())) {
			tableDataVo = findOneVo(tableFormVo.getId());
			tableDataVo.setColumnList(tableColumnServiceImpl.findAll(new QueryWrapper<TableColumn>().eq(TableColumn.F_SQL_GENTABLEID, tableFormVo.getId()))
				.stream().map(item -> tableColumnServiceImpl.copyBeanToVo(item)).collect(Collectors.toList())
			);
		}
		// 获取物理表字段
		tableDataVo = getTableFormDb(tableDataVo);
		map.put("columnList", CollUtil.convertComboDataList(tableDataVo.getColumnList(),
			Table.F_NAME, Table.F_NAMESANDTITLE));


		map.put("tableVo", tableDataVo);
		GenConfig config = GenUtil.getConfig();
		map.put("config", config);

		map.put("queryTypeList", CollUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("showTypeList", CollUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
		map.put("javaTypeList", CollUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));
		if (ObjectUtil.isNotEmpty(tableDataVo.getId())) {
			Collections.sort(tableDataVo.getColumnList());
		}

		return map;
	}

	@Override
	public void delete(List<String> ids, String currentAuditor) {
		ids.forEach(id -> {
			Table entity = repository.selectById(id);
			Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
			deleteById(id);
			tableColumnServiceImpl.deleteByTableId(id, currentAuditor);
			log.debug("Deleted TableDataVo: {}", entity);
		});
	}
}
