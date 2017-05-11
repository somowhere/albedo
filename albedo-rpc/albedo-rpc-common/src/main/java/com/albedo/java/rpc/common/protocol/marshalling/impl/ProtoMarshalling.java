package com.albedo.java.rpc.common.protocol.marshalling.impl;

import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import com.albedo.java.rpc.common.utils.SerializationUtil;
import com.alibaba.fastjson.JSON;

/**
 * Created by lijie on 9/14/16.
 */
public class ProtoMarshalling implements Marshalling {

    @Override
    public <T> T decode(byte[] code, Class<T> clazz) {

        return SerializationUtil.deserialize(code, clazz);
    }

    @Override
    public byte[] encode(Object obj) {
        return SerializationUtil.serialize(obj);
    }
}
