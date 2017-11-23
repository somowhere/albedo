package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.service.TreeVoService;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.repository.DictRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.vo.base.SelectResult;
import com.albedo.java.vo.sys.DictVo;
import com.albedo.java.vo.sys.query.DictTreeQuery;
import com.albedo.java.vo.sys.query.DictTreeResult;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing dicts.
 */
@Service
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

//    @Transactional(readOnly = true, rollbackFor = Exception.class)
//    public List<Map<String, Object>> findTreeData(DictTreeQuery dictTreeQuery, List<Dict> dictList) {
//        String type = dictTreeQuery != null ? dictTreeQuery.getType() : null, all = dictTreeQuery != null ? dictTreeQuery.getAll() : null;
//        List<Map<String, Object>> mapList = Lists.newArrayList();
//        for (Dict e : dictList) {
//            if ((all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
//                Map<String, Object> map = Maps.newHashMap();
//                map.put("id", e.getId());
//                map.put("pId", PublicUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
//                map.put("name", e.getName());
//                mapList.add(map);
//            }
//        }
//
//
//        return mapList;
//    }


    public SelectResult copyBeanToSelect(Dict item) {
        SelectResult selectResult = new SelectResult(item.getVal(), item.getName());
        return selectResult;
    }

}
