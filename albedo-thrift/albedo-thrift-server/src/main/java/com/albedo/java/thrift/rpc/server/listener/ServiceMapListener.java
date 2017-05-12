package com.albedo.java.thrift.rpc.server.listener;

import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import com.albedo.java.thrift.rpc.server.map.ServiceMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.Map;

/**
 * Created by lijie on 9/21/16.
 */
public class ServiceMapListener implements ApplicationListener<ContextRefreshedEvent>{

    private Logger logger = LoggerFactory.getLogger(ServiceMapListener.class);

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        ConfigurableApplicationContext applicationContext = (ConfigurableApplicationContext)event.getApplicationContext();
        Map<String,Object> beansWithAnnotation = applicationContext.getBeansWithAnnotation(ThriftServiceApi.class);
        ServiceMap serviceMap=new ServiceMap();
        for(String name:beansWithAnnotation.keySet()){
            Object obj = beansWithAnnotation.get(name);
            Class[] interfaces=obj.getClass().getInterfaces();
            for(Class i:interfaces)
                if(i.getAnnotation(ThriftServiceApi.class)!=null){
                    serviceMap.addService(i.getName(),obj);
                }

        }
        applicationContext.getBeanFactory().registerSingleton(serviceMap.getClass().getName(),serviceMap);
    }
}
