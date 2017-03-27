package com.albedo.java.rpc.server.netty.handler;

import com.albedo.java.util.PublicUtil;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import net.sf.cglib.reflect.FastClass;
import net.sf.cglib.reflect.FastMethod;
import com.albedo.java.rpc.common.protocol.Message;
import com.albedo.java.rpc.common.protocol.Request;
import com.albedo.java.rpc.common.protocol.Response;
import com.albedo.java.rpc.server.map.ServiceMap;

/**
 * Created by lijie on 9/9/16.
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
        Object[] params = request.getParams();
        if(PublicUtil.isNotEmpty(request.getParamsType())){
            for (int i=0,length = request.getParamsType().length; i<length; i++){
                if(params[i] instanceof JSONObject){
                    String text = ((JSONObject) params[i]).toJSONString();
                    params[i] = JSONObject.parseObject(text, request.getParamsType()[i]);
                }
            }
        }
        Object re=serviceFastMethod.invoke(serviceBean, params);
        response.setResult(re);
        ctx.channel().writeAndFlush(Message.create(response));
    }
}
