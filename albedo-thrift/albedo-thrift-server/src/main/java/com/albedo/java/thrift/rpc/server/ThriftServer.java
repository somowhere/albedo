package com.albedo.java.thrift.rpc.server;

import com.albedo.java.thrift.rpc.common.ConstantThrift;
import com.albedo.java.thrift.rpc.common.ThriftException;
import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.thrift.rpc.common.zookeeper.ThriftServerIpLocalNetworkResolve;
import com.albedo.java.thrift.rpc.common.zookeeper.ThriftServerIpResolve;
import com.albedo.java.thrift.rpc.server.map.ServiceMap;
import com.albedo.java.thrift.rpc.server.register.ServiceRegister;
import com.albedo.java.thrift.rpc.server.service.ThriftServerService;
import org.apache.thrift.TMultiplexedProcessor;
import org.apache.thrift.protocol.TProtocolFactory;
import org.apache.thrift.server.TThreadPoolServer;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.transport.TTransportException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.InetSocketAddress;

/**
 * Created by lijie on 9/19/16.
 */

public class ThriftServer {

   Logger logger = LoggerFactory.getLogger(getClass());

   private TThreadPoolServer server;

   private ServerThread serverThread;

   private TProtocolFactory tProtocolFactory;

   AlbedoRpcProperties applicationProperties;

   private ServiceMap serviceMap;

   private ServiceRegister serviceRegister;

   public ThriftServer(TProtocolFactory tProtocolFactory, AlbedoRpcProperties applicationProperties, ServiceMap serviceMap, ServiceRegister serviceRegister) {
      this.tProtocolFactory = tProtocolFactory;
      this.applicationProperties = applicationProperties;
      this.serviceMap = serviceMap;
      this.serviceRegister = serviceRegister;
   }


   public String getHostname(int weight) throws Exception {
      String hostname = applicationProperties.getHostUrl() + ":" + weight;
      return hostname;
   }


   public void start() throws Exception {

      //需要单独的线程,因为serve方法是阻塞的.
      serverThread = new ThriftServer.ServerThread();
      serverThread.start();
      // 注册服务
      if (serviceRegister != null) {
         for (String beanName : serviceMap.keySet()) {
            ThriftServiceApi thriftServiceApi = serviceMap.getServiceAnnotaion(beanName);
            String version = ConstantThrift.DEFAULT_VERSION; int weight=1;
            if(thriftServiceApi!=null){
               version = thriftServiceApi.version();
               weight = thriftServiceApi.weight();
            }
            serviceRegister.register(beanName, version,
                    getHostname(weight));
         }
      }
   }

   public void stop(){
      serverThread.shutdown();
   }

   class ServerThread extends Thread {
      ServerThread() throws TTransportException {
         TMultiplexedProcessor processor = new TMultiplexedProcessor();
         for (String beanName : serviceMap.keySet()) {
            ThriftServiceApi thriftServiceApi = serviceMap.getServiceAnnotaion(beanName);
            Object bean = serviceMap.getService(beanName);
            ThriftServerService serverService = (ThriftServerService) bean;
            String processorName = thriftServiceApi.name();
            processor.registerProcessor(processorName,
                    serverService.getProcessor(serverService));
            logger.info("Register a Processor {}", processorName);
         }

         logger.info("init default TServerTransport in addr {} port {}", applicationProperties.getAddr(), applicationProperties.getPort());
         TServerTransport tServerTransport = new TServerSocket(new InetSocketAddress(applicationProperties.getAddr(),
                 applicationProperties.getPort()));
         TThreadPoolServer.Args args = new TThreadPoolServer.Args(tServerTransport);
         args.processor(processor);
         args.protocolFactory(tProtocolFactory);
         server = new TThreadPoolServer(args);
      }

      @Override
      public void run(){
         try{
            logger.debug("Thrift Server 正在启动............");
            server.serve();
            logger.error("Thrift Server 停止............");
         }catch(Exception e){
            logger.error("Thrift Server 启动失败 {}", e);
         }
      }

      public void shutdown(){
         server.stop();
      }
   }

}
