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

package org.springframework.data.mybatis.repository.support;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.mybatis.mapping.MybatisMappingContext;
import org.springframework.data.mybatis.repository.dialect.Dialect;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.core.support.RepositoryFactorySupport;
import org.springframework.data.repository.core.support.TransactionalRepositoryFactoryBeanSupport;
import org.springframework.util.Assert;

import java.io.Serializable;

/**
 * spring data repository factory bean.
 *
 * @author Jarvis Song
 */
public class MybatisRepositoryFactoryBean<T extends Repository<S, ID>, S, ID extends Serializable> extends
        TransactionalRepositoryFactoryBeanSupport<T, S, ID> {

    private SqlSessionTemplate sqlSessionTemplate;
    private Dialect dialect;
    private MybatisMappingContext mappingContext;

    @Autowired(required = false)
    private AuditorAware<?> auditorAware;
    @Autowired(required = false)
    private AuditDateAware<?> auditDateAware;

    /**
     * Creates a new {@link TransactionalRepositoryFactoryBeanSupport} for the given repository interface.
     *
     * @param repositoryInterface must not be {@literal null}.
     */
    public MybatisRepositoryFactoryBean(Class<? extends T> repositoryInterface) {
        super(repositoryInterface);
    }

    @Override
    public void afterPropertiesSet() {
        Assert.notNull(sqlSessionTemplate, "SqlSessionTemplate must not be null.");
        Assert.notNull(dialect, "Database dialect must not be null.");
        super.afterPropertiesSet();
    }

    public void setMappingContext(MybatisMappingContext mappingContext) {
        this.mappingContext = mappingContext;
        super.setMappingContext(mappingContext);
    }

    @Override
    protected RepositoryFactorySupport doCreateRepositoryFactory() {
        return new MybatisRepositoryFactory(mappingContext, sqlSessionTemplate, dialect, auditorAware, auditDateAware);
    }

    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

    public void setDialect(Dialect dialect) {
        this.dialect = dialect;
    }

    public void setAuditorAware(AuditorAware<?> auditorAware) {
        this.auditorAware = auditorAware;
    }
}
