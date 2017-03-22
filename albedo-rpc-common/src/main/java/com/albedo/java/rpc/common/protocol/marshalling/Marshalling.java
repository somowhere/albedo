package com.albedo.java.rpc.common.protocol.marshalling;


/**
 * Created by chenghao on 9/14/16.
 */
public interface Marshalling {
    <T> T decode(byte[] code, Class<T> clazz);
    byte[] encode(Object obj);
}
