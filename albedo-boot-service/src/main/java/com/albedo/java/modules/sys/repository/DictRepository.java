package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.Dict;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface DictRepository extends JpaRepository<Dict, String>, JpaSpecificationExecutor<Dict>  {
	
	List<Dict> findAllByStatusNotAndIsShowOrderBySortAsc(Integer status, Integer isShow);

	Optional<Dict> findOneById(String id);

	Dict findFirstByParentId(String id);
	
	List<Dict> findAllByParentIdsLike(String appendStr);

	List<Dict> findAllByParentIdAndStatusNot(String parentId, Integer status);

	Dict findTopByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer flagDelete);
	
}
