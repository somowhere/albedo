package com.albedo.java.rpc.example.client;

import com.albedo.java.rpc.example.client.service.HelloService;
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
    HelloService helloService;

    @RequestMapping("/index")
    @ResponseBody
    public String index() {
       return helloService.doSomething("dddd");
    }
}
