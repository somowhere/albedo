/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.service;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.common.domain.base.DataEntity;
import com.albedo.java.util.BeanVoUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.vo.base.DataEntityVo;
import lombok.Data;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * Service基类
 *
 * @author lj
 * @version 2014-05-16
 */
@Data
public abstract class DataVoService<Repository extends BaseRepository<T, PK>,
        T extends DataEntity, PK extends Serializable, V extends DataEntityVo>
        extends DataService<Repository, T, PK> {

    private Class<V> entityVoClz;

    public DataVoService() {
        super();
        Class<?> c = getClass();
        Type type = c.getGenericSuperclass();
        if (type instanceof ParameterizedType) {
            Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
            entityVoClz = (Class<V>) parameterizedType[3];
        }
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public V findOneVo(PK id) {
        return copyBeanToVo(findOne(id));
    }

    public boolean doCheckByProperty(V entityForm) {
        T entity = copyVoToBean(entityForm);
        return super.doCheckByProperty(entity);
    }

    public boolean doCheckByPK(V entityForm) {
        T entity = copyVoToBean(entityForm);
        return super.doCheckByPK(entity);
    }

    public void copyBeanToVo(T module, V result) {
        if (result != null && module != null) {
            BeanVoUtil.copyProperties(module, result, true);
        }
    }

    public V copyBeanToVo(T module) {
        V result = null;
        if (module != null) {
            try {
                result = entityVoClz.newInstance();
                copyBeanToVo(module, result);
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        return result;
    }

    public void copyVoToBean(V form, T entity) {
        if (form != null && entity != null) {
            BeanVoUtil.copyProperties(form, entity, true);
        }
    }

    public T copyVoToBean(V form) {
        T result = null;
        if (form != null && getPersistentClass() != null) {
            try {
                result = getPersistentClass().newInstance();
                copyVoToBean(form, result);
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        return result;
    }


    public void save(V form) {
        T entity = null;
        try {
            entity = PublicUtil.isNotEmpty(form.getId()) ? repository.findOne((PK) form.getId()) :
                    getPersistentClass().newInstance();
            copyVoToBean(form, entity);
        } catch (Exception e) {
            log.warn("{}", e);
        }
        save(entity);
    }

}
