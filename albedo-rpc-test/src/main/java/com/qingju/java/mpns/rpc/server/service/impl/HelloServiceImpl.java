package com.qingju.java.mpns.rpc.server.service.impl;

import com.qingju.java.mpns.rpc.server.service.HelloService;
import org.springframework.stereotype.Service;

/**
 * Created by lijie on 2017/3/27.
 */
@Service
public class HelloServiceImpl implements HelloService {

    @Override
    public void doSomething(String test) {
        System.out.println("hello:"+test);
    }
}
