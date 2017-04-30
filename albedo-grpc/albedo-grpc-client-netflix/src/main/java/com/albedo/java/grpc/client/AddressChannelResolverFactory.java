package com.albedo.java.grpc.client;

import com.albedo.java.grpc.client.autoconfigure.GrpcChannelsProperties;
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
public class AddressChannelResolverFactory extends NameResolverProvider {

    private final GrpcChannelsProperties properties;

    public AddressChannelResolverFactory(GrpcChannelsProperties properties) {
        this.properties = properties;
    }

    @Nullable
    @Override
    public NameResolver newNameResolver(URI targetUri, Attributes params) {
        return new AddressChannelNameResolver(targetUri.toString(), properties.getChannel(targetUri.toString()), params, GrpcUtil.SHARED_CHANNEL_EXECUTOR);
    }

    @Override
    public String getDefaultScheme() {
        return "address";
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
