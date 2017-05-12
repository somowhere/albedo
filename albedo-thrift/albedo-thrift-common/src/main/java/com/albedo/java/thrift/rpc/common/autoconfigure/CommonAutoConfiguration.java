package com.albedo.java.thrift.rpc.common.autoconfigure;

import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.thrift.rpc.common.config.ZookeeperProperties;
import lombok.extern.slf4j.Slf4j;
import org.apache.curator.RetryPolicy;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.CuratorFrameworkFactory;
import org.apache.curator.retry.ExponentialBackoffRetry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.EnvironmentAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import javax.annotation.Resource;

/**
 * Created by lijie on 9/7/16.
 */
@Configuration
@EnableConfigurationProperties({ZookeeperProperties.class,AlbedoRpcProperties.class})
public class CommonAutoConfiguration{

	 private Logger logger = LoggerFactory.getLogger(getClass());
	
    @Bean(destroyMethod = "close")
    @ConditionalOnMissingBean
    public CuratorFramework curatorFramework(ZookeeperProperties properties, AlbedoRpcProperties albedoRpcProperties, RetryPolicy retryPolicy) throws InterruptedException {
        CuratorFrameworkFactory.Builder builder = CuratorFrameworkFactory.builder();
        String namespace = albedoRpcProperties.getNamespace();
        logger.info("CuratorFramework namespace {}", namespace);
        CuratorFramework curator = builder
                .retryPolicy(retryPolicy)
                .canBeReadOnly(true)
                .namespace(namespace)
                .connectString(properties.getConnectString())
                .defaultData(null)
                .build();
        curator.blockUntilConnected(properties.getBlockUntilConnectedWait(),
                properties.getBlockUntilConnectedUnit());
        curator.start();
        return curator;
    }

    @Bean
    @ConditionalOnMissingBean
    public RetryPolicy exponentialBackoffRetry(ZookeeperProperties zookeeperProperties) {
        return new ExponentialBackoffRetry(zookeeperProperties.getBaseSleepTimeMs(),
                zookeeperProperties.getMaxRetries(),
                zookeeperProperties.getMaxSleepMs());
    }


}
