package com.albedo.java.rpc.server.listener;

import com.albedo.java.rpc.common.annotation.RpcServiceApiDescription;
import com.albedo.java.rpc.server.map.ServiceMap;
import org.springframework.context.ApplicationListener;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.Map;

/**
 * Created by lijie on 9/21/16.
 */
public class ServiceMapListener implements ApplicationListener<ContextRefreshedEvent>{
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        ConfigurableApplicationContext applicationContext=(ConfigurableApplicationContext)event.getApplicationContext();
        ServiceMap serviceMap=new ServiceMap();
        Map<String,Object> map=applicationContext.getBeansWithAnnotation(RpcServiceApiDescription.class);
        for(String name:map.keySet()){
            Object obj=map.get(name);
            Class[] interfaces=obj.getClass().getInterfaces();
            for(Class i:interfaces)
                if(i.getAnnotation(RpcServiceApiDescription.class)!=null){
                    serviceMap.addService(i.getName(),obj);
                }

        }
        applicationContext.getBeanFactory().registerSingleton(serviceMap.getClass().getName(),serviceMap);
    }
}
