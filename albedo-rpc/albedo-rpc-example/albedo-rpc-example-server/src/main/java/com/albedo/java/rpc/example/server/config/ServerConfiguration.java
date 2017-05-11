package com.albedo.java.rpc.example.server.config;

import com.albedo.java.rpc.server.map.ServiceMap;
import com.albedo.java.rpc.example.client.service.HelloService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/19/16.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")
@Configuration
public class ServerConfiguration {

    @Bean
    public ServiceMap serviceMap(HelloService helloService){
        ServiceMap serviceMap=new ServiceMap();
        serviceMap.addService(HelloService.class.getName(),helloService);
        return serviceMap;
    }

}
