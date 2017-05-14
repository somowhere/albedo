package com.albedo.java.thrift.rpc.common.autoconfigure;

import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.util.concurrent.TimeUnit;

/**
 * Created by lijie on 9/7/16.
 */
@Configuration
@EnableConfigurationProperties({AlbedoRpcProperties.class})
public class CommonAutoConfiguration implements EnvironmentAware{

    private Environment environment;

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public void setEnvironment(Environment environment) {
        this.environment = environment;
    }


    @Bean(destroyMethod = "close")
    @ConditionalOnMissingBean
    public CuratorFramework curatorFramework(AlbedoRpcProperties albedoRpcProperties, RetryPolicy retryPolicy) throws InterruptedException {
        CuratorFrameworkFactory.Builder builder = CuratorFrameworkFactory.builder();
        String namespace = environment.getProperty("albedo.rpc.namespace", albedoRpcProperties.getNamespace());
        AlbedoRpcProperties.Zookeeper zookeeper = albedoRpcProperties.getZookeeper();
        String connectString = environment.getProperty("albedo.rpc.zookeeper.connectString", zookeeper.getConnectString());
        Integer blockUntilConnectedWait = Integer.parseInt(environment.getProperty("albedo.rpc.zookeeper.blockUntilConnectedWait",
                zookeeper.getBlockUntilConnectedWait()+""));
        logger.info("CuratorFramework namespace {}", namespace);
        CuratorFramework curator = builder
                .retryPolicy(retryPolicy)
                .canBeReadOnly(true)
                .namespace(namespace)
                .connectString(connectString)
                .defaultData(null)
                .build();
        curator.blockUntilConnected(blockUntilConnectedWait,
                TimeUnit.SECONDS);
        curator.start();
        return curator;
    }

    @Bean
    @ConditionalOnMissingBean
    public RetryPolicy exponentialBackoffRetry(AlbedoRpcProperties albedoRpcProperties) {
        AlbedoRpcProperties.Zookeeper zookeeper = albedoRpcProperties.getZookeeper();
        Integer baseSleepTimeMs = Integer.parseInt(environment.getProperty("albedo.rpc.zookeeper.baseSleepTimeMs",
                zookeeper.getBaseSleepTimeMs()+"")),
                maxRetries = Integer.parseInt(environment.getProperty("albedo.rpc.zookeeper.maxRetries",
                zookeeper.getMaxRetries()+"")),
                maxSleepMs = Integer.parseInt(environment.getProperty("albedo.rpc.zookeeper.maxSleepMs",
                        zookeeper.getMaxSleepMs()+""));
        return new ExponentialBackoffRetry(baseSleepTimeMs,
                maxRetries, maxSleepMs);
    }



}
