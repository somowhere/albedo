package com.albedo.java.rpc.client.discover;

import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.imps.CuratorFrameworkState;
import org.apache.curator.framework.recipes.cache.PathChildrenCache;
import org.apache.curator.framework.recipes.cache.PathChildrenCacheEvent;
import com.albedo.java.rpc.client.manage.Handler;
import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by lijie on 9/8/16.
 */
public class ZookeeperServiceDiscover implements ServiceDiscover {
    private CuratorFramework curatorFramework;
    private AlbedoRpcProperties applicationProperties;
    private ConcurrentMap<String,ConcurrentMap<String,String>> map=null;
    private Handler addHandler;
    private Handler removeHandler;

    public ZookeeperServiceDiscover(CuratorFramework curatorFramework,AlbedoRpcProperties applicationProperties){
        this.curatorFramework=curatorFramework;
        this.applicationProperties=applicationProperties;
    }

    @Override
    public Map<String, Map<String,String>> discover() {
        Map<String,Map<String,String>> typeMap=new HashMap<>();
        for(String key:map.keySet()){
            typeMap.put(key,Collections.unmodifiableMap(map.get(key)));
        }
        return typeMap;
    }

    public void init() throws Exception {
        map=new ConcurrentHashMap<>();
        //List<String> pathList=curatorFramework.getChildren().forPath(applicationProperties.getRegisterPath());
//        for (String path:pathList){
//            String type=getType(path);
//            String data=new String(curatorFramework.getData().forPath(applicationProperties.getFullPath(path)));
//            addToMap(type,path,data);
//        }
    }
    @Override
    public void watchService() {
        // 如果zk尚未启动,则启动
        if (curatorFramework.getState() == CuratorFrameworkState.LATENT) {
            curatorFramework.start();
        }
        PathChildrenCache cache =new PathChildrenCache(curatorFramework,applicationProperties.getRegisterPath(),true);
        cache.getListenable().addListener((client,event)->{
            switch (event.getType()) {
                case CHILD_ADDED:
                    dealAdd(event);
                    break;
                case CHILD_REMOVED:
                    dealRemove(event);
                    break;
                default:
                    break;
            }
        });
        try {
            cache.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void dealAdd(PathChildrenCacheEvent event) {
        String[] paths=event.getData().getPath().split("/");
        String path=paths[paths.length-1];
        String type=getType(path);
        addToMap(type,path,new String(event.getData().getData()));
        if(addHandler!=null)
            addHandler.handle(type,path,new String(event.getData().getData()));
    }
    private void dealRemove(PathChildrenCacheEvent event) {
        String[] paths=event.getData().getPath().split("/");
        String path=paths[paths.length-1];
        String type=getType(path);
        removeFromMap(type,path);
        if(removeHandler!=null)
            removeHandler.handle(type,path,new String(event.getData().getData()));
    }
    private void addToMap(String type,String name,String url){
        map.putIfAbsent(type,new ConcurrentHashMap<>());
        map.get(type).put(name,url);
    }
    private void removeFromMap(String type,String name){
        //防止某个service上线马上下线,有可能导致removeFromMap先运行
        map.putIfAbsent(type,new ConcurrentHashMap<>());
        map.get(type).remove(name);
    }

    @Override
    public ServiceDiscover bindAddHandler(Handler handler){
        addHandler=handler;
        return this;
    }
    @Override
    public ServiceDiscover bindRemoveHandler(Handler handler){
        removeHandler=handler;
        return this;
    }


    private String getType(String name){
        int index=name.lastIndexOf("_");
        return name.substring(0,index);
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        try {
            init();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
