package com.albedo.java.rpc.server.netty.handler;

import com.albedo.java.rpc.common.config.AlbedoRpcProperties;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.codec.MessageDecoder;
import com.albedo.java.rpc.common.protocol.codec.MessageEncoder;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;
import com.albedo.java.rpc.server.map.ServiceMap;
import com.albedo.java.rpc.server.register.ServiceRegister;

import java.io.IOException;

/**
 * Created by lijie on 9/19/16.
 */

public class NettyServer {
    private EventLoopGroup bossGroup =null;
    private EventLoopGroup workerGroup =null;
    private Marshalling marshalling;
    private AlbedoRpcProperties applicationProperties;
    private ServiceMap serviceMap;
    private ServiceRegister serviceRegister;
    public NettyServer(Marshalling marshalling, AlbedoRpcProperties applicationProperties, ServiceMap serviceMap, ServiceRegister serviceRegister){
        this.applicationProperties=applicationProperties;
        this.marshalling=marshalling;
        this.serviceMap=serviceMap;
        this.serviceRegister=serviceRegister;
    }

   public void start() throws Exception {
       bossGroup = new NioEventLoopGroup();
       workerGroup = new NioEventLoopGroup();
       ServerBootstrap b = new ServerBootstrap();
       b.group(bossGroup, workerGroup).channel(NioServerSocketChannel.class)
               .option(ChannelOption.SO_BACKLOG, 100)
               .handler(new LoggingHandler(LogLevel.INFO))
               .childHandler(new ChannelInitializer<SocketChannel>() {
                   @Override
                   public void initChannel(SocketChannel ch)
                           throws IOException {
                       ch.pipeline().addLast(new MessageDecoder(marshalling, Request.class));
                       ch.pipeline().addLast(new MessageEncoder(marshalling));
                       ch.pipeline().addLast(new ServiceHandler(serviceMap));
                   }
               });
       // 绑定端口，同步等待成功
       b.bind(applicationProperties.getAddr(),applicationProperties.getPort()).sync();
       System.out.println("Netty server start ok : "
               + (applicationProperties.getAddr() + " : " + applicationProperties.getPort()));
       serviceRegister.register();
   }
}
