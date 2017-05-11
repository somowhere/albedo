package com.albedo.java.thrift.rpc.client.proxy;

import com.albedo.java.thrift.rpc.client.discover.ServiceDiscover;
import com.albedo.java.thrift.rpc.client.discover.ZookeeperServiceDiscover;
import com.albedo.java.thrift.rpc.client.manage.ServerManager;
import com.albedo.java.thrift.rpc.client.route.ServiceRouter;
import com.albedo.java.thrift.rpc.common.ConstantThrift;
import com.albedo.java.thrift.rpc.common.annotion.ThriftServiceApi;
import org.apache.curator.framework.CuratorFramework;
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

    public ServiceStarter(CuratorFramework curatorFramework, ServiceRouter serviceRouter) {
        this.serviceRouter = serviceRouter;
        this.curatorFramework = curatorFramework;
    }

    private ServiceRouter serviceRouter;
    private CuratorFramework curatorFramework;

    public ServiceStarter startService(Class clazz){
        list.add(clazz);
        return this;
    }

    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
        BeanDefinitionRegistry registry=(BeanDefinitionRegistry)beanFactory;

        for(Class clazz:list){
            GenericBeanDefinition definition=(GenericBeanDefinition) BeanDefinitionBuilder.genericBeanDefinition(clazz).getBeanDefinition();
            definition.getPropertyValues().addPropertyValue("innerClass",clazz);
            definition.getPropertyValues().addPropertyValue("factory",beanFactory);
            ThriftServiceApi thriftServiceApi = (ThriftServiceApi) clazz.getAnnotation(ThriftServiceApi.class);
            definition.getPropertyValues().addPropertyValue("proccessName",thriftServiceApi.name());
            String path = "/"+clazz.getName()+"/"+ (thriftServiceApi!=null ? thriftServiceApi.version() :
                    ConstantThrift.DEFAULT_VERSION);
            ServiceDiscover serviceDiscover = new ZookeeperServiceDiscover(curatorFramework,path);

            definition.getPropertyValues().addPropertyValue("serverManager",
                    new ServerManager(serviceDiscover, serviceRouter));

            definition.setBeanClass(ProxyFactoryBean.class);
            definition.setDestroyMethodName("close");
            registry.registerBeanDefinition(clazz.getName(), definition);
        }

    }
}
