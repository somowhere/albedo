/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.data.persistence.service.BaseService;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * sessions Service
 *
 * @author admin
 * @version 2017-01-03
 */
@Service
@Transactional
public class PersistentTokenService extends BaseService<PersistentTokenRepository, PersistentToken, String> {
    public final Logger log = LoggerFactory.getLogger(getClass());


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<PersistentToken> findPage(PageModel<PersistentToken> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<PersistentToken> spec = DynamicSpecifications
                .buildSpecification(pm.getQueryConditionJson(), queryConditions, getPersistentClass());
        return findPage(pm, spec);
    }

    public void delete(List<String> ids) {
        ids.forEach(id -> {
//			PersistentToken entity =  repository.findOne(id);
//			Assert.assertNotNull(entity,"对象 " + id + " 信息为空，删除失败" );
//			deleteById(id, currentAuditor);
            repository.delete(id);
//			log.debug("Deleted Entity: {}", entity);
        });
    }

}