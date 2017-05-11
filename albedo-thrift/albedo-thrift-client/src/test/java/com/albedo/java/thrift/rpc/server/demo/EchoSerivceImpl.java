package com.albedo.java.thrift.rpc.server.demo;

import org.apache.thrift.TException;

//实现类
public class EchoSerivceImpl implements EchoSerivce.Iface {

	@Override
	public String echo(String msg) throws TException {
		String temp = "server :"+msg;
		System.out.println(temp);
		return temp;
	}
}
