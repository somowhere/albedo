package org.springframework.data.mybatis.replication.transaction;

import org.apache.ibatis.session.TransactionIsolationLevel;
import org.apache.ibatis.transaction.Transaction;
import org.mybatis.spring.transaction.SpringManagedTransactionFactory;

import javax.sql.DataSource;

/**
 * @author Jarvis Song
 */
public class ReadWriteManagedTransactionFactory extends SpringManagedTransactionFactory {

    @Override
    public Transaction newTransaction(DataSource dataSource, TransactionIsolationLevel level, boolean autoCommit) {
        return new ReadWriteManagedTransaction(dataSource);
    }
}
