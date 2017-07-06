package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.OrgRepository;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Service class for managing roles.
 */
@Service
@Transactional
public class RoleService extends DataService<RoleRepository, Role, String> {

    @Resource
    OrgRepository orgRepository;

    @Transactional(readOnly = true)
    public PageModel<Role> findPage(PageModel<Role> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<Role> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                queryConditions, persistentClass,
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
//		specificationDetail.setPersistentClass();
//        findBasePage(pm, spec, true);
//        pm.getData().forEach(item -> item.setOrg(orgRepository.findBasicOne(item.getOrgId())));
        findBasePage(pm, spec, true, "selectPage", "countPage");
        return pm;
    }

    public List<Role> findAllList(boolean admin, List<QueryCondition> authQueryList) {
        SpecificationDetail<Role> spd = new SpecificationDetail<Role>()
                .and(QueryCondition.eq(Role.F_STATUS, Role.FLAG_NORMAL));
        if (admin) {
            spd.orAll(authQueryList);
        }
        spd.orderASC(Role.F_SORT);
        return findAll(spd);
    }

    @Override
    public Role save(Role entity) {
        entity = super.save(entity);
        if (PublicUtil.isNotEmpty(entity.getModuleIdList())) {
            repository.deleteRoleModules(entity);
            repository.addRoleModules(entity);
        }

        if (PublicUtil.isNotEmpty(entity.getOrgIdList())) {
            repository.deleteRoleOrgs(entity);
            repository.addRoleOrgs(entity);
        }
        return entity;
    }
}
