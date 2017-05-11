package com.albedo.java.thrift.rpc.client.route;


import com.albedo.java.thrift.rpc.client.manage.Server;
import com.albedo.java.thrift.rpc.common.util.RandomUtils;

import java.util.List;

/**
 * Created by lijie on 9/9/16.
 */
public class WeightServiceRouter implements ServiceRouter{
    @Override
    public Server route(List<Server> list) {
        int random= RandomUtils.randomInt(0,list.size());
        return list.get(random);
    }
}
