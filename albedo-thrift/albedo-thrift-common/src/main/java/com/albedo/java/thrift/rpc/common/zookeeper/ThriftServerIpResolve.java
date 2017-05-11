package com.albedo.java.thrift.rpc.common.zookeeper;

/**
 * 解析thrift-server端IP地址，用于注册服务
 * 1) 可以从一个物理机器或者虚机的特殊文件中解析
 * 2) 可以获取指定网卡序号的Ip
 * 3) 其他
 * Created by chenshunyang on 2016/10/21.
 */
public interface ThriftServerIpResolve {
    String getServerIp() throws Exception;

    void reset();

    //当IP变更时,将会调用reset方法
    static interface IpRestCalllBack{
        public void rest(String newIp);
    }
}
