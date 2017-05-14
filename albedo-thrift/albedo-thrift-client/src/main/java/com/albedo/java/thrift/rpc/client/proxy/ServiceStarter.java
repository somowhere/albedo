package com.albedo.java.thrift.rpc.client.proxy;

import com.albedo.java.thrift.rpc.client.discover.ServiceDiscover;
import com.albedo.java.thrift.rpc.client.discover.ZookeeperServiceDiscover;
import com.albedo.java.thrift.rpc.client.manage.ServerManager;
import com.albedo.java.thrift.rpc.client.route.ServiceRouter;
import com.albedo.java.thrift.rpc.common.ThriftConstant;
import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import com.albedo.java.thrift.rpc.common.vo.ServiceApi;
import com.google.common.collect.Maps;
import org.apache.curator.framework.CuratorFramework;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanFactoryPostProcessor;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.GenericBeanDefinition;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by lijie on 9/21/16.
 */
public class ServiceStarter implements BeanFactoryPostProcessor {
    private List<Class> list=new ArrayList<>();
    private Map<String, ServiceApi> map = Maps.newHashMap();


    public ServiceStarter startService(Class clazz, ServiceApi serviceApi){
        list.add(clazz);
        map.put(clazz.getName(), serviceApi);
        return this;
    }

    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
        BeanDefinitionRegistry registry=(BeanDefinitionRegistry)beanFactory;
        CuratorFramework curatorFramework = beanFactory.getBean(CuratorFramework.class);
        ServiceRouter serviceRouter = beanFactory.getBean(ServiceRouter.class);
        for(Class clazz:list){
            GenericBeanDefinition definition=(GenericBeanDefinition) BeanDefinitionBuilder.genericBeanDefinition(clazz).getBeanDefinition();
            definition.getPropertyValues().addPropertyValue("innerClass",clazz);
            definition.getPropertyValues().addPropertyValue("factory",beanFactory);
            ServiceApi serviceApi = map.get(clazz.getName());
            definition.getPropertyValues().addPropertyValue("proccessName",serviceApi.getName());

            String path = "/"+clazz.getName()+"/"+ (serviceApi!=null ? serviceApi.getVersion() :
                    ThriftConstant.DEFAULT_VERSION);
            ServiceDiscover serviceDiscover = new ZookeeperServiceDiscover(curatorFramework, path);

            definition.getPropertyValues().addPropertyValue("serverManager",
                    new ServerManager(serviceDiscover, serviceRouter));

            definition.setBeanClass(ProxyFactoryBean.class);
            definition.setDestroyMethodName("close");
            registry.registerBeanDefinition(clazz.getName(), definition);
        }

    }

}
