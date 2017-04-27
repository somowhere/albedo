package com.albedo.java.grpc.client;

import com.netflix.discovery.DiscoveryClient;
import io.grpc.Attributes;
import io.grpc.NameResolver;
import io.grpc.NameResolverProvider;
import io.grpc.internal.GrpcUtil;

import javax.annotation.Nullable;
import java.net.URI;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
public class DiscoveryClientResolverFactory extends NameResolverProvider {
    private final DiscoveryClient client;

    public DiscoveryClientResolverFactory(DiscoveryClient client) {
        this.client = client;
    }

    @Nullable
    @Override
    public NameResolver newNameResolver(URI targetUri, Attributes params) {
        return new DiscoveryClientNameResolver(targetUri.toString(), client, params, GrpcUtil.TIMER_SERVICE, GrpcUtil.SHARED_CHANNEL_EXECUTOR);
    }

    @Override
    public String getDefaultScheme() {
        return "discoveryClient";
    }

    @Override
    protected boolean isAvailable() {
        return true;
    }

    @Override
    protected int priority() {
        return 5;
    }
}
