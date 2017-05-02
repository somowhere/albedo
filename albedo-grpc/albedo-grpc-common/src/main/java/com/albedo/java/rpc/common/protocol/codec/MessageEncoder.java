package com.albedo.java.rpc.common.protocol.codec;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToByteEncoder;
import com.albedo.java.rpc.common.protocol.Message;
import com.albedo.java.rpc.common.protocol.marshalling.Marshalling;

/**
 * Created by lijie on 9/18/16.
 */
public class MessageEncoder extends MessageToByteEncoder<Message>{
    private Marshalling marshalling;
    public MessageEncoder(Marshalling marshalling){
        this.marshalling=marshalling;
    }

    @Override
    protected void encode(ChannelHandlerContext ctx, Message msg, ByteBuf out) throws Exception {
        out.writeInt(msg.getHeader().getCrcCode());
        out.writeInt(msg.getHeader().getLength());
        out.writeBytes(marshalling.encode(msg.getBody()));
        out.setInt(4,out.readableBytes()-8);
    }
}
