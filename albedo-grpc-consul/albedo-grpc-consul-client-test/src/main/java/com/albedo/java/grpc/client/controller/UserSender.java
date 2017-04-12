package com.albedo.java.grpc.client.controller;


import com.albedo.java.grpc.client.service.Gender;
import com.albedo.java.grpc.client.service.UserDetail;
import com.albedo.java.grpc.client.service.UserServiceGrpc;
import com.albedo.java.grpc.client.service.user;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/grcp")
public class UserSender {
	
	@Autowired
	UserServiceGrpc.UserServiceBlockingStub userServiceBlockingStub;
 
    @RequestMapping(method = RequestMethod.GET, value = "/senduser")
    public ResponseEntity<?> api() {
//    	List<ServiceInstance> server=discoveryClient.getInstances("grpc-server");
//    	for (ServiceInstance serviceInstance : server) {
//
//			String hostName=serviceInstance.getHost();
//			int gRpcPort=Integer.parseInt(serviceInstance.getMetadata().get("grpc.port"));
//
//			ManagedChannel channel=ManagedChannelBuilder.forAddress(hostName,gRpcPort).usePlaintext(true).build();
//	        UserServiceBlockingStub stub=UserServiceGrpc.newBlockingStub(
//	        		discoveryClientChannelFactory.createChannel("default"));
	        
	        UserDetail userDetail= UserDetail.newBuilder()
	        			.setName("Thamira")
	        			.setEmail("Thamira1005@gmail.com")
	        			.setAge(24).setGender(Gender.Male)
	        			.setPassword("password").build();
		user u=userServiceBlockingStub.createUser(userDetail);
//		}
    	
        return ResponseEntity.ok("User "+u);
    }
	
	
}
