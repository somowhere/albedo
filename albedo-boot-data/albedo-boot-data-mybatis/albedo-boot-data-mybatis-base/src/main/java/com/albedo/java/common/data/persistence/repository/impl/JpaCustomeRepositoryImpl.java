package com.albedo.java.common.data.persistence.repository.impl;

import com.albedo.java.common.data.persistence.GeneralEntity;
import com.albedo.java.common.data.persistence.repository.JpaCustomeRepository;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;
import com.albedo.java.util.domain.ComboQuery;
import com.google.common.collect.Lists;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mybatis.repository.support.SqlSessionRepositorySupport;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component
@Transactional
public class JpaCustomeRepositoryImpl<T extends GeneralEntity>
        extends SqlSessionRepositorySupport implements JpaCustomeRepository<T> {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected JpaCustomeRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super(sqlSessionTemplate);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
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
            if (PublicUtil.isNotEmpty(combo.getWhere())) comboQuery.setCondition(" and " + combo.getWhere());
            mapList = selectOne("_findByCombo", comboQuery);
        }
        return mapList;
    }


    @Override
    protected String getNamespace() {
        return JpaCustomeRepositoryImpl.class.getName();
    }
}
