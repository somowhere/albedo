package com.albedo.java.rpc.server.register;

import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import org.apache.curator.framework.CuratorFramework;
import org.apache.zookeeper.CreateMode;

/**
 * Created by lijie on 9/7/16.
 */
public class ZookeeperServiceRegister implements ServiceRegister {
    public ZookeeperServiceRegister(CuratorFramework curatorFramework, AlbedoRpcProperties applicationProperties){
        this.curatorFramework=curatorFramework;
        this.applicationProperties=applicationProperties;
    }
    private CuratorFramework curatorFramework;
    private AlbedoRpcProperties applicationProperties;
    private String path;

    public void register() throws Exception {
        if(curatorFramework.checkExists().forPath(applicationProperties.getRegisterPath())==null)
            curatorFramework.create().withMode(CreateMode.PERSISTENT).forPath(applicationProperties.getRegisterPath());
        path=curatorFramework.create().withMode(CreateMode.EPHEMERAL_SEQUENTIAL).forPath(applicationProperties.getFullPath()+"_",applicationProperties.getHostUrl().getBytes());
    }
}
