package com.albedo.java.grpc.test;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;


import io.netty.handler.codec.http2.Http2Headers;
import io.netty.handler.codec.http2.ReadOnlyHttp2Headers;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 2016/11/8
 */
@EnableEurekaClient
@EnableDiscoveryClient
@SpringBootApplication
public class GrpcClientApplication {
    public static void main(String[] args) {

        SpringApplication.run(GrpcClientApplication.class, args);
    }
}
