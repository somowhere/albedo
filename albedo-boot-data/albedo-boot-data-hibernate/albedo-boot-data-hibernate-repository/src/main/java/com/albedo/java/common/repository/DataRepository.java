/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.common.repository;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.TreeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;

/**
 * TreeRepository
 * @author admin
 * @version 2017-01-01
 */
public interface DataRepository<T extends BaseEntity, PK extends Serializable> extends JpaRepository<T, PK>, JpaSpecificationExecutor<T> {

    T findOneById(String id);
}