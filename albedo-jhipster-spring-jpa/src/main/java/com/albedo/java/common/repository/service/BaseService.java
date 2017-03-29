package com.albedo.java.common.repository.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.repository.data.JpaCustomeRepository;
import com.albedo.java.util.PublicUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

@Service
@Transactional
public class BaseService<T extends BaseEntity> {
	public final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	public JpaCustomeRepository<T> baseRepository;
	private Class<T> persistentClass;

	@SuppressWarnings("unchecked")
	public BaseService() {
		Class<?> c = getClass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			persistentClass = (Class<T>) parameterizedType[0];
		}
	}

	/**
	 * 逻辑删除
	 * 
	 * @param id
	 * @return
	 */
	public int deleteById(String id, String lastModifiedBy) {
		return operateStatusById(id, BaseEntity.FLAG_DELETE, lastModifiedBy);
	}

	public int operateStatusById(String id, Integer status, String lastModifiedBy) {
		return baseRepository.createQuery(
				PublicUtil.toAppendStr("update ", persistentClass.getSimpleName(), " set status='", status,
						"', lastModifiedBy=:p2, lastModifiedDate=:p3 where id = :p1"),
				id, lastModifiedBy, PublicUtil.getCurrentDate()).executeUpdate();
	}

	/**
	 * 逻辑删除 集合
	 * 
	 * @param idList
	 * @return
	 */
	public void deleteById(List<String> idList, String lastModifiedBy) {
		for (String id : idList) {
			deleteById(id, lastModifiedBy);
		}
	}

	/**
	 * 逻辑删除
	 * 
	 * @param id
	 * @param likeParentIds
	 * @return
	 */
	public int deleteById(String id, String likeParentIds, String lastModifiedBy) {
		return operateStatusById(id, likeParentIds, BaseEntity.FLAG_DELETE, lastModifiedBy);
	}
//SecurityUtil.getCurrentAuditor()
	public int operateStatusById(String id, String likeParentIds, Integer status, String lastModifiedBy) {
		return baseRepository.createQuery(
				PublicUtil.toAppendStr("update ", persistentClass.getSimpleName(), " set status='", status,
						"', lastModifiedBy=:p3, lastModifiedDate=:p4 where id = :p1 or parentIds like :p2"),
				id, likeParentIds, lastModifiedBy, PublicUtil.getCurrentDate()).executeUpdate();
	}

}
