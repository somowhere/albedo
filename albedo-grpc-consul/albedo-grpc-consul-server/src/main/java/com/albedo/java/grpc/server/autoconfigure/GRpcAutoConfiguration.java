package com.albedo.java.grpc.server.autoconfigure;

import com.albedo.java.grpc.server.GRpcServerBuilderConfigurer;
import com.albedo.java.grpc.server.GRpcServerRunner;
import com.albedo.java.grpc.server.GRpcService;
import org.springframework.boot.autoconfigure.AutoConfigureOrder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by alexf on 25-Jan-16.
 */
@Configuration
@EnableConfigurationProperties(GRpcServerProperties.class)
@AutoConfigureOrder
public class GRpcAutoConfiguration {

    @Bean
    @ConditionalOnBean(annotation = GRpcService.class)
    public GRpcServerRunner grpcServerRunner(GRpcServerBuilderConfigurer configurer){
        return new GRpcServerRunner(configurer);
    }

    @Bean
    @ConditionalOnMissingBean(  GRpcServerBuilderConfigurer.class)
    public GRpcServerBuilderConfigurer serverBuilderConfigurer(){
        return new GRpcServerBuilderConfigurer();
    }
}
