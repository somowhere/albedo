package com.albedo.java.modules.sys.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.sys.domain.User;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * Spring Data JPA repository for the User entity.
 */
public interface UserRepository extends BaseRepository<User, String> {

    Optional<User> findOneByActivationKey(String activationKey);

    List<User> findAllByActivatedIsFalseAndCreatedDateBefore(Date dateTime);

    Optional<User> findOneByResetKey(String resetKey);

    Optional<User> findOneByEmail(String email);

    Optional<User> findOneByLoginId(String loginId);

    @Query
    void deleteUserRoles(@Param("user") User user);

    @Query
    void addUserRoles(@Param("user") User user);


}
