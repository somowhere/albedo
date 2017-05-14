package com.albedo.java.thrift.rpc.example.client;

import com.albedo.java.thrift.rpc.common.config.AlbedoRpcProperties;
import com.albedo.java.thrift.rpc.example.EchoSerivce;
import org.apache.thrift.TException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by lijie on 2017/5/11.
 *
 * @author 837158334@qq.com
 */
@Controller
@RequestMapping("/")
public class EchoController {
    @Resource
    AlbedoRpcProperties albedoRpcProperties;
    @Resource
    EchoSerivce.Iface echoSerivce;
    @RequestMapping("/index")
    @ResponseBody
    public String index() throws TException {
//        EchoSerivce.Iface echoSerivce = SpringContextHolder.getBean("echoSerivce");
       return echoSerivce.echo("msgddd");
    }
}
