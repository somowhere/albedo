package com.albedo.java.thrift.rpc.common.exception;

/**
 * Created by lijie on 9/21/16.
 */
public class RpcException extends RuntimeException{
    public RpcException(String msg){
        super(msg);
    }
}
