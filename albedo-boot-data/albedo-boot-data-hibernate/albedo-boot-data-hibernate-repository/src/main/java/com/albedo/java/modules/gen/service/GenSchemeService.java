package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.hibernate.persistence.DynamicSpecifications;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.gen.domain.GenScheme;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTemplate;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenSchemeRepository;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Service class for managing genSchemes.
 */
@Service
@Transactional
public class GenSchemeService extends DataService<GenSchemeRepository, GenScheme, String> {

    @Resource
    private GenTableRepository genTableRepository;

	public List<GenScheme> findAll(String id) {
		return repository.findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL), 
				QueryCondition.ne(GenTable.F_ID, id == null ? "-1" : id)));
	}


	public String generateCode(GenScheme genScheme) {
		StringBuilder result = new StringBuilder();

		// 查询主表及字段列
		GenTable genTable = genTableRepository.findOne(genScheme.getGenTableId());

		// 获取所有代码模板
		GenConfig config = GenUtil.getConfig();

		// 获取模板列表
		List<GenTemplate> templateList = GenUtil.getTemplateList(config, genScheme.getCategory(), false);
		List<GenTemplate> childTableTemplateList = GenUtil.getTemplateList(config, genScheme.getCategory(), true);

		// 如果有子表模板，则需要获取子表列表
		if (childTableTemplateList.size() > 0) {
			genTable.getChildList();
		}

		// 生成子表模板代码
		for (GenTable childTable : genTable.getChildList()) {
			childTable.setCategory(genScheme.getCategory());
			genScheme.setGenTable(childTable);
			Map<String, Object> childTableModel = GenUtil.getDataModel(genScheme);
			for (GenTemplate tpl : childTableTemplateList) {
				result.append(GenUtil.generateToFile(tpl, childTableModel, genScheme.getReplaceFile()));
			}
		}
		genTable.setCategory(genScheme.getCategory());
		// 生成主表模板代码
		genScheme.setGenTable(genTable);
		Map<String, Object> model = GenUtil.getDataModel(genScheme);
		for (GenTemplate tpl : templateList) {
			result.append(GenUtil.generateToFile(tpl, model, genScheme.getReplaceFile()));
		}
		return result.toString();
	}

}
