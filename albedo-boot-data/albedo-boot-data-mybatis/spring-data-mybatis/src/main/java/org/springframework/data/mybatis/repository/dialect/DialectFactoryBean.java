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

package org.springframework.data.mybatis.repository.dialect;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;

/**
 * @author Jarvis Song
 */
public class DialectFactoryBean implements FactoryBean<Dialect>, InitializingBean {

    public static final int NO_VERSION = -9999;
    private Dialect dialect;
    private SqlSessionFactory sqlSessionFactory;

    private static int interpretVersion(int result) {
        return result < 0 ? NO_VERSION : result;
    }

    @Override
    public Dialect getObject() throws Exception {

        if (null == dialect) {
            afterPropertiesSet();
        }
        return dialect;
    }

    @Override
    public Class<?> getObjectType() {
        return null == dialect ? Dialect.class : dialect.getClass();
    }

    @Override
    public boolean isSingleton() {
        return true;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        Assert.notNull(sqlSessionFactory);

        DataSource dataSource = sqlSessionFactory.getConfiguration().getEnvironment().getDataSource();
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
            DatabaseMetaData metaData = conn.getMetaData();

            this.dialect = getDialect(metaData);

        } finally {
            if (null != conn) {
                conn.close();
            }
        }
    }

    private Dialect getDialect(DatabaseMetaData metaData) throws SQLException {
        final String databaseName = metaData.getDatabaseProductName();
        final int majorVersion = interpretVersion(metaData.getDatabaseMajorVersion());
        final int minorVersion = interpretVersion(metaData.getDatabaseMinorVersion());
        if ("H2".equals(databaseName)) {
            return new H2Dialect();
        }
        if ("MySQL".equals(databaseName)) {
//            if (majorVersion >= 5 ) {
//                return new MySQL5Dialect();
//            }
            return new MySQLDialect();
        }
        if (databaseName.startsWith("Microsoft SQL Server")) {
            return new SQLServerDialect();
//            switch (majorVersion) {
//                case 8: {
//                    return new SQLServerDialect();
//                }
//                case 9: {
//                    return new SQLServer2005Dialect();
//                }
//                case 10: {
//                    return new SQLServer2008Dialect();
//                }
//                case 11:
//                case 12:
//                case 13: {
//                    return new SQLServer2012Dialect();
//                }
//                default: {
//                    if (majorVersion < 8) {
//                        LOG.unknownSqlServerVersion(majorVersion, SQLServerDialect.class);
//                        return new SQLServerDialect();
//                    } else {
//                        // assume `majorVersion > 13`
//                        LOG.unknownSqlServerVersion(majorVersion, SQLServer2012Dialect.class);
//                        return new SQLServer2012Dialect();
//                    }
//                }
//            }
        }
        if ("Oracle".equals(databaseName)) {
            return new OracleDialect();
//            switch (majorVersion) {
//                case 12:
//                    return new Oracle12cDialect();
//                case 11:
//                    // fall through
//                case 10:
//                    return new Oracle10gDialect();
//                case 9:
//                    return new Oracle9iDialect();
//                case 8:
//                    return new Oracle8iDialect();
//                default:
//                    LOG.unknownOracleVersion(majorVersion);
//            }
//            return new Oracle8iDialect();
        }

        if ("PostgreSQL".equals(databaseName)) {
//            if ( majorVersion == 9 ) {
//                if ( minorVersion >= 4 ) {
//                    return new PostgreSQL94Dialect();
//                }
//                else if ( minorVersion >= 2 ) {
//                    return new PostgreSQL92Dialect();
//                }
//                return new PostgreSQL9Dialect();
//            }
//
//            if ( majorVersion == 8 && minorVersion >= 2 ) {
//                return new PostgreSQL82Dialect();
//            }

            return new PostgreSQLDialect();
        }


        return null;
    }

    public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        this.sqlSessionFactory = sqlSessionFactory;
    }
}
