package com.albedo.java.rpc.example.client.service.impl;

import com.albedo.java.rpc.example.client.service.HelloService;
import org.springframework.stereotype.Service;

/**
 * Created by lijie on 2017/3/27.
 */
@Service
public class HelloServiceImpl implements HelloService {

    @Override
    public String doSomething(String test) {
        System.out.println("hello:"+test);
        return  "hello:"+test;
    }
}
