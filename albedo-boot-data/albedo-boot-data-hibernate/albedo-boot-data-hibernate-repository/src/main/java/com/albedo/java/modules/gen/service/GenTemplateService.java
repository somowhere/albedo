package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.util.domain.QueryCondition;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTemplateService extends DataService<GenTableRepository, GenTable, String> {


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTable> findAll() {
        return repository.findAll(DynamicSpecifications.bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
    }

}
