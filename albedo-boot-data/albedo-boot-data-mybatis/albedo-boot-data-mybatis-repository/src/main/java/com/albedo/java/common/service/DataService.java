/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.common.data.persistence.service.BaseService;
import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Assert;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

/**
 * Service基类
 *
 * @author lj
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
public abstract class DataService<Repository extends BaseRepository<T, PK>, T extends DataEntity, PK extends Serializable>
        extends BaseService<Repository, T, PK> {

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    @Override
    public T findOne(PK id) {
        return repository.findOne(id);
    }

    /**
     * 逻辑删除
     *
     * @param id
     * @return
     */
    public void deleteById(PK id) {
        operateStatusById(id, BaseEntity.FLAG_DELETE);
    }

    public void operateStatusById(PK id, Integer status) {
        T entity = repository.findOne(id);
        Assert.assertNotNull(entity, "无法查询到对象信息");
        entity.setStatus(status);
//		entity.setLastModifiedBy();
//		entity.setLastModifiedDate(PublicUtil.getCurrentDate());
        repository.updateIgnoreNull(entity);
    }

    /**
     * 逻辑删除 集合
     *
     * @param idList
     * @return
     */
    public void deleteById(List<PK> idList) {
        for (PK id : idList) {
            deleteById(id);
        }
    }

    public void delete(List<PK> ids) {
        ids.forEach(id -> {
            T entity = repository.findOne(id);
            Assert.assertNotNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            log.debug("Deleted Entity: {}", entity);
        });
    }

    public void lockOrUnLock(List<PK> ids) {
        ids.forEach(id -> {
            T entity = repository.findOne(id);
            Assert.assertNotNull(entity, "对象 " + id + " 信息为空，操作失败");
            operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(entity.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
            log.debug("LockOrUnLock Entity: {}", entity);

        });
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findPage(PageModel<T> pm) {
        return findPageQuery(pm, null, false);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasicPage(PageModel<T> pm) {
        return findPageQuery(pm, null, true);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
        return findPageQuery(pm, queryConditions, false);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasicPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
        return findPageQuery(pm, queryConditions, true);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findPageQuery(PageModel<T> pm, List<QueryCondition> authQueryConditions, boolean isBasic) {
        SpecificationDetail<T> specificationDetail = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                getPersistentClass(),
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
        if (PublicUtil.isNotEmpty(authQueryConditions)) {
            specificationDetail.orAll(authQueryConditions);
        }
        return findBasePage(pm, specificationDetail, isBasic);
    }


}
