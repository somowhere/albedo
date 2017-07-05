package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.Role;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface RoleRepository extends BaseRepository<Role, String> {

}
