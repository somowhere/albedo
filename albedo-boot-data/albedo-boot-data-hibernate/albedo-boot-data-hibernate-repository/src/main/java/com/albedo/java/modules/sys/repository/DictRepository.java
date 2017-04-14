package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Area;
import com.albedo.java.modules.sys.domain.Dict;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface DictRepository extends TreeRepository<Dict> {
	
	List<Dict> findAllByStatusNotAndIsShowOrderBySortAsc(Integer status, Integer isShow);

}
