/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.repository.PersistentTokenRepository;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * sessions Service
 *
 * @author admin
 * @version 2017-01-03
 */
@Service
@Transactional
public class PersistentTokenService {
    public final Logger log = LoggerFactory.getLogger(getClass());
    @Resource
    private PersistentTokenRepository persistentTokenRepository;

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PersistentToken findOne(String id) {
        return persistentTokenRepository.findOne(id);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<PersistentToken> findPage(PageModel<PersistentToken> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<PersistentToken> spec = DynamicSpecifications
                .buildSpecification(pm.getQueryConditionJson(), queryConditions);
        return persistentTokenRepository.findAll(spec, pm);
    }

    public void delete(List<String> ids) {
        ids.forEach(id -> {
            persistentTokenRepository.findOneById(id).map(u -> {
                log.debug("Deleted Persistent: {}", u);
                persistentTokenRepository.delete(u);
                return u;
            }).orElseThrow(() -> new RuntimeMsgException("回话  信息为空，删除失败"));
        });
    }
}