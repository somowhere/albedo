package com.albedo.java.rpc.client.autoconfigure;

import com.fasterxml.jackson.core.util.DefaultIndenter;
import org.apache.curator.framework.CuratorFramework;
import com.albedo.java.rpc.client.discover.ServiceDiscover;
import com.albedo.java.rpc.client.discover.ZookeeperServiceDiscover;
import com.albedo.java.rpc.client.manage.ServerManager;
import com.albedo.java.rpc.client.proxy.ServiceProxy;
import com.albedo.java.rpc.client.route.RandomServiceRouter;
import com.albedo.java.rpc.client.route.ServiceRouter;
import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/7/16.
 */

@Configuration
public class ClientAutoConfiguration {
//    @Value("${albedo.rpc.registerPath}")
//    private String registerPath;

    @Bean
    @ConditionalOnMissingBean
    public ServiceDiscover serviceDiscover(CuratorFramework curatorFramework,
                                           AlbedoRpcProperties applicationProperties){
//        if(registerPath!=null)applicationProperties.setRegisterPath(registerPath);
        return new ZookeeperServiceDiscover(curatorFramework,applicationProperties);
    }

    @Bean
    @ConditionalOnMissingBean
    public ServiceRouter serviceRouter(){
        return new RandomServiceRouter();
    }

    @Bean
    public ServerManager serviceManage(ServiceDiscover serviceDiscover, ServiceRouter serviceRouter, Marshalling marshalling){
        return new ServerManager(serviceDiscover,serviceRouter,marshalling);
    }

    @Bean
    public ServiceProxy serviceProxy(ServerManager serverManager){
        return new ServiceProxy(serverManager);
    }

}
