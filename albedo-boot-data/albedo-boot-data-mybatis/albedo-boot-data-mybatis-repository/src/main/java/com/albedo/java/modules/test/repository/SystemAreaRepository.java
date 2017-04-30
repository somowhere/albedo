/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.test.repository;


import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;

import com.albedo.java.modules.test.domain.SystemArea;

import java.util.List;

/**
 * 区域管理Repository 区域管理
 * @author admin
 * @version 2017-04-24
 */
public interface SystemAreaRepository extends BaseRepository<SystemArea, Long> {


    Long countByParentId(Long id);

    List<SystemArea> findAllByParentIdsLike(String s);

    SystemArea findOneByCode(String parentCode);

    List<SystemArea> findTop1ByParentIdAndStatusNotOrderBySortDesc(Long parentId, Integer flagDelete);

    SystemArea findOneByCodeLike(String parentCode);

    SystemArea findBasicOneByCodeLike(String parentCode);
}