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
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

/**
 * @author Jarvis Song
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = TestConfig.class)
@Transactional
public class AuditableDepartmentRepositoryTests {


    @Autowired
    private DepartmentRepository departmentRepository;

    Department research;

    @Before
    public void setUp() throws Exception {

        research = new Department("research");
        departmentRepository.save(research);

    }

    @Test
    public void testCreatedDate() {
        Department develop = new Department("develop");
        assertNull(develop.getCreatedDate());
        develop = departmentRepository.save(develop);
        assertNotNull(develop.getCreatedDate());
    }

    @Test
    public void testLastModifiedDate() {
        assertNull(research.getLastModifiedDate());
        research.setName("research1");
        departmentRepository.save(research);
        assertNotNull(research.getLastModifiedDate());
    }

    @Test
    public void testCreatedBy() {
        Department develop = new Department("develop");
        assertNull(develop.getCreatedBy());
        develop = departmentRepository.save(develop);
        assertNotNull(develop.getCreatedBy());
    }

    @Test
    public void testLastModifiedBy() {
        assertNull(research.getLastModifiedBy());
        research.setName("research1");
        departmentRepository.save(research);
        assertNotNull(research.getLastModifiedBy());
    }


}
