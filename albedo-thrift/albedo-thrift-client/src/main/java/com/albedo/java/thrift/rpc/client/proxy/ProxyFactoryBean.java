package com.albedo.java.thrift.rpc.client.proxy;

import com.albedo.java.thrift.rpc.client.manage.Server;
import com.albedo.java.thrift.rpc.client.manage.ServerManager;
import com.albedo.java.thrift.rpc.client.thrift.ThriftClientPoolFactory;
import com.albedo.java.thrift.rpc.common.PoolOperationCallBack;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.thrift.TServiceClient;
import org.apache.thrift.TServiceClientFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;

import java.lang.reflect.Proxy;

public class ProxyFactoryBean<T> implements FactoryBean<T> {

    private Logger logger = LoggerFactory.getLogger(getClass());


    private ServerManager serverManager;

    private Class<?>  innerClass;

    public void setProccessName(String proccessName) {
        this.proccessName = proccessName;
    }

    private String proccessName;

    private ConfigurableListableBeanFactory factory;

    public void setServerManager(ServerManager serverManager) {
        this.serverManager = serverManager;
    }

    public void setInnerClass(Class<?> innerClass) {
        this.innerClass = innerClass;
    }

    public void setFactory(ConfigurableListableBeanFactory factory) {
        this.factory = factory;
    }

    private Integer maxActive = 32;// 最大活跃连接数

    private Integer idleTime = 180000;// ms,default 3 min,链接空闲时间, -1,关闭空闲检测

    private GenericObjectPool<TServiceClient> pool;

    private PoolOperationCallBack callback = new PoolOperationCallBack() {
        @Override
        public void make(TServiceClient client) {
            logger.info("create");
        }

        @Override
        public void destroy(TServiceClient client) {
            logger.info("destroy");
        }
    };


    private GenericObjectPool.Config  makePoolConfig() {
        GenericObjectPool.Config poolConfig = new GenericObjectPool.Config();
        poolConfig.maxActive = maxActive;
        poolConfig.maxIdle = 1;
        poolConfig.minIdle = 0;
        poolConfig.minEvictableIdleTimeMillis = idleTime;
        poolConfig.timeBetweenEvictionRunsMillis = idleTime * 2L;
        poolConfig.testOnBorrow=true;
        poolConfig.testOnReturn=false;
        poolConfig.testWhileIdle=false;
        return poolConfig;
    }

    @Override
    public T getObject() throws Exception {

        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();

        Server server = serverManager.getService(innerClass.getName());

        // 加载Iface接口
        innerClass = classLoader.loadClass(server.getName());
        String temp = server.getName().replace("$Iface", "");
        // 加载Client.Factory类
        Class<TServiceClientFactory<TServiceClient>> fi =
                (Class<TServiceClientFactory<TServiceClient>>) classLoader.
                        loadClass(temp + "$Client$Factory");
        TServiceClientFactory<TServiceClient> clientFactory = fi.newInstance();

        ThriftClientPoolFactory clientPool =
                new ThriftClientPoolFactory(server,
                        clientFactory, callback, proccessName);
        pool = new GenericObjectPool<TServiceClient>(clientPool, makePoolConfig());

        ServiceProxy serviceProxy = new ServiceProxy(pool);

        return (T)Proxy.newProxyInstance(innerClass.getClassLoader(),new Class[]{innerClass}, serviceProxy);

    }

    @Override
    public Class<?> getObjectType() {
        return innerClass;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }

    public void close() {
        if(pool!=null){
            try {
                pool.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}