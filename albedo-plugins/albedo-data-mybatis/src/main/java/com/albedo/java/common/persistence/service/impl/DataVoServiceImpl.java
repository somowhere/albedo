/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.BeanVoUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.common.persistence.service.DataVoService;
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
public abstract class DataVoServiceImpl<Repository extends BaseRepository<T>,
	T extends DataEntity, PK extends Serializable, V extends DataEntityVo>
	extends DataServiceImpl<Repository, T, PK> implements DataVoService<Repository, T, PK, V> {

	private Class<V> entityVoClz;

	public DataVoServiceImpl() {
		super();
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			entityVoClz = (Class<V>) parameterizedType[3];
		}
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public V findOneVo(PK id) {
		return copyBeanToVo(findRelationOne(id));
	}

	@Override
	public boolean doCheckByProperty(V entityForm) {
		T entity = copyVoToBean(entityForm);
		return super.doCheckByProperty(entity);
	}

	@Override
	public boolean doCheckByPK(V entityForm) {
		T entity = copyVoToBean(entityForm);
		return super.doCheckByPK(entity);
	}

	@Override
	public void copyBeanToVo(T module, V result) {
		if (result != null && module != null) {
			BeanVoUtil.copyProperties(module, result, true);
			if (ObjectUtil.isNotEmpty(module.pkVal())) {
				result.setId(module.pkVal());
			}
		}
	}

	@Override
	public V copyBeanToVo(T module) {
		V result = null;
		if (module != null) {
			try {
				result = entityVoClz.newInstance();
				copyBeanToVo(module, result);
				if (ObjectUtil.isNotEmpty(module.pkVal())) {
					result.setId(module.pkVal());
				}
			} catch (Exception e) {
				log.error("{}", e);
			}
		}
		return result;
	}

	@Override
	public void copyVoToBean(V form, T entity) {
		if (form != null && entity != null) {
			BeanVoUtil.copyProperties(form, entity, true);
			if (ObjectUtil.isNotEmpty(form.getId())) {
				entity.setPk(form.getId());
			}
		}
	}

	@Override
	public T copyVoToBean(V form) {
		T result = null;
		if (form != null && getPersistentClass() != null) {
			try {
				result = getPersistentClass().newInstance();
				copyVoToBean(form, result);
				if (ObjectUtil.isNotEmpty(form.getId())) {
					result.setPk(form.getId());
				}
			} catch (Exception e) {
				log.error("{}", e);
			}
		}
		return result;
	}


	@Override
	public void save(V form) {
		T entity = null;
		try {
			entity = ObjectUtil.isNotEmpty(form.getId()) ? repository.selectById(form.getId()) :
				getPersistentClass().newInstance();
			copyVoToBean(form, entity);
		} catch (Exception e) {
			log.warn("{}", e);
		}
		saveOrUpdate(entity);
		form.setId(entity.pkVal());
	}

}
