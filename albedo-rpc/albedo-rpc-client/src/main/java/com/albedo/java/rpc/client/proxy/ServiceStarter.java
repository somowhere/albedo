package com.albedo.java.rpc.client.proxy;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.GenericBeanDefinition;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by lijie on 9/21/16.
 */
public class ServiceStarter implements BeanFactoryPostProcessor{
     private List<Class> list=new ArrayList<>();
    public ServiceStarter startService(Class clazz){
        list.add(clazz);
        return this;
    }

//    @Override
//    public void onApplicationEvent(ContextRefreshedEvent event) {
//        ConfigurableApplicationContext  applicationContext=(ConfigurableApplicationContext) event.getApplicationContext();
//        for(Class clazz:list){
//            ServiceProxy serviceProxy=applicationContext.getBeanFactory().getBean(ServiceProxy.class);
//            applicationContext.getBeanFactory().registerSingleton(clazz.getName(), Proxy.newProxyInstance(clazz.getClassLoader(),new Class[]{clazz},serviceProxy));
//        }
//    }

    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
        BeanDefinitionRegistry registry=(BeanDefinitionRegistry)beanFactory;
        for(Class clazz:list){
            GenericBeanDefinition definition=(GenericBeanDefinition) BeanDefinitionBuilder.genericBeanDefinition(clazz).getBeanDefinition();
            definition.getPropertyValues().addPropertyValue("innerClass",clazz);
            definition.getPropertyValues().addPropertyValue("factory",beanFactory);
            definition.setBeanClass(ProxyFactoryBean.class);
            registry.registerBeanDefinition(clazz.getName(),definition);
        }

    }
}
