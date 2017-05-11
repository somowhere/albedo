package com.albedo.java.thrift.rpc.server.service;

import org.apache.thrift.TProcessor;

/**
 * Created by chenshunyang on 2016/9/23.
 */
public interface ThriftServerService {

    TProcessor getProcessor(ThriftServerService bean);
}
