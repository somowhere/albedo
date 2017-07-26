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
import com.albedo.java.vo.sys.RoleForm;
import com.albedo.java.vo.sys.RoleResult;
import org.springframework.beans.BeanUtils;
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


    public RoleResult copyBeanToResult(Role role) {
        RoleResult userResult = new RoleResult();
        BeanUtils.copyProperties(role, userResult);
        if (role.getOrg() != null) userResult.setOrgName(role.getOrg().getName());
        return userResult;
    }

    public RoleForm copyBeanToForm(Role user) {
        RoleForm userForm = new RoleForm();
        BeanUtils.copyProperties(user, userForm);
        return userForm;
    }


    public Role copyFormToBean(RoleForm userForm, Role user) {
        BeanUtils.copyProperties(userForm, user);
        return user;
    }

    @Transactional(readOnly = true)
    public PageModel<Role> findPage(PageModel<Role> pm, List<QueryCondition> authQueryConditions) {
        SpecificationDetail<Role> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                 persistentClass,
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
        spec.orAll(authQueryConditions);
//		specificationDetail.setPersistentClass();
//        findBasePage(pm, spec, true);
//        pm.getData().forEach(item -> item.setOrg(orgRepository.findBasicOne(item.getOrgId())));
        findBasePage(pm, spec, true, "selectPage", "countPage");
        return pm;
    }

    public List<Role> findAllList(boolean admin, List<QueryCondition> authQueryList) {
        SpecificationDetail<Role> spd = new SpecificationDetail<Role>()
                .and(QueryCondition.eq(Role.F_STATUS, Role.FLAG_NORMAL));
        if (!admin) {
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
