/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.data.persistence.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.GeneralEntity;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.common.data.persistence.repository.JpaCustomeRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.QueryUtil;
import com.albedo.java.util.base.Assert;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Order;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Service基类
 *
 * @author ThinkGem
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
public abstract class BaseService<Repository extends BaseRepository<T, pk>,
        T extends GeneralEntity, pk extends Serializable> {
    public final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(getClass());
    @Autowired
    public Repository repository;
    @Autowired
    JpaCustomeRepository<T> jpaCustomeRepository;
    private Class<T> persistentClass;

    @SuppressWarnings("unchecked")
    public BaseService() {
        Class<?> c = getClass();
        Type type = c.getGenericSuperclass();
        if (type instanceof ParameterizedType) {
            Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
            persistentClass = (Class<T>) parameterizedType[1];
        }

    }

    public Class<T> getPersistentClass() {
        return persistentClass;
    }

    public boolean doCheckWithEntity(T entity, Map<String, QueryCondition.Operator> maps) {
        boolean rs = false;
        if (PublicUtil.isNotEmpty(entity)) {
            Map<String, Object> paramsMap = Maps.newHashMap();
            List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps, persistentClass);
            String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(conditionList,
                    null,
                    paramsMap, true, true);
            paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
            Long obj = countBasicAll(paramsMap);
            if (obj == null || obj == 0) {
                rs = true;
            }
        }
        return rs;
    }

    public boolean doCheckByProperty(T entity) {
        Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
        try {
            maps.put(BaseEntity.F_ID, QueryCondition.Operator.ne);
            maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
            Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
        } catch (Exception e) {
            log.error(e.toString());
        }
        return doCheckWithEntity(entity, maps);

    }

    public boolean doCheckByPK(T entity) {
        Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
        try {
            maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
            Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
        } catch (Exception e) {
            log.error(e.toString());
        }
        return doCheckWithEntity(entity, maps);
    }

    public Iterable<T> save(Iterable<T> entitys) {
        entitys.forEach(item -> save(item));
        return entitys;
    }

    public Iterable<T> saveIgnoreNull(Iterable<T> entitys) {
        entitys.forEach(item -> saveIgnoreNull(item));
        return entitys;
    }

    //	public void checkSave(T entity){
//		if(entity.isNew()){
//			entity.preInssert();
//		}else{
//			entity.preUpdate();
//		}
//	}
    public T saveIgnoreNull(T entity) {
//		checkSave(entity);
        entity = repository.saveIgnoreNull(entity);
        log.debug("Save Information for Entity: {}", entity);
        return entity;
    }

    public T save(T entity) {
//		checkSave(entity);
        entity = repository.save(entity);
        log.debug("Save Information for Entity: {}", entity);
        return entity;
    }


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findOne(pk id) {
        return repository.findOne(id);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Optional<T> findOneById(pk id) {
        return repository.findOneById(id);
    }


    public T findOne(Map<String, Object> paramsMap, String... columns) {
        paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
        return repository.findOne(false, paramsMap, columns);
    }

    public List<T> findAll(Map<String, Object> paramsMap, String... columns) {
        paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
        return repository.findAll(false, paramsMap, columns);
    }

    public List<T> findAll(Sort sort, Map<String, Object> paramsMap, String... columns) {
        paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
        return repository.findAll(false, sort, paramsMap, columns);
    }

    public Page<T> findAll(Pageable pageable, Map<String, Object> paramsMap, String... columns) {
        paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
        return repository.findAll(false, pageable, paramsMap, columns);

    }

    public Long countBasicAll(Map<String, Object> paramsMap) {
        paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
        return repository.countAll(false, paramsMap);
    }

    public List<Sort.Order> toOrders(List<Order> orders) {
        List<Sort.Order> orderList = Lists.newArrayList();
        if (PublicUtil.isEmpty(orders)) {
            return orderList;
        }
        for (com.albedo.java.util.domain.Order order : orders) {
            if (order == null) {
                continue;
            }
            String property = order.getProperty();
            com.albedo.java.util.domain.Order.Direction direction = order.getDirection();
            if (PublicUtil.isEmpty(property) || direction == null) {
                continue;
            }
            orderList.add(new Sort.Order(direction.equals(Order.Direction.asc) ?
                    Sort.Direction.ASC : Sort.Direction.DESC, property));
        }
        return orderList;
    }


    /**
     * 动态集合查询
     *
     * @param specificationDetail 动态条件对象
     * @return
     */
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<T> findAll(SpecificationDetail specificationDetail) {
        try {
            Map<String, Object> paramsMap = Maps.newHashMap();
            specificationDetail.setPersistentClass(persistentClass);
            String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(specificationDetail.getAndQueryConditions(),
                    specificationDetail.getOrQueryConditions(),
                    Lists.newArrayList(DynamicSpecifications.MYBITS_SEARCH_PARAMS_MAP),
                    paramsMap, true);
            paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
            paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());

            return PublicUtil.isNotEmpty(specificationDetail.getOrders()) ?
                    repository.findAll(false, new Sort(toOrders(specificationDetail.getOrders())), paramsMap) :
                    repository.findAll(false, paramsMap);
        } catch (Exception e) {
            log.error(e.getMessage());
            Assert.buildException(e.getMessage());
        }
        return null;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasePage(PageModel<T> pm, SpecificationDetail<T> specificationDetail, boolean isBasic) {
        return findBasePage(pm, specificationDetail, isBasic, null, null);
    }


    /**
     * 动态分页查询(自定义)
     *
     * @param pm                  分页对象
     * @param specificationDetail 动态条件对象
     * @param selectStatement     自定义数据集合sql名称
     * @param countStatement      自定义数据总数sql名称
     * @return
     */
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasePage(PageModel<T> pm, SpecificationDetail<T> specificationDetail, String selectStatement, String countStatement) {
        return findBasePage(pm, specificationDetail, null, selectStatement, countStatement);
    }

    /**
     * 动态分页查询
     *
     * @param pm                  分页对象
     * @param specificationDetail 动态条件对象
     * @param isBasic             是否关联对象查询
     * @return
     */
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasePage(PageModel<T> pm, SpecificationDetail<T> specificationDetail, Boolean isBasic) {
        return findBasePage(pm, specificationDetail, isBasic, null, null);
    }

    /**
     * 动态分页查询
     *
     * @param pm                  分页对象
     * @param specificationDetail 动态条件对象
     * @param isBasic             是否关联对象查询
     * @param selectStatement     自定义数据集合sql名称
     * @param countStatement      自定义数据总数sql名称
     * @return
     */
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findBasePage(PageModel<T> pm, SpecificationDetail<T> specificationDetail, Boolean isBasic, String selectStatement, String countStatement) {
        try {
            Map<String, Object> paramsMap = Maps.newHashMap();
            specificationDetail.setPersistentClass(persistentClass);
            String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(
                    specificationDetail.getAndQueryConditions(),
                    specificationDetail.getOrQueryConditions(),
                    null,
                    paramsMap, true);
            paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
            paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_CONDITION, new Object());
            pm.setPageInstance(PublicUtil.isNotEmpty(selectStatement) && PublicUtil.isNotEmpty(countStatement) ?
                    repository.findAll(selectStatement, countStatement, pm, paramsMap) : repository.findAll(isBasic, pm, paramsMap));
            return pm;
        } catch (Exception e) {
            log.error("error: {}", e);
            Assert.buildException(e.getMessage());
        }
        return null;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public PageModel<T> findPage(PageModel<T> pm, SpecificationDetail<T> specificationDetail) {
        return findBasePage(pm, specificationDetail, true);
    }

}
