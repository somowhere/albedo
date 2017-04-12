package com.albedo.java.grpc.client.controller;

/**
 * Created by lijie on 2017/4/11.
 */

import com.ecwid.consul.v1.ConsulClient;
import com.ecwid.consul.v1.health.model.Check;
import com.ecwid.consul.v1.health.model.HealthService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController @Slf4j
public class ApiController {
    @Autowired
    private ConsulClient consulClient;
    @RequestMapping(value = "/unregister/{serviceName}", method = RequestMethod.GET)
    public String unregisterServiceAll(@PathVariable String serviceName) {
        List<HealthService> response = consulClient.getHealthServices(serviceName, false, null).getValue();
        for(HealthService service : response) {
            // 创建一个用来剔除无效实例的ConsulClient，连接到无效实例注册的agent
            ConsulClient clearClient = new ConsulClient("http://114.55.177.236", 8500);
            service.getChecks().forEach(check -> {
                if(check.getStatus() != Check.CheckStatus.PASSING) {
                    log.info("unregister : {}", check.getServiceId());
                    clearClient.agentServiceDeregister(check.getServiceId());
                }
            });
        }
        return "ok";
    }
}
