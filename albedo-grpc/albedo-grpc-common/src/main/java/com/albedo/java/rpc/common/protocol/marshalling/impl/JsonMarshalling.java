package com.albedo.java.rpc.common.protocol.marshalling.impl;

import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import com.alibaba.fastjson.JSON;

/**
 * Created by lijie on 9/14/16.
 */
public class JsonMarshalling implements Marshalling {

    @Override
    public <T> T decode(byte[] code, Class<T> clazz) {
        return JSON.parseObject(new String(code),clazz);
    }

    @Override
    public byte[] encode(Object obj) {
        return JSON.toJSONString(obj).getBytes();
    }
}
