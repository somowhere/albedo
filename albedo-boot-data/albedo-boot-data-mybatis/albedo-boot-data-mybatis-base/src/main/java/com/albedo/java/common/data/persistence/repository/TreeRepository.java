/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.common.data.persistence.repository;

import com.albedo.java.common.data.persistence.BaseEntity;

import java.io.Serializable;
import java.util.List;

/**
 * TreeRepository
 *
 * @author admin
 * @version 2017-01-01
 */
public interface TreeRepository<T extends BaseEntity, PK extends Serializable> extends BaseRepository<T, PK> {

    Long countByParentId(String parentId);

    Long countByParentIdAndStatusNot(String parentId, Integer status);

    List<T> findAllByParentIdsLike(String parentIds);

    List<T> findAllByParentIdAndStatusNot(String parentId, Integer status);

    List<T> findAllByStatusNot(Integer status);

    List<T> findTop1ByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status);

    List<T> findAllByIdOrParentIdsLike(PK id, String likeParentIds);


}