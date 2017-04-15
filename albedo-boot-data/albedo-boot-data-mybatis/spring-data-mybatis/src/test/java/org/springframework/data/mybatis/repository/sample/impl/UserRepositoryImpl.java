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
package org.springframework.data.mybatis.repository.sample.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mybatis.domain.sample.User;
import org.springframework.data.mybatis.repository.sample.UserRepositoryCustom;
import org.springframework.data.mybatis.repository.support.SqlSessionRepositorySupport;

public class UserRepositoryImpl extends SqlSessionRepositorySupport implements UserRepositoryCustom {

    @Autowired
    protected UserRepositoryImpl(SqlSessionTemplate sqlSessionTemplate) {
        super(sqlSessionTemplate);
    }

    @Override
    public void findByOverrridingMethod() {

    }

    @Override
    public void someCustomMethod(User user) {

    }

    @Override
    protected String getNamespace() {
        return User.class.getName();
    }
}
