package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.data.mybatis.persistence.annotation.MyBatisRepository;
import com.albedo.java.modules.gen.domain.GenScheme;
import org.springframework.data.mybatis.repository.support.MybatisRepository;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenSchemeRepository extends MybatisRepository<GenScheme, String> {

}
