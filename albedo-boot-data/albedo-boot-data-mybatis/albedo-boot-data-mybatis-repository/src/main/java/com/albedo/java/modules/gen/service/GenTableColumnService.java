package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.BaseEntity;
import com.albedo.java.common.service.DataVoService;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.repository.GenTableColumnRepository;
import com.albedo.java.util.base.Assert;
import com.albedo.java.vo.gen.GenTableColumnVo;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service class for managing genTables.
 *
 * @author somewhere
 */
@Service
public class GenTableColumnService extends DataVoService<GenTableColumnRepository, GenTableColumn, String, GenTableColumnVo> {

    public void deleteByTableId(String id, String currentAuditor) {
        List<GenTableColumn> genTableColumnList = repository.findAllByGenTableIdOrderBySort(id);
        Assert.assertNotNull(genTableColumnList, "id " + id + " genTableColumn 不能为空");
        genTableColumnList.forEach(item -> {
            item.setStatus(BaseEntity.FLAG_DELETE);
            repository.updateIgnoreNull(item);
        });

    }


}
