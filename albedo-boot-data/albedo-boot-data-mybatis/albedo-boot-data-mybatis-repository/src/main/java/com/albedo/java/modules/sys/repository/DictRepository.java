package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Dict;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface DictRepository extends TreeRepository<Dict, String> {

    List<Dict> findAllByStatusNotAndIsShowOrderBySortAsc(Integer status, Integer isShow);

}
