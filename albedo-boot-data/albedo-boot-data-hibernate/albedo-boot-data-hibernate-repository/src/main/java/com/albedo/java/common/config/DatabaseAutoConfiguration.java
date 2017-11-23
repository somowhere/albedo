package com.albedo.java.common.config;

import com.albedo.java.common.domain.util.JSR310PersistenceConverters;
import com.fasterxml.jackson.datatype.hibernate5.Hibernate5Module;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingClass;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.mybatis.domains.AuditDateAware;
import org.springframework.data.repository.query.QueryLookupStrategy.Key;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import java.util.Date;

@Configuration
@EntityScan(basePackages = {"com.albedo.java.modules.*.domain"}, basePackageClasses = {JSR310PersistenceConverters.class})
@EnableJpaRepositories(value = {"com.albedo.java.modules.*.repository"}, queryLookupStrategy = Key.CREATE_IF_NOT_FOUND)
@EnableJpaAuditing(auditorAwareRef = "springSecurityAuditorAware")
@EnableTransactionManagement
public class DatabaseAutoConfiguration {

    private final Logger log = LoggerFactory.getLogger(DatabaseAutoConfiguration.class);

    /*
     * Support for Hibernate types in Jackson.
     */
    @Bean
    public Hibernate5Module hibernate5Module() {
        return new Hibernate5Module();
    }

    @Bean
    @ConditionalOnMissingClass
    public AuditorAware<String> springSecurityAuditorAware() {
        return new AuditorAware<String>() {
            @Override
            public String getCurrentAuditor() {
                return "1";
            }
        };
    }

    @Bean
    @ConditionalOnMissingClass
    public AuditDateAware<Date> auditDateAware() {
        return new AuditDateAware<Date>() {
            @Override
            public Date getCurrentDate() {
                return new Date();
            }
        };
    }

}
