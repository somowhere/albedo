package com.albedo.java.rpc.client.manage;

import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import com.albedo.java.rpc.client.discover.ServiceDiscover;
import com.albedo.java.rpc.client.exception.NoSupportServiceException;
import com.albedo.java.rpc.client.route.ServiceRouter;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
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
public class ServerManager implements ApplicationListener<ContextRefreshedEvent> {
    public ConcurrentMap<String,List<Server>> serviceMap=new ConcurrentHashMap<>();

    private ServiceDiscover serviceDiscover;
    private EventLoopGroup eventLoopGroup;
    private ServiceRouter serviceRouter;
    private Marshalling marshalling;

    public ServerManager(ServiceDiscover serviceDiscover, ServiceRouter serviceRouter, Marshalling marshalling){
        this.serviceDiscover=serviceDiscover;
        this.serviceRouter = serviceRouter;
        this.marshalling=marshalling;
    }

    public void init(){
        eventLoopGroup=new NioEventLoopGroup();
        Map<String,Map<String,String>> map=serviceDiscover.discover();
        for(String key:map.keySet()){
            Map<String,String> tmp=map.get(key);
            List<Server> tmpList=new ArrayList<>();
            for(String itemKey:tmp.keySet())
                tmpList.add(new Server(key,itemKey,tmp.get(itemKey),eventLoopGroup,marshalling));
            serviceMap.put(key,tmpList);
        }
        serviceDiscover
                .bindAddHandler((type,name,url)->{
            serviceMap.putIfAbsent(type,new ArrayList<>());
            Server server =new Server(type,name,url,eventLoopGroup,marshalling);
            List list=serviceMap.get(type);
            synchronized (list){
                list.add(server);
            }
        })
                .bindRemoveHandler((type,name,url)->{
            serviceMap.putIfAbsent(type,new ArrayList<>());
            List<Server> list=serviceMap.get(type);
            synchronized (list){
                for(int i=list.size()-1;i>=0;i--){
                    if(list.get(i).getName().equals(name)){
                        list.remove(i);
                        break;
                    }
                }
            }
        }).watchService();
    }


    public Server getService(String type){
        List<Server> list=serviceMap.get(type);
        if(list==null || list.isEmpty())
            throw new NoSupportServiceException(type);
        synchronized (list){
            return serviceRouter.route(list);
        }
    }


    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        init();
    }
}
