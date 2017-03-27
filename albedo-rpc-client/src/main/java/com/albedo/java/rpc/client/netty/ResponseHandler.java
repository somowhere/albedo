package com.albedo.java.rpc.client.netty;

import com.albedo.java.rpc.client.manage.Server;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import com.albedo.java.rpc.common.protocol.Message;
import com.albedo.java.rpc.common.protocol.Response;

import java.util.concurrent.CompletableFuture;

/**
 * Created by lijie on 9/19/16.
 */
public class ResponseHandler extends SimpleChannelInboundHandler<Message>{
    private Server server;

    public ResponseHandler(Server server){
        this.server = server;
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Message msg) throws Exception {
        Response response=(Response)msg.getBody();
        if(server.getRequest(response.getRequestId())!=null){
            CompletableFuture future= server.getFuture(response.getRequestId());
            server.clearRequest(response.getRequestId());
            future.complete(response);
        }
    }
}
