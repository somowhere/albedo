package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.repository.DataRepository;
import com.albedo.java.modules.gen.domain.GenScheme;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenSchemeRepository extends DataRepository<GenScheme, String> {

}
