package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.TreeRepository;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.domain.User;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface ModuleRepository extends TreeRepository<Module, String> {

    @Query
    List<Module> findAllAuthByUser(@Param("user") User user);

    List<Module> findAllByStatusOrderBySort(Integer flagNormal);

    Module findOneByParentIdOrderBySort(Integer parentId);

    Module findFirstByParentIdAndStatusNot(String id, Integer flagDelete);

    Module findOneByName(String moduleName);

    List<Module> findOneByIdOrParentId(String id, String parentId);

}
