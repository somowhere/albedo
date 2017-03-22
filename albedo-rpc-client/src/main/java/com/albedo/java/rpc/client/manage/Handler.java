package com.albedo.java.rpc.client.manage;

/**
 * Created by chenghao on 9/8/16.
 */
public interface Handler {
    void handle(String type, String name, String url);
}
