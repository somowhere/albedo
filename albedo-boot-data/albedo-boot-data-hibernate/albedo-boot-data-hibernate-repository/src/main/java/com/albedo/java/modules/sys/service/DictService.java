package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.service.TreeService;
import com.albedo.java.common.service.TreeVoService;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.DictVo;
import com.albedo.java.vo.sys.query.DictTreeQuery;
import com.albedo.java.vo.sys.query.DictTreeResult;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Service class for managing dicts.
 */
@Service
@Transactional
public class DictService extends TreeVoService<DictRepository, Dict, String, DictVo> {

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<DictTreeResult> findTreeData(DictTreeQuery dictTreeQuery, List<Dict> dictList) {
        String type = dictTreeQuery != null ? dictTreeQuery.getType() : null, all = dictTreeQuery != null ? dictTreeQuery.getAll() : null;
        List<DictTreeResult> mapList = Lists.newArrayList();
        for (Dict e : dictList) {
            if ((all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
                DictTreeResult dictTreeResult = new DictTreeResult();
                dictTreeResult.setId(e.getId());
                dictTreeResult.setPid(PublicUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
                dictTreeResult.setName(e.getName());
                dictTreeResult.setValue(e.getId());
                dictTreeResult.setLabel(dictTreeResult.getName());
                mapList.add(dictTreeResult);
            }
        }
        return mapList;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Dict findOne(String id) {
        return repository.findOne(id);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Dict> findAll(PageModel<Dict> pm) {
        SpecificationDetail<Dict> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                QueryCondition.ne(Dict.F_STATUS, Dict.FLAG_DELETE));
        return repository.findAll(spec, pm);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Dict findFristByParentId(String parentId) {
        return repository.findTopByParentIdAndStatusNotOrderBySortDesc(parentId, Dict.FLAG_DELETE);
    }

}
