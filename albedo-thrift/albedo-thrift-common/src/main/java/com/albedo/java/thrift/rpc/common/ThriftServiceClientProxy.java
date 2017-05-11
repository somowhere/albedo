package com.albedo.java.thrift.rpc.common;

import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.thrift.TServiceClient;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 * 客户端代理类
 * Created by chenshunyang on 2016/10/27.
 */
public class ThriftServiceClientProxy implements InvocationHandler {
    private GenericObjectPool<TServiceClient> pool;

    private TServiceClient client;

    public ThriftServiceClientProxy(GenericObjectPool<TServiceClient> pool){
        this.pool = pool;
    }

    public ThriftServiceClientProxy(TServiceClient client){
        this.client = client;
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
