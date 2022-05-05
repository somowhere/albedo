/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
import com.albedo.java.common.core.exception.BizException;
import com.albedo.java.common.core.util.ArgumentAssert;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.FreeMarkers;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.modules.gen.cache.SchemeCacheKeyBuilder;
import com.albedo.java.modules.gen.domain.Scheme;
import com.albedo.java.modules.gen.domain.Table;
import com.albedo.java.modules.gen.domain.TableColumn;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeQueryCriteria;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.vo.SchemeFormDataVo;
import com.albedo.java.modules.gen.domain.vo.SchemeVo;
import com.albedo.java.modules.gen.domain.vo.TemplateVo;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.SchemeRepository;
import com.albedo.java.modules.gen.repository.TableRepository;
import com.albedo.java.modules.gen.service.SchemeService;
import com.albedo.java.modules.gen.service.TableColumnService;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.plugins.database.mybatis.service.impl.AbstractDataCacheServiceImpl;
import com.albedo.java.plugins.database.mybatis.util.QueryWrapperUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Service class for managing schemes.
 *
 * @author somewhere
 */
@Service
@AllArgsConstructor
public class SchemeServiceImpl extends AbstractDataCacheServiceImpl<SchemeRepository, Scheme, SchemeDto>
	implements SchemeService {

	private final TableRepository tableRepository;

	private final TableService tableService;

	private final TableColumnService tableColumnService;

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new SchemeCacheKeyBuilder();
	}

	@Override
	public List<Scheme> findAllListIdNot(String id) {
		return super.list(Wrappers.<Scheme>query().ne(Table.F_ID, id == null ? "-1" : id));
	}

	@Override
	public String generateCode(SchemeDto schemeDto) {
		StringBuilder result = new StringBuilder();

		// 查询主表及字段列
		TableDto tableDto = tableService.getOneDto(schemeDto.getTableId());
		tableDto.setColumnList(tableColumnService
			.list(Wrappers.<TableColumn>query().eq(TableColumn.F_SQL_GENTABLEID, tableDto.getId())).stream()
			.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
		Collections.sort(tableDto.getColumnList());

		// 获取所有代码模板
		GenConfig config = GenUtil.getConfig();

		// 获取模板列表
		List<TemplateVo> templateList = GenUtil.getTemplateList(config, schemeDto.getCategory(), false);
		List<TemplateVo> childTableTemplateList = GenUtil.getTemplateList(config, schemeDto.getCategory(), true);

		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0) {
			tableDto.setChildList(tableRepository
				.selectList(Wrappers.<Table>lambdaQuery().eq(Table::getParentTable, tableDto.getId())).stream()
				.map(item -> tableService.copyBeanToDto(item)).collect(Collectors.toList()));
		}

		// 生成子表模板代码
		if (tableDto.getChildList() == null) {
			tableDto.setChildList(Lists.newArrayList());
		}
		for (TableDto childTable : tableDto.getChildList()) {
			Collections.sort(childTable.getColumnList());
			childTable.setCategory(schemeDto.getCategory());
			schemeDto.setTableDto(childTable);
			Map<String, Object> childTableModel = GenUtil.getDataModel(schemeDto);
			for (TemplateVo tpl : childTableTemplateList) {
				result.append(GenUtil.generateToFile(tpl, childTableModel, schemeDto.getReplaceFile()));
			}
		}
		tableDto.setCategory(schemeDto.getCategory());
		// 生成主表模板代码
		schemeDto.setTableDto(tableDto);
		Map<String, Object> model = GenUtil.getDataModel(schemeDto);
		for (TemplateVo tpl : templateList) {
			result.append(GenUtil.generateToFile(tpl, model, schemeDto.getReplaceFile()));
		}
		return result.toString();
	}

	@Override
	@Transactional(readOnly = true)
	public SchemeFormDataVo findFormData(SchemeDto schemeDto, String loginId) {
		SchemeFormDataVo schemeFormDataVo = new SchemeFormDataVo();
		ArgumentAssert.notNull(schemeDto, "生成方案不能为空");
		if (StringUtil.isNotEmpty(schemeDto.getId())) {
			schemeDto = super.getOneDto(schemeDto.getId());
		}
		if (StringUtil.isBlank(schemeDto.getPackageName())) {
			schemeDto.setPackageName("com.albedo.java.modules");
		}
		if (StringUtil.isBlank(schemeDto.getFunctionAuthor())) {
			schemeDto.setFunctionAuthor(loginId);
		}
		schemeFormDataVo.setSchemeVo(schemeDto);
		GenConfig config = GenUtil.getConfig();
		schemeFormDataVo.setConfig(config);

		schemeFormDataVo.setCategoryList(CollUtil.convertSelectVoList(config.getCategoryList(), Dict.F_VAL, Dict.F_NAME));
		schemeFormDataVo.setViewTypeList(CollUtil.convertSelectVoList(config.getViewTypeList(), Dict.F_VAL, Dict.F_NAME));

		List<Table> tableList = tableService.list(), list = Lists.newArrayList();
		List<String> tableIds = Lists.newArrayList();
		if (StringUtil.isNotEmpty(schemeDto.getId())) {
			List<Scheme> schemeList = findAllListIdNot(schemeDto.getId());
			tableIds = CollUtil.extractToList(schemeList, "tableId");
		}
		for (Table table : tableList) {
			if (!tableIds.contains(table.getId())) {
				list.add(table);
			}
		}
		schemeFormDataVo.setTableList(CollUtil.convertSelectVoList(list, Table.F_ID, Table.F_NAMESANDTITLE));
		return schemeFormDataVo;
	}

	@Override
	public IPage getSchemeVoPage(PageModel pageModel, SchemeQueryCriteria schemeQueryCriteria) {
		QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pageModel, schemeQueryCriteria);

		wrapper.eq("a.del_flag", Scheme.FLAG_NORMAL);
		pageModel.addOrder(OrderItem.desc("a." + Scheme.F_SQL_CREATED_DATE));
		IPage<List<SchemeVo>> userVosPage = repository.getSchemeVoPage(pageModel, wrapper);
		return userVosPage;
	}

	@Override
	public Map<String, Object> previewCode(String id, String username) {
		Map<String, Object> result = Maps.newHashMap();
		SchemeDto schemeDto = super.getOneDto(id);
		// 查询主表及字段列
		TableDto tableDto = tableService.getOneDto(schemeDto.getTableId());
		ArgumentAssert.notNull(tableDto, "无法找到业务表ID为" + id + "的数据");
		tableDto.setColumnList(Optional.ofNullable(tableColumnService
				.list(Wrappers.<TableColumn>query().eq(TableColumn.F_SQL_GENTABLEID, tableDto.getId()))).orElseThrow(() -> new BizException("业务列信息不存在")).stream()
			.map(item -> tableColumnService.copyBeanToDto(item)).collect(Collectors.toList()));
		Collections.sort(tableDto.getColumnList());

		// 获取所有代码模板
		GenConfig config = GenUtil.getConfig();

		// 获取模板列表
		List<TemplateVo> templateList = GenUtil.getTemplateList(config, schemeDto.getCategory(), false);
		List<TemplateVo> childTableTemplateList = GenUtil.getTemplateList(config, schemeDto.getCategory(), true);

		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0) {
			tableDto.setChildList(Optional.ofNullable(tableRepository
					.selectList(Wrappers.<Table>lambdaQuery().eq(Table::getParentTable, tableDto.getId()))).orElseThrow(() -> new BizException("业务表不存在")).stream()
				.map(item -> tableService.copyBeanToDto(item)).collect(Collectors.toList()));
		}

		// 生成子表模板代码
		if (tableDto.getChildList() == null) {
			tableDto.setChildList(Lists.newArrayList());
		}
		for (TableDto childTable : tableDto.getChildList()) {
			Collections.sort(childTable.getColumnList());
			childTable.setCategory(schemeDto.getCategory());
			schemeDto.setTableDto(childTable);
			Map<String, Object> childTableModel = GenUtil.getDataModel(schemeDto);
			for (TemplateVo tpl : childTableTemplateList) {
				String content = FreeMarkers.renderString(StringUtil.trimToEmpty(tpl.getContent()), childTableModel);
				result.put(FreeMarkers.renderString(tpl.getFileName(), childTableModel), content);
			}
		}
		tableDto.setCategory(schemeDto.getCategory());
		// 生成主表模板代码
		schemeDto.setTableDto(tableDto);
		Map<String, Object> model = GenUtil.getDataModel(schemeDto);
		for (TemplateVo tpl : templateList) {
			String content = FreeMarkers.renderString(StringUtil.trimToEmpty(tpl.getContent()), model);
			result.put(FreeMarkers.renderString(tpl.getFileName(), model), content);
		}
		return result;

	}

}
