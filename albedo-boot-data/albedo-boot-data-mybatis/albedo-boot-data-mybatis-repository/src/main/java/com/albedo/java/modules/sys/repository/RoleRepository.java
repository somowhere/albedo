package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.Role;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.repository.query.Param;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface RoleRepository extends BaseRepository<Role, String> {

    @Query
    void deleteRoleOrgs(@Param("role") Role role);

    @Query
    void addRoleOrgs(@Param("role") Role role);

    @Query
    void deleteRoleModules(@Param("role") Role role);

    @Query
    void addRoleModules(@Param("role") Role role);

}
