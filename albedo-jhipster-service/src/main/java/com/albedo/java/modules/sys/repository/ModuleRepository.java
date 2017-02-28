package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.Module;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface ModuleRepository extends JpaRepository<Module, String>, JpaSpecificationExecutor<Module> {

	List<Module> findByStatusOrderBySort(Integer flagNormal);
	
	Optional<Module> findOneById(String id);

	List<Module> findFirstByParentIdsLike(String appendStr);

	Module findFirstByParentIdAndStatusNot(String id, Integer flagDelete);
	
	@Query("from Module where status=?1 order by sort")
	List<Module> findAllAuthenticationList(Integer flagNormal);
	
	@Query("from Module where parentId=?1 order by sort")
	Module findFirstByParentId(String parentId);

	List<Module> findAllByParentIdAndStatusNot(String parentId, Integer flagDelete);
	
}
