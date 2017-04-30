/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.test.repository;


import com.albedo.java.common.repository.DataRepository;
import com.albedo.java.modules.test.domain.SystemArea;

import java.util.List;

/**
 * 区域管理Repository 区域管理
 * @author admin
 * @version 2017-04-24
 */
public interface SystemAreaRepository extends DataRepository<SystemArea, Long> {


    Long countByParentId(Long id);

    List<SystemArea> findAllByParentIdsLike(String s);

    SystemArea findByCode(String parentCode);

    List<SystemArea> findTop1ByParentIdAndStatusNotOrderBySortDesc(Long parentId, Integer flagDelete);

    SystemArea findOneByCodeLike(String parentCode);

    SystemArea findBasicOneByCodeLike(String parentCode);

    SystemArea findByName(String s);

    SystemArea findByNameLike(String 北京);

    SystemArea findByCodeLike(String s);

    SystemArea findByParentId(long i);

    SystemArea findByParentIds(String s);
}