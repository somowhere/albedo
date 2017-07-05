package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.PersistentToken;

import java.time.LocalDate;
import java.util.List;

/**
 * Spring Data JPA repository for the PersistentToken entity.
 */
public interface PersistentTokenRepository extends BaseRepository<PersistentToken, String> {

    List<PersistentToken> findByTokenDateBefore(LocalDate localDate);

    PersistentToken findOneBySeries(String presentedSeries);

    List<PersistentToken> findAllByUserId(String userId);
}
