package com.albedo.java.thrift.rpc.client.discover;

import com.albedo.java.thrift.rpc.client.manage.Handler;
import org.apache.curator.framework.CuratorFramework;
import org.apache.curator.framework.recipes.cache.PathChildrenCache;
import org.apache.curator.framework.recipes.cache.PathChildrenCacheEvent;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.CountDownLatch;

/**
 * Created by lijie on 9/8/16.
 */
public class ZookeeperServiceDiscover implements ServiceDiscover {
    private Logger logger = LoggerFactory.getLogger(getClass());
    private CuratorFramework curatorFramework;
    private PathChildrenCache cache;
    private ConcurrentMap<String,ConcurrentMap<String,String>> map = new ConcurrentHashMap<>();
    private Handler addHandler;
    private Handler removeHandler;

    private String path;

    private CountDownLatch countDownLatch= new CountDownLatch(1);//避免 zk还没有连接上，就去调用服务


    public ZookeeperServiceDiscover(CuratorFramework curatorFramework,String path){
        this.curatorFramework=curatorFramework;
        this.path = path;
    }

    @Override
    public Map<String, Map<String,String>> discover() {
        Map<String,Map<String,String>> typeMap=new HashMap<>();
        for(String key:map.keySet()){
            typeMap.put(key,Collections.unmodifiableMap(map.get(key)));
        }
        return typeMap;
    }

    @Override
    public void close() {
        try {
            cache.close();
            curatorFramework.close();
        } catch (Exception e) {
        }
    }

    @Override
    public void watchService() {
        logger.info("watchService {}", path);
        cache =new PathChildrenCache(curatorFramework, path
                ,true);
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
//          PathChildrenCache.StartMode.POST_INITIALIZED_EVENT
            cache.start();
//            countDownLatch.await();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void dealAdd(PathChildrenCacheEvent event) {
        String[] paths=event.getData().getPath().split("/");
        String path=paths[paths.length-1];
        String name=paths[1];
        String version=paths[2];
        addToMap(name,version, path);
        if(addHandler!=null)
            addHandler.handle(name, version, path);
    }
    private void dealRemove(PathChildrenCacheEvent event) {
        String[] paths=event.getData().getPath().split("/");
        String path=paths[paths.length-1];
        String name=paths[1];
        String version=paths[2];
        removeFromMap(name,path);
        if(removeHandler!=null)
            removeHandler.handle(name, version, path);
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


}
