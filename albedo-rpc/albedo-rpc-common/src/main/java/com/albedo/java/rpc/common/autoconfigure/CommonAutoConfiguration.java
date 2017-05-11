package com.albedo.java.rpc.common.autoconfigure;

import com.albedo.java.rpc.common.protocol.marshalling.impl.ProtoMarshalling;
import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;
import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.rpc.common.config.ZookeeperProperties;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import com.albedo.java.rpc.common.protocol.marshalling.impl.JsonMarshalling;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/7/16.
 */
@Configuration
@EnableConfigurationProperties({AlbedoRpcProperties.class,ZookeeperProperties.class})
public class CommonAutoConfiguration {

//    @Value("${albedo.zookeeper.connectString}")
//    private String connectString;

    @Bean(destroyMethod = "close")
    @ConditionalOnMissingBean
    public CuratorFramework curatorFramework(ZookeeperProperties properties, RetryPolicy retryPolicy) throws InterruptedException {
//        if(connectString!=null) properties.setConnectString(connectString);
        CuratorFrameworkFactory.Builder builder = CuratorFrameworkFactory.builder();
        CuratorFramework curator = builder
                .retryPolicy(retryPolicy)
                .connectString(properties.getConnectString())
                .build();
        curator.start();
        curator.blockUntilConnected(properties.getBlockUntilConnectedWait(), properties.getBlockUntilConnectedUnit());
        return curator;
    }
    @Bean
    @ConditionalOnMissingBean
    public RetryPolicy exponentialBackoffRetry(ZookeeperProperties zookeeperProperties) {
        return new ExponentialBackoffRetry(zookeeperProperties.getBaseSleepTimeMs(),
                zookeeperProperties.getMaxRetries(),
                zookeeperProperties.getMaxSleepMs());
    }


    @Bean
    @ConditionalOnMissingBean
    public Marshalling marshalling(){
        return new ProtoMarshalling();
    }
}
