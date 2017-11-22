package com.albedo.java.modules.gen.service;

import com.albedo.java.common.data.persistence.DynamicSpecifications;
import com.albedo.java.common.data.persistence.SpecificationDetail;
import com.albedo.java.common.service.DataService;
import com.albedo.java.common.service.DataVoService;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.gen.util.GenUtil;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Assert;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.gen.GenTableColumnVo;
import com.albedo.java.vo.gen.GenTableVo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service class for managing genTables.
 */
@Service
@Transactional
public class GenTableService extends DataVoService<GenTableRepository,
        GenTable, String, GenTableVo> {

    @Autowired
    private GenTableColumnService genTableColumnService;


    @Override
    public void copyVoToBean(GenTableVo form, GenTable genTable) {
        super.copyVoToBean(form, genTable);
        if (genTable != null) {
            if (PublicUtil.isNotEmpty(form.getColumnFormList())) {
                genTable.setColumnFormList(form.getColumnFormList().stream()
                        .map(item -> genTableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
            if (PublicUtil.isNotEmpty(form.getColumnList())) {
                genTable.setColumnList(form.getColumnList().stream()
                        .map(item -> genTableColumnService.copyVoToBean(item)).collect(Collectors.toList()));
            }
        }
    }

    @Override
    public void copyBeanToVo(GenTable genTable, GenTableVo result) {
        super.copyBeanToVo(genTable, result);
        if (genTable != null) {
            if (PublicUtil.isNotEmpty(genTable.getColumnFormList())) {
                result.setColumnFormList(genTable.getColumnFormList().stream()
                        .map(item -> genTableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
            if (PublicUtil.isNotEmpty(genTable.getColumnList())) {
                result.setColumnList(genTable.getColumnList().stream()
                        .map(item -> genTableColumnService.copyBeanToVo(item)).collect(Collectors.toList()));
            }
        }
    }

    @Override
    public GenTable save(GenTable genTable) {
        genTable.setColumnList(genTable.getColumnFormList());
        genTable = repository.save(genTable);
        log.debug("Save Information for GenTable: {}", genTable);

        return genTable;
    }

    public void delete(List<String> ids, String currentAuditor) {
        ids.forEach(id -> {
            GenTable entity = repository.findOne(id);
            Assert.assertNotNull(entity, "对象 " + id + " 信息为空，删除失败");
            deleteById(id);
            genTableColumnService.deleteByTableId(id, currentAuditor);
            log.debug("Deleted GenTable: {}", entity);
        });
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Page<GenTable> findAll(SpecificationDetail<GenTable> spec, PageModel<GenTable> pm) {
        return repository.findAll(spec, pm);
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTable> findAll() {
        return repository.findAll(DynamicSpecifications
                .bySearchQueryCondition(QueryCondition.ne(GenTable.F_STATUS, GenTable.FLAG_DELETE)));
    }


    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean checkTableName(String tableName) {
        if (StringUtil.isBlank(tableName)) {
            return true;
        }
        List<GenTable> list = repository.findAll(
                DynamicSpecifications.bySearchQueryCondition(QueryCondition.eq(GenTable.F_STATUS, GenTable.FLAG_NORMAL),
                        QueryCondition.eq(GenTable.F_NAME, tableName)));
        return list.size() == 0;
    }

    public GenTableVo getTableFormDb(GenTableVo genTable) {
        // 如果有表名，则获取物理表
        if (StringUtil.isNotBlank(genTable.getName())) {

            List<GenTableVo> list = findTableListFormDb(genTable);
            if (list.size() > 0) {

                // 如果是新增，初始化表属性
                if (StringUtil.isBlank(genTable.getId())) {
                    genTable = list.get(0);
                    // 设置字段说明
                    if (StringUtil.isBlank(genTable.getComments())) {
                        genTable.setComments(genTable.getName());
                    }
                    genTable.setClassName(StringUtil.toCapitalizeCamelCase(genTable.getName()));
                }

                // 添加新列
                List<GenTableColumnVo> columnList = findTableColumnList(genTable);
                for (GenTableColumnVo column : columnList) {
                    boolean b = false;
                    for (GenTableColumnVo e : genTable.getColumnList()) {
                        if (e.getName().equals(column.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        genTable.getColumnList().add(column);
                    }
                }
                // 删除已删除的列
                for (GenTableColumnVo e : genTable.getColumnList()) {
                    boolean b = false;
                    for (GenTableColumnVo column : columnList) {
                        if (column.getName().equals(e.getName())) {
                            b = true;
                        }
                    }
                    if (!b) {
                        e.setStatus(GenTableColumn.FLAG_DELETE);
                    }
                }

                // 获取主键
                genTable.setPkList(findTablePK(genTable));

                // 初始化列属性字段
                GenUtil.initColumnField(genTable);

            }
        }
        return genTable;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<String> findTablePK(GenTableVo genTable) {
        List<String> pkList = null;
        String sql = "";
        if (SystemConfig.isMySql()) {
            sql = "SELECT lower(au.COLUMN_NAME) AS columnName FROM information_schema.`COLUMNS` au WHERE au.TABLE_SCHEMA = (select database()) AND au.COLUMN_KEY='PRI' AND au.TABLE_NAME = :p1";
        } else if (SystemConfig.isOracle()) {
            sql = "SELECT lower(cu.COLUMN_NAME) AS columnName FROM user_cons_columns cu, user_constraints au WHERE cu.constraint_name = au.constraint_name AND au.constraint_type = 'P' AND au.table_name = :p1";
        }
        pkList = baseRepository.createSqlQuery(sql, genTable.getName()).list();
        return pkList;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTableColumnVo> findTableColumnList(GenTableVo genTable) {
        List<String[]> GenString = null;
        List<GenTableColumnVo> list = null;
        String sql = "";
        if (SystemConfig.isMySql()) {
            sql = "SELECT t.COLUMN_NAME AS name, (CASE WHEN t.IS_NULLABLE = 'YES' THEN '1' ELSE '0' END) AS isNull, (t.ORDINAL_POSITION * 10) AS sort,t.COLUMN_COMMENT AS comments,t.COLUMN_TYPE AS jdbcType FROM information_schema.`COLUMNS` t WHERE t.TABLE_SCHEMA = (select database()) AND t.TABLE_NAME = :p1 ORDER BY t.ORDINAL_POSITION";
        } else if (SystemConfig.isOracle()) {
            sql = "SELECT t.COLUMN_NAME AS name, (CASE WHEN t.NULLABLE = 'Y' THEN '1' ELSE '0' END) AS isNull, (t.COLUMN_ID * 10) AS sort, c.COMMENTS AS comments, decode(t.DATA_TYPE, 'DATE', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')', 'VARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','VARCHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','NVARCHAR2', t.DATA_TYPE || '(' || t.DATA_LENGTH/2 || ')','CHAR', t.DATA_TYPE || '(' || t.DATA_LENGTH || ')','NUMBER',t.DATA_TYPE || (nvl2(t.DATA_PRECISION,nvl2(decode(t.DATA_SCALE,0,null,t.DATA_SCALE),'(' || t.DATA_PRECISION || ',' || t.DATA_SCALE || ')', '(' || t.DATA_PRECISION || ')'),'(18)')),t.DATA_TYPE) AS jdbcType FROM user_tab_columns t, user_col_comments c WHERE t.TABLE_NAME = c.table_name AND t.COLUMN_NAME = c.column_name AND t.TABLE_NAME = :p1 ORDER BY t.COLUMN_ID";
        }
        GenString = baseRepository.createSqlQuery(sql, genTable.getName()).list();
        if (PublicUtil.isNotEmpty(GenString)) {
            list = Lists.newArrayList();
            for (Object[] str : GenString) {
                list.add(new GenTableColumnVo(String.valueOf(str[0]), Integer.parseInt(String.valueOf(str[1])),
                        Integer.parseInt(String.valueOf(str[2])), String.valueOf(str[3]), String.valueOf(str[4])));
            }
        } else {
            throw new RuntimeMsgException(PublicUtil.toAppendStr("无法获取[", genTable.getName(), "]表的列信息"));
        }
        return list;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<GenTableVo> findTableListFormDb(GenTableVo genTable) {
        List<String[]> GenString = null;
        List<GenTableVo> list = Lists.newArrayList();
        String sql = "";
        if (SystemConfig.isMySql()) {
            sql = "SELECT t.table_name AS name,t.TABLE_COMMENT AS comments FROM information_schema.`TABLES` t WHERE t.TABLE_SCHEMA = (select database()) AND t.TABLE_NAME=:p1 ORDER BY t.TABLE_NAME";
        } else if (SystemConfig.isOracle()) {
            sql = "SELECT t.TABLE_NAME AS name, c.COMMENTS AS comments FROM user_tables t, user_tab_comments c WHERE t.table_name = c.table_name AND t.TABLE_NAME=:p1 ORDER BY t.TABLE_NAME";
        }
        if (genTable!=null && PublicUtil.isNotEmpty(genTable.getName())) {
            GenString = baseRepository.createSqlQuery(sql, StringUtil.upperCase(genTable.getName())).list();
        }
        if (PublicUtil.isEmpty(GenString)) {
            GenString = baseRepository.createSqlQuery(sql.replace(" AND t.TABLE_NAME=:p1", "")).list();
        }


        if (PublicUtil.isNotEmpty(GenString)) {
            for (Object[] str : GenString) {
                list.add(new GenTableVo((String) str[0], (String) str[1]));
            }
        }
        return list;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Map<String, Object> findFormData(GenTableVo genTableVo) {
        Map<String, Object> map = Maps.newHashMap();
        map.put("tableList", PublicUtil.convertComboDataList(findTableListFormDb(new GenTableVo()), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));
        // 验证表是否存在
        if (StringUtil.isBlank(genTableVo.getId()) && !checkTableName(genTableVo.getName())) {
            throw new RuntimeMsgException(PublicUtil.toAppendStr("下一步失败！", genTableVo.getName(), " 表已经添加！"));
        }
        if (PublicUtil.isNotEmpty(genTableVo.getId())) {
            genTableVo = findOneVo(genTableVo.getId());
        }
        // 获取物理表字段
        genTableVo = getTableFormDb(genTableVo);
        map.put("columnList", PublicUtil.convertComboDataList(genTableVo.getColumnList(), GenTable.F_NAME, GenTable.F_NAMESANDCOMMENTS));


        map.put("genTableVo", genTableVo);
        GenConfig config = GenUtil.getConfig();
        map.put("config", config);

        map.put("queryTypeList", PublicUtil.convertComboDataList(config.getQueryTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("showTypeList", PublicUtil.convertComboDataList(config.getShowTypeList(), Dict.F_VAL, Dict.F_NAME));
        map.put("javaTypeList", PublicUtil.convertComboDataList(config.getJavaTypeList(), Dict.F_VAL, Dict.F_NAME));


        return map;
    }

}
