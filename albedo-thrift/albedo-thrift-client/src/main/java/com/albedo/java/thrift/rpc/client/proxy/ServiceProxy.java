package com.albedo.java.thrift.rpc.client.proxy;

import com.albedo.java.thrift.rpc.client.manage.Server;
import com.albedo.java.thrift.rpc.client.manage.ServerManager;
import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.thrift.TServiceClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 * Created by lijie on 9/8/16.
 */
public class ServiceProxy implements InvocationHandler{
    protected Logger logger = LoggerFactory.getLogger(ServiceProxy.class);

    private GenericObjectPool<TServiceClient> pool;

    public ServiceProxy(GenericObjectPool<TServiceClient> pool) {
        this.pool = pool;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

        TServiceClient client = pool.borrowObject();
        boolean flag = true;
        try {
            return method.invoke(client, args);
        } catch (Exception e) {
            flag = false;
            throw e;
        } finally {
            if(flag){
                pool.returnObject(client);
            }else{
                pool.invalidateObject(client);
            }
        }
    }
}
