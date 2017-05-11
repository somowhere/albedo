package com.albedo.java.thrift.rpc.client.manage;

/**
 * Created by lijie on 9/8/16.
 */
public interface Handler {
    void handle(String name, String version, String url);
}
