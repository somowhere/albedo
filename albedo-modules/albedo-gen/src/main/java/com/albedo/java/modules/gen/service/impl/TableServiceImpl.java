/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.modules.gen.cache.TableCacheKeyBuilder;
import com.albedo.java.modules.gen.domain.DatasourceConfDo;
import com.albedo.java.modules.gen.domain.TableColumnDo;
import com.albedo.java.modules.gen.domain.TableDo;
import com.albedo.java.modules.gen.domain.dto.TableColumnDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.dto.TableFromDto;
import com.albedo.java.modules.gen.domain.vo.TableFormDataVo;
import com.albedo.java.modules.gen.domain.vo.TableQuery;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.TableRepository;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.albedo.java.modules.gen.service.TableColumnService;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.DictDo;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Service class for managing tables.
 *
 * @author somewhere
 */
@Service
public class TableServiceImpl extends AbstractDataCacheServiceImpl<TableRepository, TableDo, TableDto>
	implements TableService {

	@Resource
	private TableColumnService tableColumnService;

	@Resource
	private DatasourceConfService datasourceConfService;

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new TableCacheKeyBuilder();
	}

	@Override
	public void saveOrUpdate(TableDto tableDto) {
		TableDo tableDo = new TableDo();
		copyDtoToBean(tableDto, tableDo);
		super.saveOrUpdate(tableDo);
		logger.debug("Save Information for Table: {}", tableDo);
		for (TableColumnDo item : tableDo.getColumnFormList()) {
			item.setTableId(tableDo.getId());
		}
		List<TableColumnDo> tableColumnDoEntities = tableColumnService
			.list(Wrappers.<TableColumnDo>query().eq(TableColumnDo.F_SQL_GENTABLEID, tableDo.getId()));
		for (TableColumnDo item : tableDo.getColumnFormList()) {
			for (TableColumnDo tableColumnDo : tableColumnDoEntities) {
				if (tableColumnDo.getId().equals(item.getId())) {
					item.setVersion(tableColumnDo.getVersion());
					break;
				}
			}
		}

		tableColumnService.saveOrUpdateBatch(tableDo.getColumnFormList());

	}

	@Override
	public void copyDtoToBean(TableDto form, TableDo tableDo) {
		super.copyDtoToBean(form, tableDo);
		if (tableDo != null) {
			if (ObjectUtil.isNotEmpty(form.getPkColumnList())) {
				tableDo.setPkColumnList(form.getPkColumnList().stream().map(item -> tableColumnService.copyDtoToBean(item))
					.collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(form.getColumnFormList())) {
				tableDo.setColumnFormList(form.getColumnFormList().stream()
					.map(item -> tableColumnService.copyDtoToBean(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(form.getColumnList())) {
				tableDo.setColumnList(form.getColumnList().stream().map(item -> tableColumnService.copyDtoToBean(item))
					.collect(Collectors.toList()));
			}
		}
	}

	@Override
	public void copyBeanToDto(TableDo tableDo, TableDto result) {
		super.copyBeanToDto(tableDo, result);
		if (tableDo != null) {
			if (ObjectUtil.isNotEmpty(tableDo.getColumnFormList())) {
				result.setColumnFormList(tableDo.getColumnFormList().stream()
					.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
			}
			if (ObjectUtil.isNotEmpty(tableDo.getColumnList())) {
				result.setColumnList(tableDo.getColumnList().stream().map(item -> tableColumnService.copyBeanToDto(item))
					.collect(Collectors.toList()));
			}
		}
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public boolean checkTableName(String tableName) {
		if (StringUtil.isBlank(tableName)) {
			return true;
		}
		List<TableDo> list = super.list(Wrappers.<TableDo>query().eq(TableDo.F_NAME, tableName));
		return list.size() == 0;
	}

	@Override
	public TableDto getTableFormDb(TableDto tableDto) {
		// 如果有表名，则获取物理表
		if (StringUtil.isNotBlank(tableDto.getName())) {

			List<TableDto> list = findTableListFormDb(tableDto);
			if (list.size() > 0 && CollUtil.isEmpty(tableDto.getColumnList())) {

				// 如果是新增，初始化表属性
				if (ObjectUtil.isEmpty(tableDto.getId())) {
					list.get(0).setDsName(tableDto.getDsName());
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
				tableDto.setPkList(findTablePk(tableDto));

				// 初始化列属性字段
				GenUtil.initColumnField(tableDto);

			}
		}
		return tableDto;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<String> findTablePk(TableDto tableDto) {
		List<String> pkList = repository.findTablePk(tableDto.getName(), tableDto.getDsName());
		return pkList;
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public List<TableColumnDto> findTableColumnList(TableDto tableDto) {
		List<TableColumnDto> list = repository.findTableColumnList(tableDto.getName(), tableDto.getDsName());
		ArgumentAssert.notNull(list, StringUtil.toAppendStr("无法获取[", tableDto.getName(), "]表的列信息"));
		if (ObjectUtil.isNotEmpty(tableDto.getId())) {
			Collections.sort(list);
		}
		return list;
	}

	@Override
	public List<TableDto> findTableListFormDb(TableDto tableDto) {
		ArgumentAssert.notNull(tableDto, "无效参数");
		List<TableDo> tableDoEntities = list();
		TableQuery tableQuery = new TableQuery();
		if (StringUtil.isNotEmpty(tableDto.getName())) {
			tableQuery.setName(tableDto.getName());
		} else {
			List<String> tempNames = Lists.newArrayList("gen_");
			tableQuery.setNotLikeNames(tempNames);
			if (ObjectUtil.isNotEmpty(tableDoEntities)) {
				tableQuery.setNotNames(CollUtil.extractToList(tableDoEntities, TableDo.F_NAME));
			}
		}
		List<TableDo> list = repository.findTableList(tableQuery, tableDto.getDsName());
		return list.stream().map(item -> copyBeanToDto(item)).collect(Collectors.toList());
	}

	@Override
	public TableFormDataVo findFormData(TableFromDto tableFromDto) {
		// 验证参数缺失
		ArgumentAssert.isTrue(tableFromDto == null || StringUtil.isNotEmpty(tableFromDto.getId())
			|| StringUtil.isNotEmpty(tableFromDto.getTableName())
			|| StringUtil.isNotEmpty(tableFromDto.getDsName()), "参数缺失！");
		TableFormDataVo tableFormDataVo = new TableFormDataVo();
		TableDto tableDto = new TableDto(tableFromDto);
		tableFormDataVo.setTableList(
			CollUtil.convertSelectVoList(findTableListFormDb(tableDto), TableDo.F_NAME, TableDo.F_NAMESANDTITLE));
		// 验证表是否存在
		ArgumentAssert.isTrue(StringUtil.isNotEmpty(tableFromDto.getId()) || checkTableName(tableFromDto.getTableName()),
			StringUtil.toAppendStr("下一步失败！", tableFromDto.getTableName(), " 表已经添加！"));
		if (ObjectUtil.isNotEmpty(tableFromDto.getId())) {
			tableDto = getOneDto(tableFromDto.getId());
			tableDto.setColumnList(tableColumnService
				.list(Wrappers.<TableColumnDo>query().eq(TableColumnDo.F_SQL_GENTABLEID, tableFromDto.getId())).stream()
				.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
		}
		// 获取物理表字段
		tableDto = getTableFormDb(tableDto);
		tableFormDataVo.setColumnList(
			CollUtil.convertSelectVoList(tableDto.getColumnList(), TableDo.F_NAME, TableDo.F_NAMESANDTITLE));
		tableFormDataVo.setTableVo(tableDto);
		GenConfig config = GenUtil.getConfig();
		tableFormDataVo.setConfig(config);
		tableFormDataVo.setDsNameList(CollUtil.convertSelectVoList(datasourceConfService.list(), DatasourceConfDo.F_NAME,
			DatasourceConfDo.F_NAME));
		tableFormDataVo
			.setQueryTypeList(CollUtil.convertSelectVoList(config.getQueryTypeList(), DictDo.F_VAL, DictDo.F_NAME));
		tableFormDataVo
			.setQueryTypeList(CollUtil.convertSelectVoList(config.getQueryTypeList(), DictDo.F_VAL, DictDo.F_NAME));
		tableFormDataVo
			.setShowTypeList(CollUtil.convertSelectVoList(config.getShowTypeList(), DictDo.F_VAL, DictDo.F_NAME));
		tableFormDataVo
			.setJavaTypeList(CollUtil.convertSelectVoList(config.getJavaTypeList(), DictDo.F_VAL, DictDo.F_NAME));
		if (ObjectUtil.isNotEmpty(tableDto.getId())) {
			Collections.sort(tableDto.getColumnList());
		}

		return tableFormDataVo;
	}

	@Override
	public void delete(Set<String> ids) {
		ids.forEach(id -> {
			TableDo entity = repository.selectById(id);
			Assert.notNull(entity, "对象 " + id + " 信息为空，删除失败");
			removeById(id);
			tableColumnService.deleteByTableId(id);
			logger.debug("Deleted TableDto: {}", entity);
		});
	}

	@Override
	public void refreshColumn(TableDto tableDto) {

		Assert.isTrue(tableDto != null, "tableDto为空，操作失败");
		Assert.isTrue(CollUtil.isNotEmpty(tableDto.getColumnList()), "对象 " + tableDto.getName() + " 列信息为空，操作失败");
		tableColumnService.deleteByTableId(tableDto.getId());

		TableDo tableDo = new TableDo();
		copyDtoToBean(tableDto, tableDo);
		for (TableColumnDo item : tableDo.getColumnList()) {
			item.setTableId(tableDo.getId());
		}
		tableColumnService.saveOrUpdateBatch(tableDo.getColumnList());
	}

}
