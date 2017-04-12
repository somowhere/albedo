package com.albedo.java.common.config;

import com.albedo.java.common.domain.util.JSR310PersistenceConverters;
import com.fasterxml.jackson.datatype.hibernate4.Hibernate4Module;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.QueryLookupStrategy.Key;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import javax.inject.Inject;

@Configuration
@EntityScan(basePackages = { "com.albedo.java.modules.*.domain", "com.qingju.java.modules.*.domain"}, basePackageClasses = { JSR310PersistenceConverters.class })
@EnableJpaRepositories(value={"com.albedo.java.modules.*.repository", "com.qingju.java.modules.*.repository"}, queryLookupStrategy=Key.CREATE_IF_NOT_FOUND)
@EnableJpaAuditing(auditorAwareRef = "springSecurityAuditorAware")
@EnableTransactionManagement
public class DatabaseConfiguration {

    private final Logger log = LoggerFactory.getLogger(DatabaseConfiguration.class);

    @Inject
    private Environment env;

    @Bean
    public Hibernate4Module hibernate4Module() {
        return new Hibernate4Module();
    }

}
