/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.common.persistence.service.impl;

import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.common.persistence.domain.BaseDataEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.common.persistence.service.DataService;
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
@Transactional(rollbackFor = Exception.class)
@Data
public class DataServiceImpl<Repository extends BaseRepository<T>,
	T extends BaseDataEntity, D extends DataDto, PK extends Serializable>
	extends BaseServiceImpl<Repository, T>
	implements DataService<T, D, PK> {

	private Class<D> entityDtoClz;

	public DataServiceImpl() {
		super();
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			entityDtoClz = (Class<D>) parameterizedType[2];
		}
	}

	@Override
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	public D getOneDto(PK id) {
		return copyBeanToDto(repository.selectById(id));
	}


	@Override
	public void saveOrUpdate(D entityDto) {
		T entity = null;
		try {
			entity = ObjectUtil.isNotEmpty(entityDto.getId()) ? repository.selectById(entityDto.getId()) :
				entityClass.newInstance();
			copyDtoToBean(entityDto, entity);
		} catch (Exception e) {
			log.warn("{}", e);
		}
		saveOrUpdate(entity);
		entityDto.setId(entity.pkVal());
	}

	@Override
	public void copyBeanToDto(T module, D result) {
		if (result != null && module != null) {
			BeanUtil.copyProperties(module, result, true);
			if (ObjectUtil.isNotEmpty(module.pkVal())) {
				result.setId(module.pkVal());
			}
		}
	}

	@Override
	public D copyBeanToDto(T module) {
		D result = null;
		if (module != null && entityDtoClz != null) {
			try {
				result = entityDtoClz.newInstance();
				copyBeanToDto(module, result);
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
	public void copyDtoToBean(D entityDto, T entity) {
		if (entityDto != null && entity != null) {
			BeanUtil.copyProperties(entityDto, entity, true);
			if (ObjectUtil.isNotEmpty(entityDto.getId())) {
				entity.setPk(entityDto.getId());
			}
		}
	}

	@Override
	public T copyDtoToBean(D entityDto) {
		T result = null;
		if (entityDto != null && entityClass != null) {
			try {
				result = entityClass.newInstance();
				copyDtoToBean(entityDto, result);
				if (ObjectUtil.isNotEmpty(entityDto.getId())) {
					result.setPk(entityDto.getId());
				}
			} catch (Exception e) {
				log.error("{}", e);
			}
		}
		return result;
	}


}
