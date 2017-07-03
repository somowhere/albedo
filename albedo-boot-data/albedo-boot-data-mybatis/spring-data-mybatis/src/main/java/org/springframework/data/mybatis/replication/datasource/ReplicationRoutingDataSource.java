package org.springframework.data.mybatis.replication.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.LazyConnectionDataSourceProxy;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.springframework.util.Assert.notNull;

/**
 * @author Jarvis Song
 */
public class ReplicationRoutingDataSource extends AbstractRoutingDataSource {
    private final transient static Logger logger = LoggerFactory.getLogger(ReplicationRoutingDataSource.class);
    private static ThreadLocal<Integer> FORCE_STATUS = new ThreadLocal<Integer>();
    private static ThreadLocal<Integer> STATEMENT_TYPE = new ThreadLocal<Integer>();
    private DatasourceSelectPolicy datasourceSelectPolicy;
    private DataSource master;
    private List<DataSource> slaves = new ArrayList<DataSource>();


    public ReplicationRoutingDataSource(DataSource master, List<DataSource> slaves) {

        notNull(master, "master datasource mast be set.");
        this.master = new LazyConnectionDataSourceProxy(master);
        if (null != slaves) {
            this.slaves = slaves;
        }
        setDefaultTargetDataSource(this.master);

        Map<Object, Object> dataSourceMap = new HashMap<Object, Object>();
        dataSourceMap.put("master", this.master);
        if (null != slaves && !slaves.isEmpty()) {
            for (int i = 0; i < slaves.size(); i++) {
                dataSourceMap.put("slave_" + i, new LazyConnectionDataSourceProxy(slaves.get(i)));
            }
        }
        setTargetDataSources(dataSourceMap);
    }

    public static void forceMaster() {
        FORCE_STATUS.set(1);
        logger.debug("force use master datasource.");
    }

    public static void forceSlave() {
        FORCE_STATUS.set(2);
        logger.debug("force use slave datasource.");
    }

    public static void clearThreadLocal() {
        FORCE_STATUS.set(null);
        STATEMENT_TYPE.set(null);
        logger.debug("clear datasource proxy threadlocal.");

    }

    public static void isUpdate(boolean update) {
        if (update) {
            STATEMENT_TYPE.set(1);
        } else {
            STATEMENT_TYPE.set(2);
        }
    }

    @Override
    public void afterPropertiesSet() {
        super.afterPropertiesSet();

        if (null == datasourceSelectPolicy && !slaves.isEmpty()) {
            datasourceSelectPolicy = new RoundRobinDatasourceSelectPolicy();
        }
    }

    private String doDetermineCurrentLookupKey() {
        if (null == slaves || slaves.isEmpty()) {
            return "master";
        }

        Integer statementType = STATEMENT_TYPE.get();
        if (null != statementType && statementType == 1) {
            return "master";
        }

        Integer forceStatus = FORCE_STATUS.get();
        if (null != forceStatus && forceStatus == 1) {
            // force use master
            return "master";
        }
        if (null != forceStatus && forceStatus == 2) {
            // force use slave
            return "slave_" + datasourceSelectPolicy.select(slaves);
        }

        // if in transaction
        boolean transactionActive = TransactionSynchronizationManager.isActualTransactionActive();
        if (transactionActive) {
            boolean readOnly = TransactionSynchronizationManager.isCurrentTransactionReadOnly();
            if (readOnly) {
                return "slave_" + datasourceSelectPolicy.select(slaves);
            }
        }
        return "master";
    }

    @Override
    protected Object determineCurrentLookupKey() {
        String key = doDetermineCurrentLookupKey();
        logger.debug("current datasource : " + key);
        return key;
    }

    public void addSlave(DataSource slave) {
        slaves.add(slave);
    }


    public void setDatasourceSelectPolicy(DatasourceSelectPolicy datasourceSelectPolicy) {
        this.datasourceSelectPolicy = datasourceSelectPolicy;
    }
}
