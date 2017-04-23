package com.albedo.java.controller;

import com.albedo.java.grpc.client.GrpcClient;
import io.grpc.Channel;
import net.devh.examples.grpc.lib.HelloReply;
import net.devh.examples.grpc.lib.HelloRequest;
import net.devh.examples.grpc.lib.SimpleGrpc;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@EnableDiscoveryClient
@Controller
public class AdminController {
	@GrpcClient(value = "cloud-grpc-server", context = false)
	private Channel serverChannel;

	public String sendMessage(String name) {
		SimpleGrpc.SimpleBlockingStub stub = SimpleGrpc.newBlockingStub(serverChannel);
		HelloReply response = stub.sayHello(HelloRequest.newBuilder().setName(name).build());
		return response.getMessage();
	}

	@RequestMapping("/index")
	public String index() {
		sendMessage("test");
//		DynamicPropertyFactory configInstance = com.netflix.config.DynamicPropertyFactory.getInstance();
//		ApplicationInfoManager applicationInfoManager = ExampleEurekaService
//				.initializeApplicationInfoManager(new MyDataCenterInstanceConfig());
//		EurekaClient eurekaClient = ExampleEurekaService.initializeEurekaClient(applicationInfoManager,
//				new DefaultEurekaClientConfig());
//
//		ExampleServiceBase exampleServiceBase = new ExampleServiceBase(applicationInfoManager, eurekaClient,
//				configInstance);
//		try {
//			exampleServiceBase.start();
//		} finally {
//			// the stop calls shutdown on eurekaClient
//			exampleServiceBase.stop();
//		}
		return "index";
	}

}
