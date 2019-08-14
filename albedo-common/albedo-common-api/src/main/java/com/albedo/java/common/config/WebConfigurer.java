package com.albedo.java.common.config;

import cn.hutool.core.util.ArrayUtil;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.DefaultProfileUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.filter.BodyFilter;
import com.albedo.java.common.security.filter.CachingHttpHeadersFilter;
import com.albedo.java.common.security.filter.PasswordDecoderFilter;
import io.undertow.UndertowOptions;
import lombok.AllArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.embedded.undertow.UndertowServletWebServerFactory;
import org.springframework.boot.web.server.MimeMappings;
import org.springframework.boot.web.server.WebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.EnumSet;

/**
 * Configuration of web application with Servlet 3.0 APIs.
 *
 * @author somewhere
 */
@Configuration
@AllArgsConstructor
public class WebConfigurer implements ServletContextInitializer, WebServerFactoryCustomizer<WebServerFactory>, WebMvcConfigurer {

	private final Logger log = LoggerFactory.getLogger(WebConfigurer.class);

	private final Environment env;

	private final ApplicationProperties applicationProperties;

	private final PasswordDecoderFilter passwordDecoderFilter;


	@Override
	public void onStartup(ServletContext servletContext) {
		if (env.getActiveProfiles().length != 0) {
			log.info("Web application configuration, using profiles: {}", Arrays.toString(env.getActiveProfiles()));
		}
		EnumSet<DispatcherType> disps = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD,
			DispatcherType.ASYNC);
//        initPageInitParamFilter(servletContext, disps);
//        initMetrics(servletContext, disps);
		if (ArrayUtil.contains(env.getActiveProfiles(), CommonConstants.SPRING_PROFILE_PRODUCTION)) {
			initCachingHttpHeadersFilter(servletContext, disps);
		}
		log.debug("Registering bodyFilter");
		FilterRegistration.Dynamic bodyFilter = servletContext.addFilter(
			"bodyFilter",
			new BodyFilter(applicationProperties));
		bodyFilter.addMappingForUrlPatterns(disps, true,
			applicationProperties.getAdminPath("/*"));
		bodyFilter.setAsyncSupported(true);

		log.info("Web application fully configured");
	}

	@Bean
	public FilterRegistrationBean<PasswordDecoderFilter> passwordDecoderFilterRegistrationBean() {
		log.debug("Registering passwordDecoderFilter");
		FilterRegistrationBean<PasswordDecoderFilter> registrationBean = new FilterRegistrationBean<>();
		registrationBean.setFilter(this.passwordDecoderFilter);
		registrationBean.addUrlPatterns(applicationProperties.getAdminPath("/*"));
		return registrationBean;
	}

	/**
	 * Customize the Servlet engine: Mime types, the document root, the cache.
	 */
	@Override
	public void customize(WebServerFactory server) {
		setMimeMappings(server);
		// When running in an IDE or with ./mvnw spring-boot:run, set location
		// of the static web assets.
		setLocationForStaticAssets(server);

		/*
		 * Enable HTTP/2 for Undertow - https://twitter.com/ankinson/status/829256167700492288
		 * HTTP/2 requires HTTPS, so HTTP requests will fallback to HTTP/1.1.
		 * See the ApplicationProperties class and your application-*.yml configuration files
		 * for more information.
		 */
		if (applicationProperties.getHttp().getVersion().equals(ApplicationProperties.Http.Version.V_2_0) &&
			server instanceof UndertowServletWebServerFactory) {
			((UndertowServletWebServerFactory) server)
				.addBuilderCustomizers(builder ->
					builder.setServerOption(UndertowOptions.ENABLE_HTTP2, true));
		}

	}

	private void setMimeMappings(WebServerFactory server) {
		if (server instanceof ConfigurableServletWebServerFactory) {
			MimeMappings mappings = new MimeMappings(MimeMappings.DEFAULT);
			// IE issue, see https://github.com/jhipster/generator-jhipster/pull/711
			mappings.add("html", MediaType.TEXT_HTML_VALUE + ";charset=" + StandardCharsets.UTF_8.name().toLowerCase());
			// CloudFoundry issue, see https://github.com/cloudfoundry/gorouter/issues/64
			mappings.add("json", MediaType.TEXT_HTML_VALUE + ";charset=" + StandardCharsets.UTF_8.name().toLowerCase());
			ConfigurableServletWebServerFactory servletWebServer = (ConfigurableServletWebServerFactory) server;
			servletWebServer.setMimeMappings(mappings);
		}
	}

	private void setLocationForStaticAssets(WebServerFactory server) {
		log.info("server:" + server);
		if (server instanceof ConfigurableServletWebServerFactory) {
			ConfigurableServletWebServerFactory servletWebServer = (ConfigurableServletWebServerFactory) server;
			File root;
			String prefixPath = env.getProperty(DefaultProfileUtil.SPRING_WEB_ROOT_PREFIX);
			if (StringUtil.isEmpty(prefixPath)) {
				prefixPath = DefaultProfileUtil.resolvePathPrefix(this.getClass()) + "src/main/webapp/";
			}
			log.info("web root:" + prefixPath);
			root = new File(prefixPath);
			if (root.exists() && root.isDirectory()) {
				servletWebServer.setDocumentRoot(root);
			}
		}
	}


	/**
	 * Initializes the caching HTTP Headers Filter.
	 */
	private void initCachingHttpHeadersFilter(ServletContext servletContext, EnumSet<DispatcherType> disps) {
		log.debug("Registering Caching HTTP Headers Filter");
		FilterRegistration.Dynamic cachingHttpHeadersFilter = servletContext.addFilter("cachingHttpHeadersFilter",
			new CachingHttpHeadersFilter(applicationProperties));

		cachingHttpHeadersFilter.addMappingForUrlPatterns(disps, true, "/statics/*", "/WEB-INF/views/*", "classpath:/statics/*", "classpath:/WEB-INF/views/*");
		cachingHttpHeadersFilter.setAsyncSupported(true);

	}
