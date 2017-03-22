package com.albedo.java.rpc.client.proxy;

import com.albedo.java.rpc.client.manage.Server;
import com.albedo.java.rpc.client.manage.ServerManager;
import com.albedo.java.rpc.common.annotation.RpcServiceApiDescription;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.Response;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

/**
 * Created by chenghao on 9/8/16.
 */
public class ServiceProxy implements InvocationHandler{
    private ServerManager serverManager;
    public ServiceProxy(ServerManager serverManager){
        this.serverManager = serverManager;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        Request request=new Request();
        request.setClassName(method.getDeclaringClass().getName());
        request.setMethodName(method.getName());
        request.setParamsType(method.getParameterTypes());
        request.setParams(args);
        request.setRequestId(UUID.randomUUID().toString());
        Server server = serverManager.getService(method.getDeclaringClass().getDeclaredAnnotation(RpcServiceApiDescription.class).group());
        CompletableFuture<Response> future= server.sendRequest(request);
        Response response=future.get();
        System.out.println(request);
        return response.getResult();
    }
}
