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

package org.springframework.data.mybatis.config.sample;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ResourceLoader;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.mybatis.replication.datasource.ReplicationRoutingDataSource;
import org.springframework.data.mybatis.replication.transaction.ReadWriteManagedTransactionFactory;
import org.springframework.data.mybatis.repository.config.EnableMybatisRepositories;
import org.springframework.data.mybatis.support.SqlSessionFactoryBean;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.LazyConnectionDataSourceProxy;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabase;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseBuilder;
import org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.Date;

/**
 * Created by songjiawei on 2016/11/9.
 */
@Configuration
@EnableMybatisRepositories(
        value = "org.springframework.data.mybatis.repository.sample",
        mapperLocations = "classpath*:/org/springframework/data/mybatis/repository/sample/mappers/*Mapper.xml"
)
@EnableTransactionManagement
public class TestConfig implements ResourceLoaderAware {

    private ResourceLoader resourceLoader;

    @Bean
    public DataSource routingDataSource() throws SQLException {
        EmbeddedDatabase embeddedDatabase = new EmbeddedDatabaseBuilder().setType(EmbeddedDatabaseType.H2).addScript("classpath:/test-init.sql").build();

        ReplicationRoutingDataSource proxy = new ReplicationRoutingDataSource(embeddedDatabase, null);
        proxy.addSlave(embeddedDatabase);
        proxy.addSlave(embeddedDatabase);
        proxy.addSlave(embeddedDatabase);
        return proxy;
    }

    @Bean
    public DataSource dataSource(@Qualifier("routingDataSource") DataSource routingDataSource) {
        return new LazyConnectionDataSourceProxy(routingDataSource);
    }

    @Bean
    public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);
        factoryBean.setTransactionFactory(new ReadWriteManagedTransactionFactory());
        return factoryBean;
    }

    @Bean
    public PlatformTransactionManager transactionManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean
    public AuditorAware<Long> auditorAware() {
        return new AuditorAware<Long>() {
            @Override
            public Long getCurrentAuditor() {
                return 1001L;
            }
        };
    }

    @Bean
    public AuditDateAware<Date> auditDateAware() {
        return new AuditDateAware<Date>() {
            @Override
            public Date getCurrentDate() {
                return new Date();
            }
        };
    }

    @Override
    public void setResourceLoader(ResourceLoader resourceLoader) {

        this.resourceLoader = resourceLoader;
    }
}
