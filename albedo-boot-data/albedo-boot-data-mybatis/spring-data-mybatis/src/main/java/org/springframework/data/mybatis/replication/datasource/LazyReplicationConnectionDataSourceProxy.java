package org.springframework.data.mybatis.replication.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;

import javax.sql.DataSource;
import java.io.PrintWriter;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Jarvis Song
 */
public class LazyReplicationConnectionDataSourceProxy implements DataSource, InitializingBean {
    private final transient static Logger logger = LoggerFactory.getLogger(LazyReplicationConnectionDataSourceProxy.class);

    private DataSource master;
    private List<DataSource> slaves = new ArrayList<DataSource>();

    private Boolean                defaultAutoCommit;
    private Integer                defaultTransactionIsolation;
    private DatasourceSelectPolicy datasourceSelectPolicy;

    public LazyReplicationConnectionDataSourceProxy(DataSource master, List<DataSource> slaves) {
        this.master = master;
        this.slaves = slaves;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        // Determine default auto-commit and transaction isolation
        // via a Connection from the target DataSource, if possible.
        if (this.defaultAutoCommit == null || this.defaultTransactionIsolation == null) {
            try {
                Connection con = getMaster().getConnection();
                try {
                    checkDefaultConnectionProperties(con);
                } finally {
                    con.close();
                }
            } catch (SQLException ex) {
                logger.warn("Could not retrieve default auto-commit and transaction isolation settings", ex);
            }
        }

        if (null == datasourceSelectPolicy && !slaves.isEmpty()) {
            datasourceSelectPolicy = new RoundRobinDatasourceSelectPolicy();
        }
    }

    @Override
    public Connection getConnection() throws SQLException {
        return (Connection) Proxy.newProxyInstance(
                ReplicationConnectionProxy.class.getClassLoader(),
                new Class<?>[]{ReplicationConnectionProxy.class},
                new LazyReplicationConnectionInvocationHandler());
    }

    @Override
    public Connection getConnection(String username, String password) throws SQLException {
        return (Connection) Proxy.newProxyInstance(
                ReplicationConnectionProxy.class.getClassLoader(),
                new Class<?>[]{ReplicationConnectionProxy.class},
                new LazyReplicationConnectionInvocationHandler(username, password));
    }

    @Override
    public PrintWriter getLogWriter() throws SQLException {
        return getMaster().getLogWriter();
    }

    @Override
    public void setLogWriter(PrintWriter out) throws SQLException {
        getMaster().setLogWriter(out);
        getSlave().setLogWriter(out);
    }

    @Override
    public int getLoginTimeout() throws SQLException {
        return getMaster().getLoginTimeout();
    }

    @Override
    public void setLoginTimeout(int seconds) throws SQLException {
        getMaster().setLoginTimeout(seconds);
        getSlave().setLoginTimeout(seconds);
    }


    //---------------------------------------------------------------------
    // Implementation of JDBC 4.0's Wrapper interface
    //---------------------------------------------------------------------
    @Override
    @SuppressWarnings("unchecked")
    public <T> T unwrap(Class<T> iface) throws SQLException {
        if (iface.isInstance(this)) {
            return (T) this;
        }
        return getMaster().unwrap(iface);
    }

    @Override
    public boolean isWrapperFor(Class<?> iface) throws SQLException {
        return (iface.isInstance(this) || getMaster().isWrapperFor(iface));
    }

    //---------------------------------------------------------------------
    // Implementation of JDBC 4.1's getParentLogger method
    //---------------------------------------------------------------------
    public java.util.logging.Logger getParentLogger() {
        return java.util.logging.Logger.getLogger(java.util.logging.Logger.GLOBAL_LOGGER_NAME);
    }

    public DataSource getMaster() {
        return master;
    }

    public DataSource getSlave() {
        if (null == slaves || slaves.isEmpty()) {
            return master;
        }
        int select = datasourceSelectPolicy.select(slaves);
        return slaves.get(select);
    }

    public void setDefaultAutoCommit(boolean defaultAutoCommit) {
        this.defaultAutoCommit = defaultAutoCommit;
    }

    public void setDefaultTransactionIsolation(int defaultTransactionIsolation) {
        this.defaultTransactionIsolation = defaultTransactionIsolation;
    }

    /**
     * Check the default connection properties (auto-commit, transaction isolation),
     * keeping them to be able to expose them correctly without fetching an actual
     * JDBC Connection from the target DataSource.
     * <p>This will be invoked once on startup, but also for each retrieval of a
     * target Connection. If the check failed on startup (because the database was
     * down), we'll lazily retrieve those settings.
     *
     * @param con the Connection to use for checking
     * @throws SQLException if thrown by Connection methods
     */
    protected synchronized void checkDefaultConnectionProperties(Connection con) throws SQLException {
        if (this.defaultAutoCommit == null) {
            this.defaultAutoCommit = con.getAutoCommit();
        }
        if (this.defaultTransactionIsolation == null) {
            this.defaultTransactionIsolation = con.getTransactionIsolation();
        }
    }

    /**
     * Expose the default auto-commit value.
     */
    protected Boolean defaultAutoCommit() {
        return this.defaultAutoCommit;
    }

    /**
     * Expose the default transaction isolation value.
     */
    protected Integer defaultTransactionIsolation() {
        return this.defaultTransactionIsolation;
    }

    private interface ReplicationConnectionProxy extends Connection {
        Connection getReplicationTargetConnection();
    }

    /**
     * Invocation handler that defers fetching an actual JDBC Connection
     * until first creation of a Statement.
     */
    private class LazyReplicationConnectionInvocationHandler implements InvocationHandler {

        private String username;

