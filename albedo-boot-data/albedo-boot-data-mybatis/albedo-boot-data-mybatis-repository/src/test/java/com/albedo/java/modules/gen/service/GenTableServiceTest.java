package com.albedo.java.modules.gen.service;

import com.albedo.java.config.TestConfig;
import com.albedo.java.modules.gen.repository.GenTableRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

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
//        GenTableVo genTable = new GenTableVo();
//        genTable.setName("sys_user_t");
//        List<GenTableColumn> tableColumnList = genTableRepository.findTableColumnList(genTable);
//        assertThat(tableColumnList.size(), is(19));
//        List<GenTableVo> tableList = genTableRepository.findTableList(genTable);
//        assertThat(tableList.get(0).ge, is(19));
    }

}