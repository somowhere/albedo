/*
 *
 *   Copyright 2016 the original author or authors.
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 *
 */

package org.springframework.data.mybatis.repository;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mybatis.config.sample.TestConfig;
import org.springframework.data.mybatis.domain.sample.Department;
import org.springframework.data.mybatis.repository.sample.DepartmentRepository;
import org.springframework.data.mybatis.repository.support.MybatisNoHintException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.assertEquals;

/**
 * @author Jarvis Song
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class VersionDepartmentRepositoryTests {


    @Autowired
    private DepartmentRepository departmentRepository;

    Department research;

    @Before
    public void setUp() throws Exception {

        research = new Department("research");
        departmentRepository.save(research);

    }

    @Test
    public void testVersion() {
        research.setName("research1");
        int version = research.getVersion();
        departmentRepository.save(research);
        assertEquals(version + 1, research.getVersion().intValue());
    }

    @Test
    public void testUpdateAfterInsert() {
        Department department = new Department("develop");
        departmentRepository.save(department);
        int ver = department.getVersion().intValue();
        assertEquals(0, ver);
        department.setName("develop1");
        departmentRepository.save(department);
        assertEquals(ver + 1, department.getVersion().intValue());

    }

    @Test(expected = MybatisNoHintException.class)
    public void testVersionConfusion() {
        research.setName("research1");
        research.setVersion(research.getVersion() + 2);
        departmentRepository.save(research);

    }


}
