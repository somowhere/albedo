package com.albedo.java.thrift.rpc.server.map;

import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import org.apache.thrift.TProcessor;

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

    public ThriftServiceApi getServiceAnnotaion(String name){
        Object obj = map.get(name);
        Class[] interfaces=obj.getClass().getInterfaces();
        for(Class i:interfaces)
            if(i.getAnnotation(ThriftServiceApi.class)!=null){
                return (ThriftServiceApi) i.getAnnotation(ThriftServiceApi.class);
            }

        return null;
    }


    public Set<String> keySet() {
        return map.keySet();
    }
}
