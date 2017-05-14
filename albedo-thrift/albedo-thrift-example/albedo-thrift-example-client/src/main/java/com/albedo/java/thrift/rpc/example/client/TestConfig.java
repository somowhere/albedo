package com.albedo.java.thrift.rpc.example.client;

import com.albedo.java.thrift.rpc.client.proxy.ServiceStarter;
import com.albedo.java.thrift.rpc.client.route.ServiceRouter;
import com.albedo.java.thrift.rpc.common.vo.ServiceApi;
import com.albedo.java.thrift.rpc.example.EchoSerivce;
import org.apache.curator.framework.CuratorFramework;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by lijie on 2017/5/10.
 *
 * @author 837158334@qq.com
 */
@Configuration
public class TestConfig {

    @Bean
    public ServiceStarter serviceMap(){
        return new ServiceStarter()
                .startService(EchoSerivce.Iface.class, ServiceApi.create("echoSerivce"));
    }

}
