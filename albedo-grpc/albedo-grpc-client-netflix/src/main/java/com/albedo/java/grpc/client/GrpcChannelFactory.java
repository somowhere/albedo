package com.albedo.java.grpc.client;

import io.grpc.Channel;
import io.grpc.ClientInterceptor;

import java.util.List;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
public interface GrpcChannelFactory {

    Channel createChannel(String name);

    Channel createChannel(String name, List<ClientInterceptor> interceptors);
}
