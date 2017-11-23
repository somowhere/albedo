package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataVoService;
import com.albedo.java.modules.gen.domain.GenScheme;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTemplate;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenSchemeRepository;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.gen.GenSchemeVo;
import com.albedo.java.vo.gen.GenTableVo;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service class for managing genSchemes.
 *
 * @author somewhere
 */
@Service
public class GenSchemeService extends DataVoService<GenSchemeRepository, GenScheme, String, GenSchemeVo> {

    @Resource
    private GenTableRepository genTableRepository;
    @Resource
    private GenTableService genTableService;

    public List<GenScheme> findAll(String id) {

        SpecificationDetail specificationDetail = DynamicSpecifications.bySearchQueryCondition(
                QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL),
                QueryCondition.ne(GenTable.F_ID, id == null ? "-1" : id));
        return findAll(specificationDetail);
//		return repository.findAllByStatusAndId(GenTableVo.FLAG_NORMAL, id == null ? "-1" : id);
    }


    public String generateCode(GenSchemeVo genSchemeVo) {
        StringBuilder result = new StringBuilder();

        // 查询主表及字段列
        GenTableVo genTableVo = genTableService.findOneVo(genSchemeVo.getGenTableId());

        Collections.sort(genTableVo.getColumnList());

        // 获取所有代码模板
        GenConfig config = GenUtil.getConfig();

        // 获取模板列表
        List<GenTemplate> templateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), false);
        List<GenTemplate> childTableTemplateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), true);

        // 如果有子表模板，则需要获取子表列表
        if (childTableTemplateList.size() > 0) {
            genTableVo.setChildList(genTableRepository.findAllByParentTable(genTableVo.getId())
                    .stream().map(item -> genTableService.copyBeanToVo(item)).collect(Collectors.toList()));
        }

        // 生成子表模板代码
        if (genTableVo.getChildList() == null) {
            genTableVo.setChildList(Lists.newArrayList());
        }
        for (GenTableVo childTable : genTableVo.getChildList()) {
            Collections.sort(childTable.getColumnList());
            childTable.setCategory(genSchemeVo.getCategory());
            genSchemeVo.setGenTable(childTable);
            Map<String, Object> childTableModel = GenUtil.getDataModel(genSchemeVo);
            for (GenTemplate tpl : childTableTemplateList) {
                result.append(GenUtil.generateToFile(tpl, childTableModel, genSchemeVo.getReplaceFile()));
            }
        }
        genTableVo.setCategory(genSchemeVo.getCategory());
        // 生成主表模板代码
        genSchemeVo.setGenTable(genTableVo);
        Map<String, Object> model = GenUtil.getDataModel(genSchemeVo);
        for (GenTemplate tpl : templateList) {
            result.append(GenUtil.generateToFile(tpl, model, genSchemeVo.getReplaceFile()));
        }
        return result.toString();
    }

}
