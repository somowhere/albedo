package org.springframework.data.mybatis.replication.transaction;

import org.mybatis.spring.transaction.SpringManagedTransaction;
import org.springframework.data.mybatis.replication.datasource.ReplicationRoutingDataSource;

import javax.sql.DataSource;
import java.sql.SQLException;

/**
 * @author Jarvis Song
 */
public class ReadWriteManagedTransaction extends SpringManagedTransaction {

    public ReadWriteManagedTransaction(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public void close() throws SQLException {
        try {
            super.close();
        } finally {
            ReplicationRoutingDataSource.clearThreadLocal();
        }
    }
}
