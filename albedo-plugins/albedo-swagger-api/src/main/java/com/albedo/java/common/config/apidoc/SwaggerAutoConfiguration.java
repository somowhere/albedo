package com.albedo.java.common.config.apidoc;

import com.albedo.java.common.config.ApplicationSwaggerProperties;
import com.albedo.java.common.config.apidoc.customizer.AlbedoSwaggerCustomizer;
import com.albedo.java.common.config.apidoc.customizer.SwaggerCustomizer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.condition.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Profile;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StopWatch;
import org.springframework.util.StringUtils;
import springfox.bean.validators.configuration.BeanValidatorPluginsConfiguration;
import springfox.documentation.schema.AlternateTypeRule;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import javax.servlet.Servlet;
import java.nio.ByteBuffer;
import java.util.*;

import static springfox.documentation.builders.PathSelectors.regex;

/**
 * Springfox Swagger configuration.
 * <p>
 * Warning! When having a lot of REST endpoints, Springfox can become a performance issue. In that
 * case, you can use a specific Spring profile for this class, so that only front-end developers
 * have access to the Swagger view.
 * @author somewhere
 */
@Configuration
@ConditionalOnWebApplication
@ConditionalOnClass({ApiInfo.class, BeanValidatorPluginsConfiguration.class,
	Servlet.class})
@Profile({"swagger"})
@AutoConfigureAfter({ApplicationSwaggerProperties.class})
@EnableSwagger2
@Import({BeanValidatorPluginsConfiguration.class})
public class SwaggerAutoConfiguration {
	public static final String STARTING_MESSAGE = "Starting Swagger";
	public static final String STARTED_MESSAGE = "Started Swagger in {} ms";
	public static final String MANAGEMENT_TITLE_SUFFIX = "Management API";
	public static final String MANAGEMENT_GROUP_NAME = "management";
	public static final String MANAGEMENT_DESCRIPTION = "Management endpoints documentation";
	private final Logger log = LoggerFactory.getLogger(SwaggerAutoConfiguration.class);

	private final ApplicationSwaggerProperties applicationSwaggerProperties;

	public SwaggerAutoConfiguration(ApplicationSwaggerProperties applicationSwaggerProperties) {
		this.applicationSwaggerProperties = applicationSwaggerProperties;
	}

	/**
	 * Springfox configuration for the API Swagger docs.
	 *
	 * @param swaggerCustomizers Swagger customizers
	 * @param alternateTypeRules alternate type rules
	 * @return the Swagger Springfox configuration
	 */
	@Bean
	@ConditionalOnMissingBean(name = "swaggerSpringfoxApiDocket")
	public Docket swaggerSpringfoxApiDocket(List<SwaggerCustomizer> swaggerCustomizers,
											ObjectProvider<AlternateTypeRule[]> alternateTypeRules) {
		log.debug(STARTING_MESSAGE);
		StopWatch watch = new StopWatch();
		watch.start();

		Docket docket = createDocket();

		// Apply all SwaggerCustomizers orderly.
		swaggerCustomizers.forEach(customizer -> customizer.customize(docket));

		// Add all AlternateTypeRules if available in spring bean factory.
		// Also you can add your rules in a customizer bean above.
		Optional.ofNullable(alternateTypeRules.getIfAvailable()).ifPresent(docket::alternateTypeRules);

		watch.stop();
		log.debug(STARTED_MESSAGE, watch.getTotalTimeMillis());
		return docket;
	}

	/**
	 * Albedo Swagger Customizer
	 *
	 * @return the Swagger Customizer of Albedo
	 */
	@Bean
	public AlbedoSwaggerCustomizer albedoSwaggerCustomizer() {
		return new AlbedoSwaggerCustomizer(applicationSwaggerProperties);
	}

	/**
	 * Springfox configuration for the management endpoints (actuator) Swagger docs.
	 *
	 * @param appName               the application name
	 * @param managementContextPath the path to access management endpoints
	 * @return the Swagger Springfox configuration
	 */
	@Bean
	@ConditionalOnClass(name = "org.springframework.boot.actuate.autoconfigure.ManagementServerProperties")
	@ConditionalOnProperty("management.endpoints.web.base-path")
	@ConditionalOnExpression("'${management.endpoints.web.base-path}'.length() > 0")
	@ConditionalOnMissingBean(name = "swaggerSpringfoxManagementDocket")
	public Docket swaggerSpringfoxManagementDocket(@Value("${spring.application.name:application}") String appName,
												   @Value("${management.endpoints.web.base-path}") String managementContextPath) {

		ApiInfo apiInfo = new ApiInfo(
			StringUtils.capitalize(appName) + " " + MANAGEMENT_TITLE_SUFFIX,
			MANAGEMENT_DESCRIPTION,
			applicationSwaggerProperties.getVersion(),
			"",
			ApiInfo.DEFAULT_CONTACT,
			"",
			"",
			new ArrayList<>()
		);

		return createDocket()
			.apiInfo(apiInfo)
			.useDefaultResponseMessages(applicationSwaggerProperties.isUseDefaultResponseMessages())
			.groupName(MANAGEMENT_GROUP_NAME)
			.host(applicationSwaggerProperties.getHost())
			.protocols(new HashSet<>(Arrays.asList(applicationSwaggerProperties.getProtocols())))
			.forCodeGeneration(true)
			.directModelSubstitute(ByteBuffer.class, String.class)
			.genericModelSubstitutes(ResponseEntity.class)
			.select()
			.paths(regex(managementContextPath + ".*"))
			.build();
	}

	protected Docket createDocket() {
		return new Docket(DocumentationType.SWAGGER_2);
	}
}
