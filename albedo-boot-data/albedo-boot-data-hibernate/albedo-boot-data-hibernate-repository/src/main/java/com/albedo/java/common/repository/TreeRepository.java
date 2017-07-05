/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.common.repository;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.TreeEntity;

import java.io.Serializable;
import java.util.List;

/**
 * TreeRepository
 *
 * @author admin
 * @version 2017-01-01
 */
public interface TreeRepository<T extends BaseEntity, PK extends Serializable> extends DataRepository<T, PK> {

    T findFirstByParentId(String parentId);

    List<T> findAllByParentIdsLike(String parentIds);

    List<T> findAllByParentIdAndStatusNot(String parentId, Integer status);

    List<T> findAllByStatusNot(Integer status);

    <T extends TreeEntity<T>> T findTopByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status);

    <T extends TreeEntity<T>> List<T> findTop1ByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer flagDelete);

    Long countByParentIdAndStatusNot(String parentId, Integer flagDelete);
}