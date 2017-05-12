package com.albedo.java.thrift.rpc.server.map;

import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import org.apache.thrift.TProcessor;

import java.lang.annotation.Annotation;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Created by lijie on 9/19/16.
 */
public class ServiceMap {
    private Map<String,Object> map=new HashMap<>();
    public void addService(String name, Object service){
        map.put(name,service);
    }
    public Object getService(String name){
        return map.get(name);
    }


    public Set<String> keySet() {
        return map.keySet();
    }
}
