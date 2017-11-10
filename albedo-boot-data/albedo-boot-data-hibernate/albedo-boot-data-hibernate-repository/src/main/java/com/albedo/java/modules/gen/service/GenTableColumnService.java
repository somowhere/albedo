package com.albedo.java.modules.gen.service;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.service.DataService;
import com.albedo.java.common.service.DataVoService;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.repository.GenTableColumnRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.vo.gen.GenTableColumnVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTableColumnService extends DataVoService<GenTableColumnRepository,
        GenTableColumn, String, GenTableColumnVo> {


    public void deleteByTableId(String id, String currentAuditor) {
        baseRepository.createQuery(
                PublicUtil.toAppendStr("update GenTableColumn set status='", BaseEntity.FLAG_DELETE,
                        "', lastModifiedBy=:p2, lastModifiedDate=:p3 where genTable.id = :p1"),
                id, currentAuditor, PublicUtil.getCurrentDate()).executeUpdate();
    }


}
