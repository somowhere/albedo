package com.albedo.java.modules.gen.repository;

import com.albedo.java.common.data.persistence.repository.BaseRepository;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.vo.GenTableQuery;
import com.albedo.java.vo.gen.GenTableColumnVo;
import com.albedo.java.vo.gen.GenTableVo;
import org.springframework.data.mybatis.repository.annotation.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority entity.
 */
public interface GenTableRepository extends BaseRepository<GenTable, String> {
    /**
     * 查询表列表
     *
     * @param genTableQuery
     * @return
     */
    @Query
    List<GenTable> findTableList(@Param("genTableQuery") GenTableQuery genTableQuery);

    /**
     * 获取数据表字段
     *
     * @param genTableVo
     * @return
     */
    @Query
    List<GenTableColumnVo> findTableColumnList(@Param("genTableVo") GenTableVo genTableVo);

    /**
     * 获取数据表主键
     *
     * @param genTableVo
     * @return
     */
    @Query
    List<String> findTablePK(@Param("genTableVo") GenTableVo genTableVo);

    List<GenTable> findAllByParentTable(String id);
}
