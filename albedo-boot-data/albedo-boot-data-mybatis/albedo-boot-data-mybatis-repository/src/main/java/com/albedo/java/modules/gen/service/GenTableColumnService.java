package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.service.DataService;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.repository.GenTableColumnRepository;
import com.albedo.java.util.base.Assert;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTableColumnService extends DataService<GenTableColumnRepository, GenTableColumn, String> {

    public void deleteByTableId(String id, String currentAuditor) {
        GenTableColumn genTableColumn = repository.findOneByGenTableId(id);
        Assert.assertNotNull(genTableColumn, "id " + id + " genTableColumn 不能为空");
        genTableColumn.setStatus(BaseEntity.FLAG_DELETE);
        repository.updateIgnoreNull(genTableColumn);
    }


}
