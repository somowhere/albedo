package com.albedo.java.grpc.client.config;

import com.albedo.java.grpc.client.DiscoveryClientChannelFactory;

import com.albedo.java.grpc.client.service.UserServiceGrpc;
import io.grpc.Channel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/19/16.
 */
@Configuration
public class ServiceConfiguration {

    @Value("${grpc.server.name}")
    public String grpcServerName;

    @Bean
    public Channel channel(DiscoveryClientChannelFactory discoveryClientChannelFactory){
        return discoveryClientChannelFactory.createChannel(grpcServerName);
    }

    @Bean
    public UserServiceGrpc.UserServiceBlockingStub serviceStarter(Channel channel){
        return UserServiceGrpc.newBlockingStub(channel);
    }

}
