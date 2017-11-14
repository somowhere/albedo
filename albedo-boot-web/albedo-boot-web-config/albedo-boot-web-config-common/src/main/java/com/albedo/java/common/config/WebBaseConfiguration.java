package com.albedo.java.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

/**
 * Created by lijie on 2017/3/30.
 */
@Configuration
public class WebBaseConfiguration {

    @Bean
    public javax.validation.Validator localValidatorFactoryBean() {
        return new LocalValidatorFactoryBean();
    }

}
