package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.hibernate.persistence.DynamicSpecifications;
import com.albedo.java.common.data.hibernate.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing roles.
 */
@Service
@Transactional
public class RoleService extends DataService<RoleRepository, Role, String> {

    @Transactional(readOnly = true)
    public Page<Role> findAll(PageModel<Role> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<Role> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), queryConditions,
                QueryCondition.ne(Role.F_STATUS, Role.FLAG_DELETE));
        return repository.findAll(spec, pm);
    }

}
