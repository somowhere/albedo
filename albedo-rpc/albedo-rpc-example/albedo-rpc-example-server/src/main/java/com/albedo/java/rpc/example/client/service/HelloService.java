package com.albedo.java.rpc.example.client.service;

import com.albedo.java.rpc.common.annotation.RpcServiceApiDescription;

/**
 * Created by lijie on 2017/3/27.
 */
@RpcServiceApiDescription(group = "test1")
public interface HelloService {

    public String doSomething(String test);

}
