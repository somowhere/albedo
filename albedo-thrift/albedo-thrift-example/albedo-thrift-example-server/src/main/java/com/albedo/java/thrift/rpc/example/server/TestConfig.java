package com.albedo.java.thrift.rpc.example.server;

import com.albedo.java.thrift.rpc.example.EchoSerivce;
import com.albedo.java.thrift.rpc.server.map.ServiceMap;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 2017/5/10.
 *
 * @author 837158334@qq.com
 */
@Configuration
public class TestConfig {

    @Bean
    public ServiceMap serviceMap(EchoSerivce.Iface echoSerivce){
        ServiceMap serviceMap=new ServiceMap();
        serviceMap.addService(EchoSerivce.Iface.class.getName(),echoSerivce);
        return serviceMap;
    }

}
