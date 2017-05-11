package com.albedo.java.thrift.rpc.server.demo;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

//客户端调用
@SuppressWarnings("resource")
public class Client {
	public static void main(String[] args) {
		spring();
	}

	public static void spring() {
		try {
			final ApplicationContext context = new ClassPathXmlApplicationContext("spring-context-thrift-client.xml");
			EchoSerivce.Iface echoSerivce = (EchoSerivce.Iface) context.getBean("echoSerivce");
			System.out.println(echoSerivce.echo("hello--echo"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


}
