package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.Module;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface ModuleRepository extends TreeRepository<Module> {

	List<Module> findAllByStatusOrderBySort(Integer flagNormal);
	Module findOneByParentIdOrderBySort(Integer parentId);
	
	Optional<Module> findOneById(String id);

	Module findFirstByParentIdAndStatusNot(String id, Integer flagDelete);

}
