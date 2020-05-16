package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.common.persistence.domain.DataEntity;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

public interface DataService<
	T extends DataEntity, D extends DataDto, PK extends Serializable> extends BaseService<T> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	D getOneDto(PK id);

	void saveOrUpdate(D form);

	void copyBeanToDto(T module, D result);

	D copyBeanToDto(T module);

	void copyDtoToBean(D form, T entity);

	T copyDtoToBean(D form);
}
