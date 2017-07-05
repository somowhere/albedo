package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Org;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface OrgRepository extends TreeRepository<Org, String> {

    List<Org> findFirstByParentIdsLike(String parentIds);

    Optional<Org> findOneByName(String name);
}
