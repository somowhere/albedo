package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.GenScheme;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenSchemeRepository extends BaseRepository<GenScheme, String> {

    List<GenScheme> findAllByStatusAndId(Integer status, String id);
}
