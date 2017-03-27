package com.albedo.java.rpc.server.map;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lijie on 9/19/16.
 */
public class ServiceMap {
    private Map<String,Object> map=new HashMap<>();
    public void addService(String name,Object service){
        map.put(name,service);
    }
    public Object getService(String name){
        return map.get(name);
    }
}
