package com.albedo.java.common.data.mybatis.persistence.data.impl;

import com.albedo.java.common.data.mybatis.persistence.BaseEntity;
import com.albedo.java.common.data.mybatis.persistence.DynamicSpecifications;
import com.albedo.java.common.data.mybatis.persistence.GeneralEntity;
import com.albedo.java.common.data.mybatis.persistence.data.JpaCustomeRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.QueryUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;
import com.albedo.java.util.domain.ComboQuery;
import com.albedo.java.util.domain.QueryCondition;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.mybatis.repository.support.SqlSessionRepositorySupport;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@Transactional
public class JpaCustomeRepositoryImpl<T extends GeneralEntity>
		extends SqlSessionRepositorySupport implements JpaCustomeRepository<T> {
	protected Logger logger = LoggerFactory.getLogger(getClass());

	protected JpaCustomeRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
		super(sqlSessionTemplate);
	}


	@Override
	public T findBasicOne(Map<String, Object> paramsMap, String... columns) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.putAll(paramsMap);
		if (null != columns) {
			params.put("_specifiedFields", columns);
		}
		return selectOne("_findBasicAll", params);
	}

	@Override
	public List<T> findBasicAll(Map<String, Object> paramsMap, String... columns) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.putAll(paramsMap);
		if (null != columns) {
			params.put("_specifiedFields", columns);
		}
		return selectList("_findBasicAll", params);
	}

	@Override
	public List<T> findBasicAll(Sort sort, Map<String, Object> paramsMap, String... columns) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.putAll(paramsMap);
		params.put("_sorts", sort);
		if (null != columns) {
			params.put("_specifiedFields", columns);
		}
		return selectList("_findBasicAll", params);
	}

	@Override
	public Page<T> findBasicAll(Pageable pageable, Map<String, Object> paramsMap, String... columns) {
		return findByPager(pageable, "_findBasicByPager", "_countBasicByCondition", null, paramsMap, columns);

	}

	@Override
	public Long countBasicAll(Map<String, Object> paramsMap) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.putAll(paramsMap);
		return selectOne("_countBasicByCondition", params);
	}
	public boolean doCheckWithEntity(T entity, Map<String, QueryCondition.Operator> maps) {
		boolean rs = false;
		if (PublicUtil.isNotEmpty(entity)) {
			Map<String, Object> paramsMap = Maps.newHashMap();
			List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps);
			String sqlConditionDsf = QueryUtil.convertQueryConditionToStr(conditionList,
					null,
					paramsMap);
			paramsMap.put(DynamicSpecifications.MYBITS_SEARCH_DSF, sqlConditionDsf);
			Long obj = countBasicAll(paramsMap);
			if (obj == null || obj == 0) {
				rs = true;
			}
		}
		return rs;
	}
	@Override
	public boolean doCheckByProperty(T entity) {
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_ID, QueryCondition.Operator.ne);
			maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
			Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return doCheckWithEntity(entity, maps);

	}

	@Override
	public boolean doCheckByPK(T entity) {

		boolean rs = false;
		Map<String, QueryCondition.Operator> maps = Maps.newHashMap();
		try {
			maps.put(BaseEntity.F_STATUS, QueryCondition.Operator.ne);
			Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
		} catch (Exception e) {
			logger.error(e.toString());
		}
		return doCheckWithEntity(entity, maps);
	}

	@Override
	@Transactional(readOnly = true)
	public List<ComboData> findJson(Combo combo) {
		List<ComboData> mapList = Lists.newArrayList();
		if (PublicUtil.isNotEmpty(combo) && PublicUtil.isNotEmpty(combo.getId())
				&& PublicUtil.isNotEmpty(combo.getName()) && PublicUtil.isNotEmpty(combo.getModule())) {
			StringBuffer sb = new StringBuffer()
					.append(combo.getId()).append("as id,").append(combo.getName()).append("as name,");
			boolean flag = PublicUtil.isNotEmpty(combo.getParentId());
			if (flag) sb.append(",").append(combo.getParentId()).append("as pId");
			ComboQuery comboQuery = new ComboQuery();
			comboQuery.setColumns(sb.toString());
			comboQuery.setTableName(combo.getName());
			if (PublicUtil.isNotEmpty(combo.getWhere())) comboQuery.setCondition(" and "+combo.getWhere());
			mapList = selectOne("_findByCombo", comboQuery);
		}
		return mapList;
	}

	@Override
	protected String getNamespace() {
		return JpaCustomeRepositoryImpl.class.getName();
	}
}
