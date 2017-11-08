package com.albedo.java.common.service;

import com.albedo.java.common.data.persistence.repository.TreeRepository;
import com.albedo.java.common.domain.base.TreeEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.vo.base.TreeEntityVo;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;


@Data
public class TreeVoService<Repository extends TreeRepository<T, PK>,
        T extends TreeEntity, PK extends Serializable, V extends TreeEntityVo>
        extends TreeService<Repository, T, PK> {

    private Class<V> entityVoClz;

    public TreeVoService() {
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
        if(result!=null && module!=null){
            BeanUtils.copyProperties(module, result);
            if (module.getParent() != null){
                result.setParentName(module.getParent().getName());
            }
        }
    }

    public V copyBeanToVo(T module) {
        V result = null;
        if(module !=null){
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
        if(form!=null && entity!=null){
            BeanUtils.copyProperties(form, entity);
        }
    }
    public T copyVoToBean(V form) {
        T result = null;
        if(form !=null && getPersistentClass() != null){
            try {
                result = getPersistentClass().newInstance();
                copyVoToBean(form, result);
            } catch (Exception e) {
                log.error("{}", e);
            }
        }
        return result;
    }


    public V save(V form) {
        T entity = null;
        try {
            entity = PublicUtil.isNotEmpty(form.getId()) ? repository.findOneById((PK) form.getId()) :
                    getPersistentClass().newInstance();
            copyVoToBean(form, entity);
        } catch (Exception e) {
            log.warn("{}", e);
        }
        save(entity);
        form.setId(entity.getId());
        return form;
    }


}
