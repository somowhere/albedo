package com.albedo.java.thrift.rpc.client.exception;


import com.albedo.java.thrift.rpc.common.exception.RpcException;

/**
 * Created by lijie on 9/21/16.
 */
public class NoSupportServiceException extends RpcException {
    public NoSupportServiceException(String type){
        super("No support service for "+type);
    }
}
