package com.albedo.java.rpc.client.manage;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.socket.nio.NioSocketChannel;
import com.albedo.java.rpc.client.netty.ClientChannelInitializer;
import com.albedo.java.rpc.common.protocol.Message;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.Response;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;

import java.net.InetSocketAddress;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by lijie on 9/8/16.
 */
public class Server {
    private String host;
    private int port;
    private String name;
    private String type;
    private Channel channel;
    private EventLoopGroup eventLoopGroup;
    private ConcurrentMap<String,Request> requestMap=new ConcurrentHashMap<>();
    private ConcurrentMap<String,CompletableFuture<Response>> futureMap=new ConcurrentHashMap<>();
    private Marshalling marshalling;
    public Server(String type, String name, String host, int port, EventLoopGroup eventLoopGroup, Marshalling marshalling){
        this.host=host;
        this.type=type;
        this.name=name;
        this.port=port;
        this.eventLoopGroup=eventLoopGroup;
        this.marshalling=marshalling;
    }
    public Server(String type, String name, String url, EventLoopGroup eventLoopGroup, Marshalling marshalling){
        String [] tmps=url.split(":");
        this.host=tmps[0];
        this.type=type;
        this.name=name;
        this.port=tmps.length>1?Integer.parseInt(tmps[1]):80;
        this.eventLoopGroup=eventLoopGroup;
        this.marshalling=marshalling;
    }

    public String getHost() {
        return host;
    }



    public String getName() {
        return name;
    }


    public String getType() {
        return type;
    }


    public Channel getChannel() {
        if(channel==null){
            synchronized (this){
                if(channel==null)
                    connect();
            }
        }
        return channel;
    }

    private void connect() {
        Bootstrap b = new Bootstrap();
        b.group(eventLoopGroup)
                .channel(NioSocketChannel.class)
                .handler(new ClientChannelInitializer(marshalling,this));

        ChannelFuture channelFuture = b.connect(new InetSocketAddress(host,port));
        try {
            CompletableFuture<Channel> future=new CompletableFuture();
            channelFuture.addListener(new ChannelFutureListener() {
                @Override
                public void operationComplete(final ChannelFuture channelFuture) throws Exception {
                    if (channelFuture.isSuccess()) {
                        future.complete(channelFuture.channel());
                    }
                }
            });
            this.channel=future.get();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Request getRequest(String requestId){
        return requestMap.get(requestId);
    }
    public CompletableFuture getFuture(String requestId){
        return futureMap.get(requestId);
    }
    public void clearRequest(String requestId){
        requestMap.remove(requestId);
        futureMap.remove(requestId);
    }

    public CompletableFuture sendRequest(Request request){
        CompletableFuture future=new CompletableFuture();
        requestMap.put(request.getRequestId(),request);
        futureMap.put(request.getRequestId(),future);
        ChannelFuture channelFuture=getChannel().writeAndFlush(Message.create(request));
        try {
            channelFuture.sync();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return future;
    }


}
