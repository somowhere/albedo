package com.albedo.java.rpc.client.route;

import com.albedo.java.rpc.client.manage.Server;
import com.albedo.java.rpc.common.utils.RandomUtils;

import java.util.List;

/**
 * Created by lijie on 9/9/16.
 */
public class RandomServiceRouter implements ServiceRouter{
    @Override
    public Server route(List<Server> list) {
        int random= RandomUtils.randomInt(0,list.size());
        return list.get(random);
    }
}
