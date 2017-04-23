package com.albedo.java.config;

import com.albedo.java.core.ExampleEurekaClient;
import com.albedo.java.grpc.client.GrpcChannelFactory;
import com.netflix.appinfo.ApplicationInfoManager;
import com.netflix.appinfo.MyDataCenterInstanceConfig;
import com.netflix.discovery.DefaultEurekaClientConfig;
import com.netflix.discovery.EurekaClient;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;

/**
 * Created by somewhere on 2017/4/23.
 */
@Configuration
@EnableConfigurationProperties
public class AutoEruekaConfig {

    @Bean
    public EurekaClient eurekaClient(){
        // create the client
        ApplicationInfoManager applicationInfoManager = ExampleEurekaClient.initializeApplicationInfoManager(new MyDataCenterInstanceConfig());
        EurekaClient client = ExampleEurekaClient.initializeEurekaClient(applicationInfoManager, new DefaultEurekaClientConfig());
        return  client;
    }


}
