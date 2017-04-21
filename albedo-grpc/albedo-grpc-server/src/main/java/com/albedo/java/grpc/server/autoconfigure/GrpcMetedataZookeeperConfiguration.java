package com.albedo.java.grpc.server.autoconfigure;

import com.netflix.appinfo.EurekaInstanceConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.zookeeper.config.ZookeeperConfigProperties;
import org.springframework.cloud.zookeeper.discovery.ZookeeperDiscoveryProperties;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
@Configuration
@EnableConfigurationProperties
//@ConditionalOnBean(ZookeeperDiscoveryProperties.class)
public class GrpcMetedataZookeeperConfiguration {

    @Autowired
    private ZookeeperDiscoveryProperties zookeeperDiscoveryProperties;

    @Autowired
    private GrpcServerProperties grpcProperties;

    @PostConstruct
    public void init() {
        this.zookeeperDiscoveryProperties.getMetadata().put("gRPC", String.valueOf(grpcProperties.getPort()));
    }
}