package com.albedo.java.modules.gen.service;

import com.albedo.java.config.TestConfig;
import com.albedo.java.modules.gen.domain.GenTable;
import com.albedo.java.modules.gen.domain.GenTableColumn;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import com.albedo.java.modules.sys.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.*;

/**
 * Created by lijie on 2017/4/19.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class GenTableServiceTest {

    @Autowired
    GenTableRepository genTableRepository;

    @Test
    public void findPage() throws Exception {
//        GenTable genTable = new GenTable();
//        genTable.setName("sys_user_t");
//        List<GenTableColumn> tableColumnList = genTableRepository.findTableColumnList(genTable);
//        assertThat(tableColumnList.size(), is(19));
//        List<GenTable> tableList = genTableRepository.findTableList(genTable);
//        assertThat(tableList.get(0).ge, is(19));
    }

    }