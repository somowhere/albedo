package com.albedo.java.thrift.rpc.client.manage;

import com.albedo.java.thrift.rpc.client.discover.ServiceDiscover;
import com.albedo.java.thrift.rpc.client.exception.NoSupportServiceException;
import com.albedo.java.thrift.rpc.client.route.ServiceRouter;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by lijie on 9/8/16.
 */
public class ServerManager {


    public ConcurrentMap<String,List<Server>> serviceMap=new ConcurrentHashMap<>();

    private ServiceDiscover serviceDiscover;
    private ServiceRouter serviceRouter;

    public ServerManager(ServiceDiscover serviceDiscover, ServiceRouter serviceRouter){
        this.serviceDiscover=serviceDiscover;
        this.serviceRouter = serviceRouter;
        init();
    }

    public void init(){

        serviceDiscover.bindAddHandler((String name, String version, String url)->{
            serviceMap.putIfAbsent(name,new ArrayList<>());
            Server server =new Server(name,version,url);
            List list=serviceMap.get(name);
            synchronized (list){
                list.add(server);
            }
        }).bindRemoveHandler((String name, String version, String url)->{
            serviceMap.putIfAbsent(name,new ArrayList<>());
            List<Server> list=serviceMap.get(name);
            synchronized (list){
                for(int i=list.size()-1;i>=0;i--){
                    if(list.get(i).getName().equals(name)){
                        list.remove(i);
                        break;
                    }
                }
            }
        }).watchService();

        Map<String,Map<String,String>> map=serviceDiscover.discover();
        for(String key:map.keySet()){
            Map<String,String> tmp=map.get(key);
            List<Server> tmpList=new ArrayList<>();
            for(String itemKey:tmp.keySet())
                tmpList.add(new Server(key,itemKey,tmp.get(itemKey)));
            serviceMap.put(key,tmpList);
        }

    }


    public Server getService(String type){
        List<Server> list=serviceMap.get(type);
        if(list==null || list.isEmpty())
            throw new NoSupportServiceException(type);
        synchronized (list){
            return serviceRouter.route(list);
        }
    }

}
