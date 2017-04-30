package com.albedo.java.grpc.client;

import io.grpc.ClientInterceptor;
import lombok.Getter;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
@Getter
public class GlobalClientInterceptorRegistry implements ApplicationContextAware {

    private final List<ClientInterceptor> clientInterceptors = new ArrayList<>();
    private ApplicationContext applicationContext;

    @PostConstruct
    public void init() {
        Map<String, GlobalClientInterceptorConfigurerAdapter> map = applicationContext.getBeansOfType(GlobalClientInterceptorConfigurerAdapter.class);
        for (GlobalClientInterceptorConfigurerAdapter globalClientInterceptorConfigurerAdapter : map.values()) {
            globalClientInterceptorConfigurerAdapter.addClientInterceptors(this);
        }
    }

    public GlobalClientInterceptorRegistry addClientInterceptors(ClientInterceptor interceptor) {
        clientInterceptors.add(interceptor);
        return this;
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
}