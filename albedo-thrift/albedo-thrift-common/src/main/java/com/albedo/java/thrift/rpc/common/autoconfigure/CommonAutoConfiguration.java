package com.albedo.java.thrift.rpc.common.autoconfigure;

import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 9/7/16.
 */
@Configuration
@EnableConfigurationProperties({AlbedoRpcProperties.class})
public class CommonAutoConfiguration{

    private Logger logger = LoggerFactory.getLogger(getClass());


    @Bean(destroyMethod = "close")
    @ConditionalOnMissingBean
    public CuratorFramework curatorFramework(AlbedoRpcProperties albedoRpcProperties, RetryPolicy retryPolicy) throws InterruptedException {
        CuratorFrameworkFactory.Builder builder = CuratorFrameworkFactory.builder();
        String namespace = albedoRpcProperties.getNamespace();
        logger.info("CuratorFramework namespace {}", namespace);
        AlbedoRpcProperties.Zookeeper zookeeper = albedoRpcProperties.getZookeeper();
        CuratorFramework curator = builder
                .retryPolicy(retryPolicy)
                .canBeReadOnly(true)
                .namespace(namespace)
                .connectString(zookeeper.getConnectString())
                .defaultData(null)
                .build();
        curator.blockUntilConnected(zookeeper.getBlockUntilConnectedWait(),
                zookeeper.getBlockUntilConnectedUnit());
        curator.start();
        return curator;
    }

    @Bean
    @ConditionalOnMissingBean
    public RetryPolicy exponentialBackoffRetry(AlbedoRpcProperties albedoRpcProperties) {
        AlbedoRpcProperties.Zookeeper zookeeper = albedoRpcProperties.getZookeeper();
        return new ExponentialBackoffRetry(zookeeper.getBaseSleepTimeMs(),
                zookeeper.getMaxRetries(),
                zookeeper.getMaxSleepMs());
    }


}
