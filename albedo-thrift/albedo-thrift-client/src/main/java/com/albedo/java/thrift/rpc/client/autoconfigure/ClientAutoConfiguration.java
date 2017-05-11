package com.albedo.java.thrift.rpc.client.autoconfigure;

import com.albedo.java.thrift.rpc.client.discover.ServiceDiscover;
import com.albedo.java.thrift.rpc.client.discover.ZookeeperServiceDiscover;
import com.albedo.java.thrift.rpc.client.manage.ServerManager;
import com.albedo.java.thrift.rpc.client.proxy.ServiceProxy;
import com.albedo.java.thrift.rpc.client.route.RandomServiceRouter;
import com.albedo.java.thrift.rpc.client.route.ServiceRouter;
import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import org.apache.commons.pool.impl.GenericObjectPool;
import org.apache.curator.framework.CuratorFramework;
import org.apache.thrift.TServiceClient;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/7/16.
 */

@Configuration
public class ClientAutoConfiguration {


    @Bean
    @ConditionalOnMissingBean
    public ServiceRouter serviceRouter(){
        return new RandomServiceRouter();
    }

}
