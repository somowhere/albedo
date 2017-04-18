package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.data.mybatis.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.repository.RoleRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing roles.
 */
@Service
@Transactional
public class RoleService extends DataService<RoleRepository, Role, String> {

    @Transactional(readOnly=true)
    public PageModel<Role> findPage(PageModel<Role> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<Role> specificationDetail = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                queryConditions, persistentClass,
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
//		specificationDetail.setPersistentClass();
        return findPage(pm, specificationDetail);
    }
}
