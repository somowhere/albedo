package com.albedo.java.rpc.client.discover;

import com.albedo.java.rpc.client.manage.Handler;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.Map;

/**
 * Created by lijie on 9/8/16.
 */
public interface ServiceDiscover extends ApplicationListener<ContextRefreshedEvent> {
    /**
     *
     * @return  Map&lt;serverType,Map&lt;serverName,serverHost&gt;&gt;
     */
    Map<String,Map<String,String>> discover();
    void watchService();
    ServiceDiscover bindAddHandler(Handler handler);
    ServiceDiscover bindRemoveHandler(Handler handler);
}
