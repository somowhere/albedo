package com.albedo.java.grpc.client.autoconfigure;

import com.albedo.java.grpc.client.*;
import io.grpc.LoadBalancer;
import io.grpc.util.RoundRobinLoadBalancerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.sleuth.Tracer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
@Configuration
@EnableConfigurationProperties
@ConditionalOnClass({GrpcChannelFactory.class})
public class GrpcClientAutoConfiguration {

    @Configuration
//    @ConditionalOnBean(DiscoveryClient.class)
    protected static class DiscoveryGrpcClientAutoConfiguration {

        @ConditionalOnMissingBean
        @Bean
        public GrpcChannelFactory discoveryClientChannelFactory(GrpcChannelsProperties channels, DiscoveryClient discoveryClient, LoadBalancer.Factory loadBalancerFactory,
                                                                GlobalClientInterceptorRegistry globalClientInterceptorRegistry) {
            return new DiscoveryClientChannelFactory(channels, discoveryClient, loadBalancerFactory, globalClientInterceptorRegistry);
        }
    }

//    @ConditionalOnMissingBean(value = GrpcChannelFactory.class, type = "org.springframework.cloud.client.discovery.DiscoveryClient")
//    @Bean
//    public GrpcChannelFactory addressChannelFactory(GrpcChannelsProperties channels, LoadBalancer.Factory loadBalancerFactory, GlobalClientInterceptorRegistry globalClientInterceptorRegistry) {
//        return new AddressChannelFactory(channels, loadBalancerFactory, globalClientInterceptorRegistry);
//    }

    @Configuration
    @ConditionalOnProperty(value = "spring.sleuth.scheduled.enabled", matchIfMissing = true)
    @ConditionalOnClass(Tracer.class)
    protected static class TraceClientAutoConfiguration {

        @Bean
        public GlobalClientInterceptorConfigurerAdapter globalTraceClientInterceptorConfigurerAdapter(final Tracer tracer) {
            return new GlobalClientInterceptorConfigurerAdapter() {

                @Override
                public void addClientInterceptors(GlobalClientInterceptorRegistry registry) {
                    registry.addClientInterceptors(new TraceClientInterceptor(tracer, new MetadataInjector()));
                }
            };
        }
    }

    @ConditionalOnMissingBean
    @Bean
    public GrpcChannelsProperties grpcChannelsProperties() {
        return new GrpcChannelsProperties();
    }

    @Bean
    public GlobalClientInterceptorRegistry globalClientInterceptorRegistry() {
        return new GlobalClientInterceptorRegistry();
    }

    @ConditionalOnMissingBean
    @Bean
    public LoadBalancer.Factory grpcLoadBalancerFactory() {
        return RoundRobinLoadBalancerFactory.getInstance();
    }

    @Bean
    @ConditionalOnClass(GrpcClient.class)
    public GrpcClientBeanPostProcessor grpcClientBeanPostProcessor() {
        return new GrpcClientBeanPostProcessor();
    }

}
