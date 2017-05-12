package com.albedo.java.thrift.rpc.example.server;

import com.albedo.java.thrift.rpc.example.EchoSerivce;
import com.albedo.java.thrift.rpc.server.service.IThriftServerService;
import com.albedo.java.thrift.rpc.server.service.ThriftServerService;
import org.apache.thrift.TException;
import org.apache.thrift.TProcessor;
import org.springframework.stereotype.Service;

//实现类
@Service
public class EchoSerivceImpl extends ThriftServerService implements EchoSerivce.Iface {

	@Override
	public String echo(String msg) throws TException {
		String temp = "server :"+msg;
		System.out.println(temp);
		return temp;
	}

	@Override
	public String getName() {
		return "echoSerivce";
	}

	@Override
	public TProcessor getProcessor(IThriftServerService bean) {
		EchoSerivce.Iface impl = (EchoSerivce.Iface) bean;
		return new EchoSerivce.Processor<EchoSerivce.Iface>(impl);
	}
}
