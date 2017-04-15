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

package org.springframework.data.mybatis.support;

import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.mapping.VendorDatabaseIdProvider;

import java.util.Properties;

/**
 * {@code FactoryBean} that creates an MyBatis {@code SqlSessionFactory}.
 * This is the usual way to set up a shared MyBatis {@code SqlSessionFactory} in a Spring application context;
 * the SqlSessionFactory can then be passed to MyBatis-based DAOs via dependency injection.
 * <p>
 * Either {@code DataSourceTransactionManager} or {@code JtaTransactionManager} can be used for transaction
 * demarcation in combination with a {@code SqlSessionFactory}. JTA should be used for transactions
 * which span multiple databases or when container managed transactions (CMT) are being used.
 *
 * @author Jarvis Song
 */
public class SqlSessionFactoryBean extends org.mybatis.spring.SqlSessionFactoryBean {


    @Override
    public void afterPropertiesSet() throws Exception {

        DatabaseIdProvider databaseIdProvider = new VendorDatabaseIdProvider();
        Properties p = new Properties();
        p.setProperty("SQL Server", "sqlserver");
        p.setProperty("Oracle", "oracle");
        p.setProperty("DB2", "db2");
        p.setProperty("MySQL", "mysql");
        p.setProperty("H2", "h2");
        p.setProperty("PostgreSQL", "postgres");
        databaseIdProvider.setProperties(p);
        setDatabaseIdProvider(databaseIdProvider);


        super.afterPropertiesSet();
    }


}
