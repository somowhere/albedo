package com.albedo.java.grpc.test;

import com.albedo.java.grpc.client.EurekaClientInstance;
import com.albedo.java.grpc.client.GlobalClientInterceptorConfigurerAdapter;
import com.albedo.java.grpc.client.GlobalClientInterceptorRegistry;
import com.netflix.appinfo.ApplicationInfoManager;
import com.netflix.appinfo.MyDataCenterInstanceConfig;
import com.netflix.discovery.DefaultEurekaClientConfig;
import com.netflix.discovery.DiscoveryClient;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.core.env.Environment;

@Order(Ordered.LOWEST_PRECEDENCE)
@Configuration
public class GlobalClientInterceptorConfiguration {
    @Bean
    public GlobalClientInterceptorConfigurerAdapter globalInterceptorConfigurerAdapter() {
        return new GlobalClientInterceptorConfigurerAdapter() {

            @Override
            public void addClientInterceptors(GlobalClientInterceptorRegistry registry) {
                registry.addClientInterceptors(new LogGrpcInterceptor());
            }
        };
    }

}