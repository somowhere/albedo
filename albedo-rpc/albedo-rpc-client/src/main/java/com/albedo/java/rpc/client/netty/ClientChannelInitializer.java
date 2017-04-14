package com.albedo.java.rpc.client.netty;

import com.albedo.java.rpc.client.manage.Server;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.socket.SocketChannel;
import com.albedo.java.rpc.common.protocol.Response;
import com.albedo.java.rpc.common.protocol.codec.MessageDecoder;
import com.albedo.java.rpc.common.protocol.codec.MessageEncoder;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;

/**
 * Created by lijie on 9/8/16.
 */
public class ClientChannelInitializer extends ChannelInitializer<SocketChannel> {
    private Marshalling marshalling;
    private Server server;
    public ClientChannelInitializer(Marshalling marshalling, Server server){
        this.marshalling=marshalling;
        this.server = server;
    }
    @Override
    protected void initChannel(SocketChannel ch) throws Exception {
        ch.pipeline()
            .addLast(new MessageDecoder(marshalling, Response.class))
            .addLast(new MessageEncoder(marshalling))
            .addLast(new ResponseHandler(server));

    }
}
