package com.albedo.java.grpc.client;

import com.albedo.java.grpc.client.autoconfigure.GrpcChannelProperties;
import com.albedo.java.grpc.client.autoconfigure.GrpcChannelsProperties;
import com.google.common.collect.Lists;

import org.springframework.cloud.client.discovery.DiscoveryClient;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import io.grpc.Channel;
import io.grpc.ClientInterceptor;
import io.grpc.ClientInterceptors;
import io.grpc.LoadBalancer;
import io.grpc.netty.NettyChannelBuilder;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
public class DiscoveryClientChannelFactory implements GrpcChannelFactory {
    private GrpcChannelsProperties properties;
    private DiscoveryClient client;
    private LoadBalancer.Factory loadBalancerFactory;
    private GlobalClientInterceptorRegistry globalClientInterceptorRegistry;
    public DiscoveryClientChannelFactory(GrpcChannelsProperties properties, DiscoveryClient client, LoadBalancer.Factory loadBalancerFactory,
                                         GlobalClientInterceptorRegistry globalClientInterceptorRegistry) {
        this.properties = properties;
        this.client = client;
        this.loadBalancerFactory = loadBalancerFactory;
        this.globalClientInterceptorRegistry = globalClientInterceptorRegistry;
    }

    @Override
    public Channel createChannel(String name) {
        return this.createChannel(name, null);
    }

    @Override
    public Channel createChannel(String name, List<ClientInterceptor> interceptors) {
        GrpcChannelProperties channelProperties = properties.getChannel(name);
        Channel channel = NettyChannelBuilder.forTarget(name)
                .loadBalancerFactory(loadBalancerFactory)
                .nameResolverFactory(new DiscoveryClientResolverFactory(client))
                .usePlaintext(properties.getChannel(name).isPlaintext())
                .enableKeepAlive(channelProperties.isEnableKeepAlive(), channelProperties.getKeepAliveDelay(), TimeUnit.SECONDS, channelProperties.getKeepAliveTimeout(), TimeUnit.SECONDS)
                .build();
        List<ClientInterceptor> globalInterceptorList = globalClientInterceptorRegistry.getClientInterceptors();
        Set<ClientInterceptor> interceptorSet = new HashSet<>();
        if (globalInterceptorList != null && !globalInterceptorList.isEmpty()) {
            interceptorSet.addAll(globalInterceptorList);
        }
        if (interceptors != null && !interceptors.isEmpty()) {
            interceptorSet.addAll(interceptors);
        }
        return ClientInterceptors.intercept(channel, Lists.newArrayList(interceptorSet));
    }
}
