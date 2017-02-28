package com.albedo.java.common.config.apidoc;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.domain.Globals;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StopWatch;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import javax.inject.Inject;
import java.util.Date;

import static springfox.documentation.builders.PathSelectors.regex;

/**
 * Springfox Swagger configuration.
 *
 * Warning! When having a lot of REST endpoints, Springfox can become a performance issue. In that
 * case, you can use a specific Spring profile for this class, so that only front-end developers
 * have access to the Swagger view.
 */
@Configuration
@EnableSwagger2
@Profile(Globals.SPRING_PROFILE_SWAGGER)
public class SwaggerConfiguration {

    private final Logger log = LoggerFactory.getLogger(SwaggerConfiguration.class);

    @Inject
	private AlbedoProperties albedoProperties;
    
    /**
     * Swagger Springfox configuration.
     *
     * @param albedoProperties the properties of the application
     * @return the Swagger Springfox configuration
     */
    @Bean
    public Docket swaggerSpringfoxDocket(AlbedoProperties albedoProperties) {
        log.debug("Starting Swagger");
        StopWatch watch = new StopWatch();
        watch.start();
        Contact contact = new Contact(
            albedoProperties.getSwagger().getContactName(),
            albedoProperties.getSwagger().getContactUrl(),
            albedoProperties.getSwagger().getContactEmail());

        ApiInfo apiInfo = new ApiInfo(
            albedoProperties.getSwagger().getTitle(),
            albedoProperties.getSwagger().getDescription(),
            albedoProperties.getSwagger().getVersion(),
            albedoProperties.getSwagger().getTermsOfServiceUrl(),
            contact,
            albedoProperties.getSwagger().getLicense(),
            albedoProperties.getSwagger().getLicenseUrl());

        Docket docket = new Docket(DocumentationType.SWAGGER_2)
            .apiInfo(apiInfo)
            .forCodeGeneration(true)
            .genericModelSubstitutes(ResponseEntity.class)
            .ignoredParameterTypes(java.sql.Date.class)
            .directModelSubstitute(java.time.LocalDate.class, java.sql.Date.class)
            .directModelSubstitute(java.time.ZonedDateTime.class, Date.class)
            .directModelSubstitute(java.time.LocalDateTime.class, Date.class)
            .select()
            .paths(regex(albedoProperties.getSwagger().getBasePath()))
            .build();
        watch.stop();
        log.debug("Started Swagger in {} ms", watch.getTotalTimeMillis());
        return docket;
    }
}
