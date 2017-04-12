package com.albedo.java.grpc.client.service;

import io.grpc.stub.StreamObserver;
import com.albedo.java.grpc.server.GRpcService;
import com.albedo.java.grpc.client.service.UserDetail;
import com.albedo.java.grpc.client.service.UserServiceGrpc;
import com.albedo.java.grpc.client.service.user;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



@GRpcService
public class UserServiceImpl extends UserServiceGrpc.UserServiceImplBase {

	private Logger logger = LoggerFactory.getLogger(UserServiceGrpc.class);

	@Override
	public void createUser(UserDetail request, StreamObserver<user> responseObserver) {
		logger.debug(request.toString());
		System.err.println(request);
		user.Builder builder = user.newBuilder();
		user response = builder.setName(request.getName()).build();
		logger.debug(response.toString());
		responseObserver.onNext(response);
		responseObserver.onCompleted();

	}
}