        private String password;

        private Boolean readOnly = Boolean.FALSE;

        private Integer transactionIsolation;

        private Boolean autoCommit;

        private boolean closed = false;

        private Connection replicationTargetConnection;

        public LazyReplicationConnectionInvocationHandler() {
            this.autoCommit = defaultAutoCommit();
            this.transactionIsolation = defaultTransactionIsolation();
        }

        public LazyReplicationConnectionInvocationHandler(String username, String password) {
            this();
            this.username = username;
            this.password = password;
        }

        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            // Invocation on ReplicationConnectionProxy interface coming in...

            if (method.getName().equals("equals")) {
                // We must avoid fetching a target Connection for "equals".
                // Only consider equal when proxies are identical.
                return (proxy == args[0]);
            } else if (method.getName().equals("hashCode")) {
                // We must avoid fetching a target Connection for "hashCode",
                // and we must return the same hash code even when the target
                // Connection has been fetched: use hashCode of Connection proxy.
                return System.identityHashCode(proxy);
            } else if (method.getName().equals("unwrap")) {
                if (((Class<?>) args[0]).isInstance(proxy)) {
                    return proxy;
                }
            } else if (method.getName().equals("isWrapperFor")) {
                if (((Class<?>) args[0]).isInstance(proxy)) {
                    return true;
                }
            } else if (method.getName().equals("getReplicationTargetConnection")) {
                // Handle getReplicationTargetConnection method: return underlying connection.
                return getReplicationTargetConnection(method);
            }

            if (!hasTargetConnection()) {
                // No physical target Connection kept yet ->
                // resolve transaction demarcation methods without fetching
                // a physical JDBC Connection until absolutely necessary.

                if (method.getName().equals("toString")) {
                    return "Lazy Connection proxy for target write DataSource  [" + getMaster() + "] and target read DataSources [" + slaves + "]";
                } else if (method.getName().equals("isReadOnly")) {
                    return this.readOnly;
                } else if (method.getName().equals("setReadOnly")) {
                    this.readOnly = (Boolean) args[0];
                    return null;
                } else if (method.getName().equals("getTransactionIsolation")) {
                    if (this.transactionIsolation != null) {
                        return this.transactionIsolation;
                    }
                    // Else fetch actual Connection and check there,
                    // because we didn't have a default specified.
                } else if (method.getName().equals("setTransactionIsolation")) {
                    this.transactionIsolation = (Integer) args[0];
                    return null;
                } else if (method.getName().equals("getAutoCommit")) {
                    if (this.autoCommit != null) {
                        return this.autoCommit;
                    }
                    // Else fetch actual Connection and check there,
                    // because we didn't have a default specified.
                } else if (method.getName().equals("setAutoCommit")) {
                    this.autoCommit = (Boolean) args[0];
                    return null;
                } else if (method.getName().equals("commit")) {
                    // Ignore: no statements created yet.
                    return null;
                } else if (method.getName().equals("rollback")) {
                    // Ignore: no statements created yet.
                    return null;
                } else if (method.getName().equals("getWarnings")) {
                    return null;
                } else if (method.getName().equals("clearWarnings")) {
                    return null;
                } else if (method.getName().equals("close")) {
                    // Ignore: no target connection yet.
                    this.closed = true;
                    return null;
                } else if (method.getName().equals("isClosed")) {
                    return this.closed;
                } else if (this.closed) {
                    // Connection proxy closed, without ever having fetched a
                    // physical JDBC Connection: throw corresponding SQLException.
                    throw new SQLException("Illegal operation: connection is closed");
                }
            }

            // Target Connection already fetched,
            // or target Connection necessary for current operation ->
            // invoke method on target connection.
            try {
                return method.invoke(getReplicationTargetConnection(method), args);
            } catch (InvocationTargetException ex) {
                throw ex.getTargetException();
            }
        }

        /**
         * Return whether the proxy currently holds a target Connection.
         */
        private boolean hasTargetConnection() {
            return (this.replicationTargetConnection != null);
        }

        /**
         * Return the target Connection, fetching it and initializing it if necessary.
         */
        private Connection getReplicationTargetConnection(Method operation) throws SQLException {
            if (this.replicationTargetConnection == null) {
                logger.debug("Connecting to database for operation '{}'", operation.getName());

                logger.debug("current readOnly : {}", readOnly);
                DataSource targetDataSource = (readOnly == Boolean.TRUE) ? getSlave() : getMaster();

                // Fetch physical Connection from DataSource.
                this.replicationTargetConnection = (this.username != null) ?
                        targetDataSource.getConnection(this.username, this.password) :
                        targetDataSource.getConnection();

                // If we still lack default connection properties, check them now.
                checkDefaultConnectionProperties(this.replicationTargetConnection);

                // Apply kept transaction settings, if any.
                if (this.readOnly) {
                    try {
                        this.replicationTargetConnection.setReadOnly(this.readOnly);
                    } catch (Exception ex) {
                        // "read-only not supported" -> ignore, it's just a hint anyway
                        logger.debug("Could not set JDBC Connection read-only", ex);
                    }
                }
                if (this.transactionIsolation != null &&
                        !this.transactionIsolation.equals(defaultTransactionIsolation())) {
                    this.replicationTargetConnection.setTransactionIsolation(this.transactionIsolation);
                }
                if (this.autoCommit != null && this.autoCommit != this.replicationTargetConnection.getAutoCommit()) {
                    this.replicationTargetConnection.setAutoCommit(this.autoCommit);
                }
            } else {
                logger.debug("Using existing database connection for operation '{}'", operation.getName());
            }

            return this.replicationTargetConnection;
        }
    }
}
