package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.service.DataService;
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
public class GenSchemeService extends DataVoService<GenSchemeRepository,
        GenScheme, String, GenSchemeVo> {

    @Resource
    private GenTableService genTableService;

    public List<GenScheme> findAll(String id) {
        return repository.findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL),
                QueryCondition.ne(GenTable.F_ID, id == null ? "-1" : id)));
    }


    public String generateCode(GenSchemeVo genSchemeVo) {
        StringBuilder result = new StringBuilder();

        // 查询主表及字段列
        GenTableVo genTableVo = genTableService.findOneVo(genSchemeVo.getGenTableId());

        // 获取所有代码模板
        GenConfig config = GenUtil.getConfig();

        // 获取模板列表
        List<GenTemplate> templateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), false);
        List<GenTemplate> childTableTemplateList = GenUtil.getTemplateList(config, genSchemeVo.getCategory(), true);

        // 如果有子表模板，则需要获取子表列表
        if (childTableTemplateList.size() > 0) {
            genTableVo.getChildList();
        }

        // 生成子表模板代码
        if(genTableVo.getChildList()!=null){
            for (GenTableVo childTable : genTableVo.getChildList()) {
                childTable.setCategory(genSchemeVo.getCategory());
                genSchemeVo.setGenTable(childTable);
                Map<String, Object> childTableModel = GenUtil.getDataModel(genSchemeVo);
                for (GenTemplate tpl : childTableTemplateList) {
                    result.append(GenUtil.generateToFile(tpl, childTableModel, genSchemeVo.getReplaceFile()));
                }
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
