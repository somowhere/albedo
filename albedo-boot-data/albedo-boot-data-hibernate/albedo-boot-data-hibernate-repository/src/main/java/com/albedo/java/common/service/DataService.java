package com.albedo.java.common.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.data.persistence.service.BaseService;
import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.common.repository.DataRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Assert;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;
import java.util.Optional;


@Transactional
public class DataService<Repository extends DataRepository<T, PK>, T extends DataEntity, PK extends Serializable> extends
        BaseService<Repository, T, PK> {
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
//        entity.setLastModifiedBy(lastModifiedBy);
//        entity.setLastModifiedDate(PublicUtil.getCurrentDate());
        repository.saveAndFlush(entity);
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
        Assert.assertNotNull(ids, "ids 信息为空，操作失败");
        ids.forEach(id -> {
            T entity = repository.findOne(id);
            Assert.assertNotNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            log.debug("Deleted Entity: {}", entity);
        });
    }

    public void lockOrUnLock(List<PK> ids) {
        Assert.assertNotNull(ids, "ids 信息为空，操作失败");
        ids.forEach(id -> {
            T entity = repository.findOne(id);
            Assert.assertNotNull(entity, "对象 " + id + " 信息为空，操作失败");
            operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(entity.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
            log.debug("LockOrUnLock Entity: {}", entity);

        });
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findOne(PK id) {
        return repository.findOne(id);
    }

    public Optional<T> findOneById(String id){
        return  repository.findOneById(id);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findPage(PageModel<T> pm) {
        return findPage(pm, null);
    }

    public PageModel<T> findPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
        SpecificationDetail<T> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
                QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
        if (PublicUtil.isNotEmpty(queryConditions)) {
            spec.andAll(queryConditions);
        }
        pm.setPageInstance(repository.findAll(spec, pm));
        return pm;
    }

    public boolean doCheckByProperty(T entity) {
        return baseRepository.doCheckByProperty(entity);
    }

    public boolean doCheckByPK(T entity) {
        return baseRepository.doCheckByPK(entity);
    }
}
