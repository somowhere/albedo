package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.GenTableColumn;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenTableColumnRepository extends BaseRepository<GenTableColumn, String> {

    GenTableColumn findOneByGenTableId(String id);

    List<GenTableColumn> findAllByGenTableIdOrderBySort(String id);
}
