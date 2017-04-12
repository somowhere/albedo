package com.albedo.java.test;

import com.albedo.java.grpc.server.GlobalServerInterceptorConfigurerAdapter;
import com.albedo.java.grpc.server.GlobalServerInterceptorRegistry;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GlobalInterceptorConfiguration {

    @Bean
    public GlobalServerInterceptorConfigurerAdapter globalInterceptorConfigurerAdapter() {
        return new GlobalServerInterceptorConfigurerAdapter() {
            @Override
            public void addServerInterceptors(GlobalServerInterceptorRegistry registry) {
                registry.addServerInterceptors(new LogGrpcInterceptor());
            }
        };
    }

}