/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.TreeVoService;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.repository.AreaRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.AreaVo;
import com.albedo.java.vo.sys.query.AreaTreeQuery;
import com.albedo.java.vo.sys.query.TreeResult;
import com.google.common.collect.Lists;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 区域管理Service 区域管理
 *
 * @author admin
 * @version 2017-01-01
 */
@Service
@Transactional
public class AreaService extends TreeVoService<AreaRepository, Area, String, AreaVo> {

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TreeResult> findTreeData(AreaTreeQuery areaTreeQuery,
                                         List<Area> list) {
        String extId = areaTreeQuery != null ? areaTreeQuery.getExtId() : null,
                all = areaTreeQuery != null ? areaTreeQuery.getAll() : null,
                parentId = areaTreeQuery != null ? areaTreeQuery.getParentId() : null;
        Integer ltLevel = areaTreeQuery != null ? areaTreeQuery.getLtLevel() : null,
                level = areaTreeQuery != null ? areaTreeQuery.getLevel() : null;
        List<TreeResult> mapList = Lists.newArrayList();
        TreeResult treeResult = null;
        for (Area e : list) {
            if ((StringUtil.isBlank(extId) || (extId != null && !extId.equals(e.getId()) && e.getParentIds().indexOf("," + extId + ",") == -1))
                    && (all != null || BaseEntity.FLAG_NORMAL.equals(e.getStatus()))
                    && (ltLevel == null || ltLevel >= e.getLevel())
                    && (level == null || level.equals(e.getLevel()))
                    && (PublicUtil.isEmpty(parentId) || e.getParentId().equals(parentId))) {
                treeResult = new TreeResult();
                treeResult.setId(e.getId());
                treeResult.setPid(PublicUtil.isEmpty(e.getParentId()) ? "0" : e.getParentId());
                treeResult.setLabel(e.getName());
                treeResult.setKey(e.getName());
                treeResult.setValue(e.getId());
                treeResult.setIconCls("fa fa-th-large");
                mapList.add(treeResult);
            }
        }
        return mapList;
    }


    public List<Area> findAllList() {
        SpecificationDetail<Area> spd = DynamicSpecifications
                .bySearchQueryCondition(QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
        spd.orderASC(Area.F_ID);
        return findAll(spd);
    }
}