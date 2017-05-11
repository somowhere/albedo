package com.albedo.java.rpc.client.proxy;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;

import java.lang.reflect.Proxy;

public class ProxyFactoryBean<T> implements FactoryBean<T> {

    public void setInnerClass(Class innerClass) {
        this.innerClass = innerClass;
    }

    private Class  innerClass;
    public void setFactory(ConfigurableListableBeanFactory factory) {
        this.factory = factory;
    }

    private ConfigurableListableBeanFactory factory;

    public T getObject() throws Exception {
        ServiceProxy serviceProxy = factory.getBean(ServiceProxy.class);
        return (T)Proxy.newProxyInstance(innerClass.getClassLoader(),new Class[]{innerClass},serviceProxy);

    }

    @Override
    public Class<?> getObjectType() {
        return innerClass;
    }

    @Override
    public boolean isSingleton() {
        return true;
    }

}