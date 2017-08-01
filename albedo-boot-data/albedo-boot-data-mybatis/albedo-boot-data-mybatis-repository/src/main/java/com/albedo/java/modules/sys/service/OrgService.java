package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.TreeService;
import com.albedo.java.modules.sys.domain.Org;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.OrgForm;
import com.albedo.java.vo.sys.OrgResult;
import com.albedo.java.vo.sys.RoleResult;
import com.albedo.java.vo.sys.query.OrgTreeQuery;
import com.albedo.java.vo.sys.query.AntdTreeResult;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * Service class for managing orgs.
 */
@Service
@Transactional
public class OrgService extends TreeService<OrgRepository, Org, String> {

    @Transactional(readOnly = true)
    public List<AntdTreeResult> findTreeDataRest(OrgTreeQuery orgTreeQuery, List<Org> list) {
        String extId = orgTreeQuery != null ? orgTreeQuery.getExtId() : null,
                showType = orgTreeQuery != null ? orgTreeQuery.getShowType() : null,
                all = orgTreeQuery != null ? orgTreeQuery.getAll() : null;
        Long grade = orgTreeQuery != null ? orgTreeQuery.getGrade() : null;
        List<AntdTreeResult> mapList = Lists.newArrayList();
        AntdTreeResult antdTreeResult = null;
        for (Org e : list) {
            if ((PublicUtil.isEmpty(extId)
                    || PublicUtil.isEmpty(e.getParentIds()) || (PublicUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf("," + extId + ",") == -1))
                    && (PublicUtil.isEmpty(showType)
                    || (PublicUtil.isNotEmpty(showType) && (showType.equals("1") ? showType.equals(e.getType()) : true)))
                    && (PublicUtil.isEmpty(grade) || (PublicUtil.isNotEmpty(grade) && Integer.parseInt(e.getGrade()) <= grade.intValue()))
                    && (all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
                antdTreeResult = new AntdTreeResult();
                antdTreeResult.setId(e.getId());
                antdTreeResult.setPid(e.getParentId());
                antdTreeResult.setLabel(e.getName());
                antdTreeResult.setKey(e.getName());
                antdTreeResult.setValue(e.getId());
                mapList.add(antdTreeResult);
            }
        }
        return mapList;

    }
    public OrgResult copyBeanToResult(Org org) {
        OrgResult orgResult = new OrgResult();
        BeanUtils.copyProperties(org, orgResult);
        if (org.getParent() != null) orgResult.setParentName(org.getParent().getName());
        return orgResult;
    }

    private Org copyFormToBean(OrgForm orgForm, Org org) {
        BeanUtils.copyProperties(orgForm, org);
        return org;
    }


    @Transactional(readOnly = true)
    public List<Map<String, Object>> findTreeData(OrgTreeQuery orgTreeQuery, List<Org> list) {
        String extId = orgTreeQuery != null ? orgTreeQuery.getExtId() : null,
                showType = orgTreeQuery != null ? orgTreeQuery.getShowType() : null,
                all = orgTreeQuery != null ? orgTreeQuery.getAll() : null;
        Long grade = orgTreeQuery != null ? orgTreeQuery.getGrade() : null;
        List<Map<String, Object>> mapList = Lists.newArrayList();
        for (Org e : list) {
            if ((PublicUtil.isEmpty(extId)
                    || PublicUtil.isEmpty(e.getParentIds()) || (PublicUtil.isNotEmpty(extId) && !extId.equals(e.getId()) && e.getParentIds() != null && e.getParentIds().indexOf("," + extId + ",") == -1))
                    && (PublicUtil.isEmpty(showType)
                    || (PublicUtil.isNotEmpty(showType) && (showType.equals("1") ? showType.equals(e.getType()) : true)))
                    && (PublicUtil.isEmpty(grade) || (PublicUtil.isNotEmpty(grade) && Integer.parseInt(e.getGrade()) <= grade.intValue()))
                    && (all != null || (all == null && BaseEntity.FLAG_NORMAL.equals(e.getStatus())))) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", e.getId());
                map.put("pId", e.getParentId());
                map.put("name", e.getName());
                map.put("pIds", e.getParentIds());
                map.put("org", e);
                if ("3".equals(showType)) {
                    map.put("isParent", true);
                    e.getUsers().forEach(user -> {
                        Map<String, Object> userMap = Maps.newHashMap();
                        userMap.put("id", user.getId());
                        userMap.put("pId", e.getId());
                        userMap.put("name", user.getName());
                        userMap.put("iconCls", "fa fa-user");
                        mapList.add(userMap);
                    });
                }
                mapList.add(map);
            }
        }
        return mapList;

    }

    //	@Transactional(readOnly = true)
//	public Page<Org> findAll(PageModel<Org> pm) {
//		SpecificationDetail<Org> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
//				QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
//		return repository.findAll(spec, pm);
//	}
    @Transactional(readOnly = true)
    public List<Org> findAllByParentId(String parentId) {
        return repository.findAllByParentIdAndStatusNot(parentId, Org.FLAG_DELETE);
    }

    public List<Org> findAllList(boolean admin, List<QueryCondition> authQueryList) {
        SpecificationDetail<Org> spd = new SpecificationDetail<Org>()
                .and(QueryCondition.ne(Org.F_STATUS, Org.FLAG_DELETE));
        if (!admin) {
            spd.orAll(authQueryList);
        }
        spd.orderASC(Org.F_SORT);
        return findAll(spd);
    }

    @Transactional(readOnly = true)
    public PageModel<Org> findPage(PageModel<Org> pm, List<QueryCondition> queryConditions) {
        return findPageQuery(pm, queryConditions, false);
    }

    public void save(OrgForm orgForm) {
        Org org = PublicUtil.isNotEmpty(orgForm.getId()) ? repository.findOneById(orgForm.getId()) :
                new Org();
        copyFormToBean(orgForm, org);
        org = super.save(org);
    }


}
