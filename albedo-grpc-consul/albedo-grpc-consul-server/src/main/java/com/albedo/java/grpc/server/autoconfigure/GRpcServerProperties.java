package com.albedo.java.grpc.server.autoconfigure;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Created by alexf on 26-Jan-16.
 */
@ConfigurationProperties("grpc")
public class GRpcServerProperties {
    /**
     * gRPC server port
     */
    private int port = 6565;

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }
}
