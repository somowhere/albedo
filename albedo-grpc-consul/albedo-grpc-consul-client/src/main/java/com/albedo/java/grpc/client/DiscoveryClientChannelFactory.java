/*
 * Copyright 2016 Google, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.albedo.java.grpc.client;

import com.albedo.java.grpc.client.autoconfigure.GrpcChannelsProperties;
import io.grpc.Channel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.util.RoundRobinLoadBalancerFactory;
import org.springframework.cloud.client.discovery.DiscoveryClient;

/**
 * Created by rayt on 5/17/16.
 */
public class DiscoveryClientChannelFactory implements GrpcChannelFactory {
  private final GrpcChannelsProperties grpcChannelsProperties;
  private final DiscoveryClient client;

  public DiscoveryClientChannelFactory(GrpcChannelsProperties grpcChannelsProperties, DiscoveryClient client) {
    this.grpcChannelsProperties = grpcChannelsProperties;
    this.client = client;
  }

  @Override
  public Channel createChannel(String name) {
	  RoundRobinLoadBalancerFactory instance = RoundRobinLoadBalancerFactory.getInstance();

	  //grpcChannelsProperties.getChannels().get(name).isPlaintext()
    return ManagedChannelBuilder.forTarget(name)
        .loadBalancerFactory(instance)
        .nameResolverFactory(new DiscoveryClientResolverFactory(client))
        .usePlaintext(true).build();
  }
}
