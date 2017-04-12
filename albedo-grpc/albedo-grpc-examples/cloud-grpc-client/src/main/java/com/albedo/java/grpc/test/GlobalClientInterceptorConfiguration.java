package com.albedo.java.grpc.test;

import com.albedo.java.grpc.client.GlobalClientInterceptorConfigurerAdapter;
import com.albedo.java.grpc.client.GlobalClientInterceptorRegistry;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;

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