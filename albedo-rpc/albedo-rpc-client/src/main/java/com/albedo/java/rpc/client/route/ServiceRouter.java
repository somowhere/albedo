package com.albedo.java.rpc.client.route;

import com.albedo.java.rpc.client.manage.Server;

import java.util.List;

/**
 * Created by lijie on 9/9/16.
 */
public interface ServiceRouter {
    Server route(List<Server> list);
}
