package com.qingju.java.mpns.rpc.server.service;

import com.albedo.java.rpc.common.annotation.RpcServiceApiDescription;

/**
 * Created by lijie on 2017/3/27.
 */
@RpcServiceApiDescription(group = "test1")
public interface HelloService {

    public void doSomething(String test);

}
