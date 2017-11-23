package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.service.TreeVoService;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.OrgVo;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.vo.sys.query.TreeResult;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * Service class for managing orgs.
 */
@Service
@Transactional
public class OrgService extends TreeVoService<OrgRepository, Org, String, OrgVo> {


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<TreeResult> findTreeData(OrgTreeQuery orgTreeQuery, List<Org> list) {
        String extId = orgTreeQuery != null ? orgTreeQuery.getExtId() : null,
                showType = orgTreeQuery != null ? orgTreeQuery.getShowType() : null,
                all = orgTreeQuery != null ? orgTreeQuery.getAll() : null;
        Long grade = orgTreeQuery != null ? orgTreeQuery.getGrade() : null;
        List<TreeResult> mapList = Lists.newArrayList();
        TreeResult treeResult = null;
        for (Org e : list) {
            if ((PublicUtil.isEmpty(extId)
                    || PublicUtil.isEmpty(e.getParentIds()) || (PublicUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf("," + extId + ",") == -1))
                    && (PublicUtil.isEmpty(showType)
                    || (PublicUtil.isNotEmpty(showType) && (showType.equals("1") ? showType.equals(e.getType()) : true)))
                    && (PublicUtil.isEmpty(grade) || (PublicUtil.isNotEmpty(grade) && Integer.parseInt(e.getGrade()) <= grade.intValue()))
                    && (all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
                treeResult = new TreeResult();
                treeResult.setId(e.getId());
                treeResult.setPid(e.getParentId());
                treeResult.setLabel(e.getName());
                treeResult.setKey(e.getName());
                treeResult.setValue(e.getId());
                mapList.add(treeResult);
            }
        }
        return mapList;

    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Org> findAll(PageModel<Org> pm) {
        SpecificationDetail<Org> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
        return repository.findAll(spec, pm);
    }

//    @Override
//    @Transactional(readOnly = true, rollbackFor = Exception.class)
//    public List<Org> findAllByParentId(String parentId) {
//        return repository.findAllByParentIdAndStatusNot(parentId, Org.FLAG_DELETE);
//    }

    public List<Org> findAllList(boolean admin, Collection<QueryCondition> authQueryList) {
        SpecificationDetail<Org> spd = new SpecificationDetail<Org>()
                .and(QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
        if (!admin) {
            spd.orAll(authQueryList);
        }
        spd.orderASC(Org.F_SORT);
        return repository.findAll(spd);
    }
}
