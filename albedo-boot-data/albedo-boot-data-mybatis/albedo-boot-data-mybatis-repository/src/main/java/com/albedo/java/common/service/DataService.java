/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.albedo.java.common.service;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.data.mybatis.persistence.SpecificationDetail;
import com.albedo.java.common.data.mybatis.persistence.repository.BaseRepository;
import com.albedo.java.common.data.mybatis.persistence.service.BaseService;
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
 * @author lj
 * @version 2014-05-16
 */
@Transactional
public abstract class DataService<Repository extends BaseRepository<T, PK>, T extends DataEntity, PK extends Serializable>
		extends BaseService<Repository, T, PK> {
	
	/**
	 * 逻辑删除
	 *
	 * @param id
	 * @return
	 */
	public void deleteById(PK id, String lastModifiedBy) {
		operateStatusById(id, BaseEntity.FLAG_DELETE, lastModifiedBy);
	}

	public void operateStatusById(PK id, Integer status, String lastModifiedBy) {
		T entity = repository.findOne(id);
		Assert.assertNotNull(entity, "无法查询到对象信息");
		entity.setStatus(status);
		entity.setLastModifiedBy(lastModifiedBy);
		entity.setLastModifiedDate(PublicUtil.getCurrentDate());
		repository.updateIgnoreNull(entity);
	}

	/**
	 * 逻辑删除 集合
	 *
	 * @param idList
	 * @return
	 */
	public void deleteById(List<PK> idList, String lastModifiedBy) {
		for (PK id : idList) {
			deleteById(id, lastModifiedBy);
		}
	}

	public void delete(List<PK> ids, String currentAuditor) {
		ids.forEach(id ->{
			T entity =  repository.findOne(id);
			Assert.assertNotNull(entity,"对象 " + id + " 信息为空，删除失败" );
			deleteById(id, currentAuditor);
			log.debug("Deleted Entity: {}", entity);
		});
	}

	public void lockOrUnLock(List<PK> ids, String currentAuditor) {
		ids.forEach(id ->{
			T entity =  repository.findOne(id);
			Assert.assertNotNull(entity,"对象 " + id + " 信息为空，操作失败" );
			operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(entity.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL,
					currentAuditor);
			log.debug("LockOrUnLock Entity: {}", entity);

		});
	}
	@Transactional(readOnly=true)
	public PageModel<T> findPage(PageModel<T> pm) {
		return findPage(pm, null);
	}
	@Transactional(readOnly=true)
	public PageModel<T> findPage(PageModel<T> pm, List<QueryCondition> queryConditions) {
		SpecificationDetail specificationDetail = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				queryConditions,
				QueryCondition.ne(BaseEntity.F_STATUS, BaseEntity.FLAG_DELETE));
		return findBasePage(pm, specificationDetail);
	}


}
