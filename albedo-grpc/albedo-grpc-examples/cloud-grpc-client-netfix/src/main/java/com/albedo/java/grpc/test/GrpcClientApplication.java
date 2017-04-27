package com.albedo.java.grpc.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.core.env.Environment;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 2016/11/8
 */
//@EnableEurekaClient
//@EnableDiscoveryClient
@SpringBootApplication
public class GrpcClientApplication {

    public static void main(String[] args) {
//        System.out.println(System.getProperty("archaius.configurationSource.defaultFileName"));
//        System.out.println(System.getProperty("buildDirectory"));

        SpringApplication.run(GrpcClientApplication.class, args);
    }
}
