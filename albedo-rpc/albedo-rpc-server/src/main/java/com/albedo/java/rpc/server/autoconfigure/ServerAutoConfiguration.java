package com.albedo.java.rpc.server.autoconfigure;

import com.albedo.java.rpc.common.autoconfigure.CommonAutoConfiguration;
import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import com.albedo.java.rpc.server.listener.ServiceMapListener;
import com.albedo.java.rpc.server.map.ServiceMap;
import com.albedo.java.rpc.server.netty.handler.NettyServer;
import com.albedo.java.rpc.server.register.ServiceRegister;
import com.albedo.java.rpc.server.register.ZookeeperServiceRegister;
import org.apache.curator.framework.CuratorFramework;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * Created by lijie on 9/7/16.
 */
@SuppressWarnings("SpringJavaAutowiringInspection")
@Configuration
@AutoConfigureAfter(value = {CommonAutoConfiguration.class})
public class ServerAutoConfiguration {
    @Bean
    @ConditionalOnMissingBean
    public ServiceRegister serviceRegister(CuratorFramework curatorFramework, AlbedoRpcProperties applicationProperties){
        return new ZookeeperServiceRegister(curatorFramework,applicationProperties);
    }

    @Bean
    public ServiceMapListener serviceMapListener(){
        return new ServiceMapListener();
    }

    @Bean(initMethod = "start" )
    public NettyServer nettyServer(ServiceMap map, Marshalling marshalling, AlbedoRpcProperties applicationProperties, ServiceRegister serviceRegister){
        return new NettyServer(marshalling,applicationProperties,map,serviceRegister);

    }




}
