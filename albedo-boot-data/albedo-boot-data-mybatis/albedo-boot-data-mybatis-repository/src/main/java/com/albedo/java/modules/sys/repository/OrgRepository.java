package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Org;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface OrgRepository extends TreeRepository<Org, String> {

    List<Org> findFirstByParentIdsLike(String parentIds);

}
