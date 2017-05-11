package com.albedo.java.thrift.rpc.example.server;

import com.albedo.java.thrift.rpc.example.EchoSerivce;
import com.albedo.java.thrift.rpc.server.service.ThriftServerService;
import org.apache.thrift.TException;
import org.apache.thrift.TProcessor;
import org.springframework.stereotype.Service;

//实现类
@Service
public class EchoSerivceImpl implements EchoSerivce.Iface, ThriftServerService {

	@Override
	public String echo(String msg) throws TException {
		String temp = "server :"+msg;
		System.out.println(temp);
		return temp;
	}
	@Override
	public TProcessor getProcessor(ThriftServerService bean) {
		EchoSerivce.Iface impl = (EchoSerivce.Iface) bean;
		return new EchoSerivce.Processor<EchoSerivce.Iface>(impl);
	}
}
