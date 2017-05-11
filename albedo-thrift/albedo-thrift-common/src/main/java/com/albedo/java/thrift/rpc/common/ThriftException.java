package com.albedo.java.thrift.rpc.common;

/**
 * Created by chenshunyang on 2016/10/21.
 */
public class ThriftException extends RuntimeException{
    public ThriftException(){
        super();
    }

    public ThriftException(String msg){
        super(msg);
    }

    public ThriftException(Throwable e){
        super(e);
    }

    public ThriftException(String msg,Throwable e){
        super(msg,e);
    }
}
