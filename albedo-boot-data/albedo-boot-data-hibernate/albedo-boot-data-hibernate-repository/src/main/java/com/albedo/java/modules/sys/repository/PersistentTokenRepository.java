package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the PersistentToken entity.
 */
public interface PersistentTokenRepository extends JpaRepository<PersistentToken, String>, JpaSpecificationExecutor<PersistentToken> {

    List<PersistentToken> findByUser(User user);

    List<PersistentToken> findByTokenDateBefore(LocalDate localDate);

    Optional<PersistentToken> findOneById(String id);

    PersistentToken findOneBySeries(String presentedSeries);

    List<PersistentToken> findAllByUserId(String id);
}
