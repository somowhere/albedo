package com.albedo.java.thrift.rpc.server.autoconfigure;

import com.albedo.java.thrift.rpc.common.autoconfigure.CommonAutoConfiguration;
import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.thrift.rpc.server.ThriftServer;
import com.albedo.java.thrift.rpc.server.listener.ServiceMapListener;
import com.albedo.java.thrift.rpc.server.map.ServiceMap;
import com.albedo.java.thrift.rpc.server.register.ServiceRegister;
import com.albedo.java.thrift.rpc.server.register.ZookeeperServiceRegister;
import org.apache.curator.framework.CuratorFramework;
import org.apache.thrift.protocol.TJSONProtocol;
import org.apache.thrift.protocol.TProtocolFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


@Configuration
@AutoConfigureAfter(value = {CommonAutoConfiguration.class})
@EnableAspectJAutoProxy
public class ServerAutoConfiguration {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Bean(destroyMethod = "close")
    @ConditionalOnMissingBean
    public ServiceRegister serviceRegister(CuratorFramework curatorFramework,
                                           AlbedoRpcProperties applicationProperties){
        return new ZookeeperServiceRegister(curatorFramework, applicationProperties);
    }

    /**
     * 如果没有设置序列化协议,使用JSON协议
     *
     * @return
     */
    @Bean
    @ConditionalOnMissingBean(TProtocolFactory.class)
    public TProtocolFactory tProtocolFactory() {
        logger.info("init default TProtocol use TJSONProtocol");
        return new TJSONProtocol.Factory();
    }


    @Bean(initMethod = "start",destroyMethod = "stop")
    public ThriftServer thriftServer(TProtocolFactory tProtocolFactory, AlbedoRpcProperties applicationProperties,
                                     ServiceMap serviceMap, ServiceRegister serviceRegister){
        return new ThriftServer(tProtocolFactory, applicationProperties,
                serviceMap, serviceRegister);
    }

    @Bean
    public ServiceMapListener serviceMapListener(){
        return new ServiceMapListener();
    }

}
