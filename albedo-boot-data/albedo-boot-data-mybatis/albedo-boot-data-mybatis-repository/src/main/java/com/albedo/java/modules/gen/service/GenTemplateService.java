package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTemplate;
import com.albedo.java.modules.gen.repository.GenTemplateRepository;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class GenTemplateService extends DataService<GenTemplateRepository, GenTemplate, String> {


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTemplate> findAll() {
        return findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
    }

}
