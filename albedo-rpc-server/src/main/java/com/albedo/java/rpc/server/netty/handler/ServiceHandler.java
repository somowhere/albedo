package com.albedo.java.rpc.server.netty.handler;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import net.sf.cglib.reflect.FastClass;
import net.sf.cglib.reflect.FastMethod;
import com.albedo.java.rpc.common.protocol.Message;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.Response;
import com.albedo.java.rpc.server.map.ServiceMap;

/**
 * Created by chenghao on 9/9/16.
 */
public class ServiceHandler extends SimpleChannelInboundHandler<Message>{
    private ServiceMap serviceMap;
    public ServiceHandler(ServiceMap serviceMap){
        this.serviceMap=serviceMap;
    }
    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Message message) throws Exception {
        Response response=new Response();
        Request request=(Request) message.getBody();
        response.setRequestId(request.getRequestId());
        Object serviceBean=serviceMap.getService(request.getClassName());
        FastClass serviceFastClass = FastClass.create(serviceBean.getClass());
        FastMethod serviceFastMethod = serviceFastClass.getMethod(request.getMethodName(), request.getParamsType());
        Object re=serviceFastMethod.invoke(serviceBean, request.getParams());
        response.setResult(re);
        ctx.channel().writeAndFlush(Message.create(response));
    }
}
