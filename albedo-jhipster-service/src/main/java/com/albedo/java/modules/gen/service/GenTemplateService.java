package com.albedo.java.modules.gen.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.repository.service.BaseService;
import com.albedo.java.common.security.SecurityUtil;
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

import javax.inject.Inject;
import java.util.List;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTemplateService extends BaseService<GenTable> {

    @Inject
    private GenTableRepository genTableRepository;


    public GenTable save(GenTable genTable) {
        genTable = genTableRepository.save(genTable);
        log.debug("Save Information for GenTable: {}", genTable);
        SecurityUtil.clearUserJedisCache();
        return genTable;
    }


    public void delete(String ids) {
    	Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
    		genTableRepository.findOneById(id).map(u -> {
    			deleteById(id);
                log.debug("Deleted GenTable: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，删除失败"));
    	});
    	SecurityUtil.clearUserJedisCache();
    }


	public void lockOrUnLock(String ids) {
		Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)).forEach(id ->{
			genTableRepository.findOneById(id).map(u -> {
    			operateStatusById(id, BaseEntity.FLAG_NORMAL.equals(u.getStatus()) ? BaseEntity.FLAG_UNABLE : BaseEntity.FLAG_NORMAL);
                log.debug("LockOrUnLock User: {}", u);
				return u;
			}).orElseThrow(() -> new RuntimeMsgException("用户 " + id + " 信息为空，操作失败"));
    	});
		SecurityUtil.clearUserJedisCache();
	}

	@Transactional(readOnly=true)
	public GenTable findOne(String id) {
		return genTableRepository.findOne(id);
	}

	@Transactional(readOnly=true)
	public Page<GenTable> findAll(SpecificationDetail<GenTable> spec, PageModel<GenTable> pm) {
		return genTableRepository.findAll(spec, pm);
	}

	@Transactional(readOnly=true)
	public List<GenTable> findAll() {
		return genTableRepository.findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
	}

}
