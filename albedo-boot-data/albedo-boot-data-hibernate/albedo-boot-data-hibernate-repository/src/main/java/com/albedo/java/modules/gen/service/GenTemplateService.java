package com.albedo.java.modules.gen.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.google.common.collect.Lists;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTemplateService extends BaseService<GenTableRepository, GenTable> {


	@Transactional(readOnly=true)
	public Page<GenTable> findAll(PageModel<GenTable> pm) {
		SpecificationDetail<GenTable> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(),
				QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE));
		return repository.findAll(spec, pm);
	}

	@Transactional(readOnly=true)
	public List<GenTable> findAll() {
		return repository.findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
	}

}
