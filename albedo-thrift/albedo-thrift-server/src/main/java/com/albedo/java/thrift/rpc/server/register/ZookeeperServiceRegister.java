package com.albedo.java.thrift.rpc.server.register;

import com.albedo.java.thrift.rpc.common.ThriftConstant;
import com.albedo.java.thrift.rpc.common.ThriftException;
import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.imps.CuratorFrameworkState;
import org.apache.zookeeper.CreateMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by lijie on 9/7/16.
 */
public class ZookeeperServiceRegister implements ServiceRegister {
    private Logger logger = LoggerFactory.getLogger(ZookeeperServiceRegister.class);
    public ZookeeperServiceRegister(CuratorFramework curatorFramework,
                                     AlbedoRpcProperties applicationProperties){
        this.curatorFramework=curatorFramework;
        this.applicationProperties=applicationProperties;
    }
    private CuratorFramework curatorFramework;
    private AlbedoRpcProperties applicationProperties;
    @Override
    public void register(String service, String version, String address) {
        if(curatorFramework.getState() == CuratorFrameworkState.LATENT){
            curatorFramework.start();
        }
        if (version == null || version == ""){
            version = ThriftConstant.DEFAULT_VERSION;
        }

        //创建临时节点
        try {
            String path = "/"+service+"/"+version+"/"+address;
            logger.info("register: {}", path);
            curatorFramework.create()
                    .creatingParentsIfNeeded()
                    .withMode(CreateMode.EPHEMERAL_SEQUENTIAL)
                    .forPath(path);
        } catch (Exception e) {
            logger.error("register service address to zookeeper exception:{}",e);
            throw new ThriftException("register service address to zookeeper exception:{}", e);
        }
    }

    public void close(){
        if(curatorFramework!=null)
        curatorFramework.close();
    }
}
