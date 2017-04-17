package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.domain.User;
import org.springframework.data.mybatis.repository.support.MybatisRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the PersistentToken entity.
 */
public interface PersistentTokenRepository extends BaseRepository<PersistentToken, String> {

    List<PersistentToken> findByUser(User user);

    List<PersistentToken> findByTokenDateBefore(LocalDate localDate);

	PersistentToken findOneBySeries(String presentedSeries);

}
