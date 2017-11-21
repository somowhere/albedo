package com.albedo.java.common.config;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.web.interceptor.OperateInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.annotation.Resource;

@Configuration
public class WebMvcConfigurer extends WebMvcConfigurerAdapter {


    @Resource
    private AlbedoProperties albedoProperties;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new OperateInterceptor(albedoProperties)).addPathPatterns(albedoProperties.getAdminPath("/**"), "/management/**", "/api/**");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName(PublicUtil.isEmpty(albedoProperties.getDefaultView()) ? PublicUtil.toAppendStr("redirect:", albedoProperties.getAdminPath("/login")) : albedoProperties.getDefaultView());
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        super.addViewControllers(registry);
    }

}
