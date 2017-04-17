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
