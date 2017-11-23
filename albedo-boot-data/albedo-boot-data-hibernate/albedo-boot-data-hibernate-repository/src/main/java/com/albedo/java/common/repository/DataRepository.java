/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.common.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.common.domain.base.BaseEntity;

import java.io.Serializable;
import java.util.Optional;

/**
 * TreeRepository
 *
 * @author admin
 * @version 2017-01-01
 */
public interface DataRepository<T extends BaseEntity, PK extends Serializable> extends BaseRepository<T, PK> {

    Optional<T> findOneById(String id);
}