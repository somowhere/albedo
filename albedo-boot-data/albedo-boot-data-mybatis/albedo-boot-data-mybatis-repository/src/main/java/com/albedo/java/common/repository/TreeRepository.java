/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.common.repository;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;

import java.io.Serializable;
import java.util.List;

/**
 * TreeRepository
 * @author admin
 * @version 2017-01-01
 */
public interface TreeRepository<T extends BaseEntity, PK extends Serializable> extends BaseRepository<T, PK> {

	Long countByParentId(String parentId);
	
	List<T> findAllByParentIdsLike(String parentIds);

	List<T> findAllByParentIdAndStatusNot(String parentId, Integer status);
	
	List<T> findAllByStatusNot(Integer status);
	
	T findTopByParentIdAndStatusNotOrderBySortDesc(String parentId, Integer status);

	T findOneByIdOrParentIdsLike(PK id, String likeParentIds);


}