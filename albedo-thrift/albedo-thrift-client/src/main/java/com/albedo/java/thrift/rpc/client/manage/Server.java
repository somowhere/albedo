package com.albedo.java.thrift.rpc.client.manage;


/**
 * Created by lijie on 9/8/16.
 */
public class Server {
    private String host;
    private int port;
    private String version;
    private String name;


    public Server(String name, String version, String url){
        String [] tmps=url.split(":");
        this.host=tmps[0];
        this.version=version;
        this.name=name;
        this.port=tmps.length>1?Integer.parseInt(tmps[1]):80;
    }

    public String getHost() {
        return host;
    }

    public String getName() {
        return name;
    }
    public String getNameProcessor() {
        return name+"Processor";
    }
    public String getVersion() {
        return version;
    }

    public int getPort() {
        return port;
    }




}
