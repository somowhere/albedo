package com.albedo.java.common.config;

import com.albedo.java.common.config.gateway.accesscontrol.AccessControlFilter;
import com.albedo.java.common.config.gateway.ratelimiting.RateLimitingFilter;
import com.albedo.java.common.config.gateway.responserewriting.SwaggerBasePathRewritingFilter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cloud.netflix.zuul.filters.RouteLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfiguration {

    @Configuration
    public static class SwaggerBasePathRewritingConfiguration {

        @Bean
        public SwaggerBasePathRewritingFilter swaggerBasePathRewritingFilter(){
            return new SwaggerBasePathRewritingFilter();
        }
    }

    @Configuration
    public static class AccessControlFilterConfiguration {

        @Bean
        public AccessControlFilter accessControlFilter(RouteLocator routeLocator, AlbedoProperties albedoProperties){
            return new AccessControlFilter(routeLocator, albedoProperties);
        }
    }

    /**
     * Configures the Zuul filter that limits the number of API calls per user.
     * <p>
     * This uses Bucket4J to limit the API calls
     */
    @Configuration
    @ConditionalOnProperty("albedo.gateway.rate-limiting.enabled")
    public static class RateLimitingConfiguration {

        private final AlbedoProperties albedoProperties;

        public RateLimitingConfiguration(AlbedoProperties albedoProperties) {
            this.albedoProperties = albedoProperties;
        }

        @Bean
        public RateLimitingFilter rateLimitingFilter() {
            return new RateLimitingFilter(albedoProperties);
        }
    }
}
