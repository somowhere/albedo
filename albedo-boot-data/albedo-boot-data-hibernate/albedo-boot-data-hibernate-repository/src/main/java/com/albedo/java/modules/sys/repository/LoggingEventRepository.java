/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.LoggingEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
 * 操作日志Repository 操作日志
 *
 * @author admin
 * @version 2017-01-03
 */
public interface LoggingEventRepository extends JpaRepository<LoggingEvent, String>, JpaSpecificationExecutor<LoggingEvent> {

    Optional<LoggingEvent> findOneById(String id);
}