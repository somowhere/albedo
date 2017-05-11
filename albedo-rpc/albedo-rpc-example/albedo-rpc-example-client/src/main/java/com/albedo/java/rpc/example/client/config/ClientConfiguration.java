package com.albedo.java.rpc.example.client.config;

import com.albedo.java.rpc.client.proxy.ServiceStarter;
import com.albedo.java.rpc.example.client.service.HelloService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/19/16.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")
@Configuration
public class ClientConfiguration {

    @Bean
    public ServiceStarter serviceStarter(){
        ServiceStarter serviceStarter=new ServiceStarter();
        return serviceStarter.startService(HelloService.class);
    }

}
