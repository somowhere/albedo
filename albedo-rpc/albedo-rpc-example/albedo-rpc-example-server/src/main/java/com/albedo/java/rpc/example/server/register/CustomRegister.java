package com.albedo.java.rpc.example.server.register;


import com.albedo.java.rpc.server.register.ServiceRegister;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by lijie on 9/8/16.
 */
//@Component
public class CustomRegister implements ServiceRegister {
    @Override
    @PostConstruct
    public void register() throws Exception {
        System.out.println("CustomRegister");
    }
}
