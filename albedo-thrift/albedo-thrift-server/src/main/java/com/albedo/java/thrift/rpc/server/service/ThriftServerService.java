package com.albedo.java.thrift.rpc.server.service;

import com.albedo.java.thrift.rpc.common.ThriftConstant;

/**
 * Created by lijie on 2017/5/12.
 *
 * @author 837158334@qq.com
 */
public abstract class ThriftServerService implements IThriftServerService {

    public String getVersion(){
        return ThriftConstant.DEFAULT_VERSION;
    }

    public int getWeight() {
        return ThriftConstant.DEFAULT_WEIGHT;
    }

}
