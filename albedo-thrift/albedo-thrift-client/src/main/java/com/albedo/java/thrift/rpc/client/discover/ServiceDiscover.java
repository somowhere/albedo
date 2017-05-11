package com.albedo.java.thrift.rpc.client.discover;

import com.albedo.java.thrift.rpc.client.manage.Handler;

import java.util.Map;

/**
 * Created by lijie on 9/8/16.
 */
public interface ServiceDiscover {
    /**
     *
     * @return  Map&lt;serverType,Map&lt;serverName,serverHost&gt;&gt;
     */
    Map<String,Map<String,String>> discover();

    void close();

    void watchService();
    ServiceDiscover bindAddHandler(Handler handler);
    ServiceDiscover bindRemoveHandler(Handler handler);
}
