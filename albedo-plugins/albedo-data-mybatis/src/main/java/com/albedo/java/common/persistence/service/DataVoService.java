package com.albedo.java.common.persistence.service;

import com.albedo.java.common.core.vo.DataEntityVo;
import com.albedo.java.common.persistence.domain.DataEntity;
import com.albedo.java.common.persistence.repository.BaseRepository;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

public interface DataVoService<Repository extends BaseRepository<T>,
	T extends DataEntity, PK extends Serializable, D extends DataEntityVo> extends IService<T>,
	BaseService<Repository, T, PK>, DataService<Repository, T, PK> {
	@Transactional(readOnly = true, rollbackFor = Exception.class)
	D findOneVo(PK id);

	boolean doCheckByProperty(D entityForm);

	boolean doCheckByPK(D entityForm);

	void copyBeanToVo(T module, D result);

	D copyBeanToVo(T module);

	void copyVoToBean(D form, T entity);

	T copyVoToBean(D form);

	void save(D form);
}