//    /**
//     * Initializes the Page Init Params Filter.
//     */
//    private void initPageInitParamFilter(ServletContext servletContext, EnumSet<DispatcherType> disps) {
//        log.debug("Registering PageInitParamFilter");
//        FilterRegistration.Dynamic pageInitParamFilter = servletContext.addFilter(
//                "pageInitParamFilter",
//                new PageInitParamFilter());
//        pageInitParamFilter.addMappingForUrlPatterns(disps, true,
//                ApplicationProperties.getAdminPath("/*"));
//        pageInitParamFilter.setAsyncSupported(true);
//    }

	@Bean
	public CorsFilter corsFilter() {
		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		CorsConfiguration config = applicationProperties.getCors();
		if (config.getAllowedOrigins() != null && !config.getAllowedOrigins().isEmpty()) {
			log.debug("Registering CORS filter");
			source.registerCorsConfiguration(applicationProperties.getAdminPath("/**"), config);
			source.registerCorsConfiguration("/management/**", config);
			source.registerCorsConfiguration("/v2/api-docs", config);
		}
		return new CorsFilter(source);
	}

//    @Bean
//    public FilterRegistrationBean testFilterRegistration() {
//
//        FilterRegistrationBean registration = new FilterRegistrationBean();
//        registration.setFilter(new SimpleCORSFilter());
//        registration.addUrlPatterns("/*");
//        registration.setName("simpleCORSFilter");
//        registration.setOrder(0);
//        return registration;
//    }

//    @Bean
//    public FilterRegistrationBean corsFilter() {
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        CorsConfiguration config = new CorsConfiguration();
//        config.setAllowCredentials(true);
//        // 设置你要允许的网站域名，如果全允许则设为 *
//        config.addAllowedOrigin("*");
//        // 如果要限制 HEADER 或 METHOD 请自行更改
//        config.addAllowedHeader("*");
//        config.addAllowedMethod("*");
//        source.registerCorsConfiguration("/**", config);
//        FilterRegistrationBean bean = new FilterRegistrationBean(new CorsFilter(source));
//        // 这个顺序很重要哦，为避免麻烦请设置在最前
//        bean.setOrder(0);
//        return bean;
//    }

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName(StringUtil.isEmpty(applicationProperties.getDefaultView()) ? "index.html" : applicationProperties.getDefaultView());
		registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
	}

}
