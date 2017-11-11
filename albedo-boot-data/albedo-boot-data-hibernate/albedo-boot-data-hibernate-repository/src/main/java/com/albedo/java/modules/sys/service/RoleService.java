package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.common.service.DataVoService;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.vo.sys.RoleVo;
import org.springframework.beans.BeanUtils;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

/**
 * Service class for managing roles.
 */
@Service
@Transactional
public class RoleService extends DataVoService<RoleRepository, Role, String, RoleVo> {


    @Override
    public RoleVo copyBeanToVo(Role role) {
        RoleVo userResult = new RoleVo();
        BeanUtils.copyProperties(role, userResult);
        if (role.getOrg() != null) {
            userResult.setOrgName(role.getOrg().getName());
        }
        return userResult;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<Role> findAll(PageModel<Role> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<Role> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), queryConditions,
                QueryCondition.ne(Role.F_STATUS, Role.FLAG_DELETE));
        return repository.findAll(spec, pm);
    }

    public List<Role> findAllList(boolean admin, Collection<QueryCondition> authQueryList) {

        SpecificationDetail<Role> spd = new SpecificationDetail<Role>()
                .and(QueryCondition.eq(Role.F_STATUS, Role.FLAG_NORMAL));
        if (admin) {
            spd.orAll(authQueryList);
        }
        spd.orderASC(Role.F_SORT);
        return repository.findAll(spd);
    }
}
