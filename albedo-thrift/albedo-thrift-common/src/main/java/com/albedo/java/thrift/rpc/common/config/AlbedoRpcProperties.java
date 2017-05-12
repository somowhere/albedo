package com.albedo.java.thrift.rpc.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConfigurationPropertiesBinding;

/**
 * Created by lijie on 9/7/16.
 */

//@ConfigurationProperties(prefix = "albedo.rpc")
@ConfigurationProperties(prefix = "albedo.rpc",
        ignoreUnknownFields = true,
        ignoreInvalidFields= true,
        exceptionIfInvalid = false)
public class AlbedoRpcProperties {
    private String namespace="albedo-thrift";
    private String hostUrl="localhost:8182";

    public String getHostUrl() {
        return hostUrl;
    }

    public void setHostUrl(String hostUrl) {
        this.hostUrl = hostUrl;
    }

    public String getAddr(){
        return hostUrl.split(":")[0];
    }
    public int getPort(){
        return Integer.parseInt(hostUrl.split(":")[1]);
    }
    public String getNamespace() {
        return namespace;
    }
    public void setNamespace(String namespace) {
        this.namespace = namespace;
    }
}
