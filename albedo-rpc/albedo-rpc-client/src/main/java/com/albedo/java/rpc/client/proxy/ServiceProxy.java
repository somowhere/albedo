package com.albedo.java.rpc.client.proxy;

import com.albedo.java.rpc.client.manage.Server;
import com.albedo.java.rpc.client.manage.ServerManager;
import com.albedo.java.rpc.common.annotation.RpcServiceApiDescription;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.Response;
import com.albedo.java.util.PublicUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

/**
 * Created by lijie on 9/8/16.
 */
public class ServiceProxy implements InvocationHandler{
    protected Logger logger = LoggerFactory.getLogger(ServiceProxy.class);
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
        logger.debug("send Request {}", request);
        return response.getResult();
    }
}
