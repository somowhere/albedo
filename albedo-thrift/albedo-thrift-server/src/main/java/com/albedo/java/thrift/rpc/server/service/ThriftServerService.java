package com.albedo.java.thrift.rpc.server.service;

import com.albedo.java.thrift.rpc.common.ThriftConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by lijie on 2017/5/12.
 *
 * @author 837158334@qq.com
 */
public abstract class ThriftServerService implements IThriftServerService {

    public final Logger logger = LoggerFactory.getLogger(this.getClass());

    public String getVersion(){
        return ThriftConstant.DEFAULT_VERSION;
    }

    public int getWeight() {
        return ThriftConstant.DEFAULT_WEIGHT;
    }

}
