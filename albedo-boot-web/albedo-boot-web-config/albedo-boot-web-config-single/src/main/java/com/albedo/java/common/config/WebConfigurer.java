package com.albedo.java.common.config;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.spring.DefaultProfileUtil;
import com.albedo.java.web.filter.CachingHttpHeadersFilter;
import com.albedo.java.web.filter.PageInitParamFilter;
import com.albedo.java.web.interceptor.OperateInterceptor;
import com.albedo.java.web.listener.ContextInitListener;
import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.servlet.InstrumentedFilter;
import com.codahale.metrics.servlets.MetricsServlet;
import io.undertow.UndertowOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.embedded.MimeMappings;
import org.springframework.boot.context.embedded.undertow.UndertowEmbeddedServletContainerFactory;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.env.Environment;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.annotation.Resource;
import javax.servlet.*;
import java.io.File;
import java.util.Arrays;
import java.util.EnumSet;

/**
 * Configuration of web application with Servlet 3.0 APIs.
 * @author somewhere
 */
@Configuration
public class WebConfigurer extends WebMvcConfigurerAdapter implements ServletContextInitializer, EmbeddedServletContainerCustomizer {

    private final Logger log = LoggerFactory.getLogger(WebConfigurer.class);
    @Resource
    private Environment env;

    @Resource
    private AlbedoProperties albedoProperties;

    private MetricRegistry metricRegistry;

    @Autowired(required = false)
    public void setMetricRegistry(MetricRegistry metricRegistry) {
        this.metricRegistry = metricRegistry;
    }

    public WebConfigurer(Environment env, AlbedoProperties props) {
        this.env = env;
        this.albedoProperties=props;
    }


    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        if (env.getActiveProfiles().length != 0) {
            log.info("Web application configuration, using profiles: {}", Arrays.toString(env.getActiveProfiles()));
        }
        EnumSet<DispatcherType> disps = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD,
                DispatcherType.ASYNC);
        initPageInitParamFilter(servletContext, disps);
        initMetrics(servletContext, disps);
        if (env.acceptsProfiles(Globals.SPRING_PROFILE_PRODUCTION)) {
            initCachingHttpHeadersFilter(servletContext, disps);
        }


        log.info("Web application fully configured");
    }



    /**
     * Customize the Servlet engine: Mime types, the document root, the cache.
     */
    @Override
    public void customize(ConfigurableEmbeddedServletContainer container) {
        MimeMappings mappings = new MimeMappings(MimeMappings.DEFAULT);
        // IE issue, see https://github.com/albedo/generator-albedo/pull/711
        mappings.add("html", "text/html;charset=utf-8");
        // CloudFoundry issue, see
        // https://github.com/cloudfoundry/gorouter/issues/64
        mappings.add("json", "text/html;charset=utf-8");
        container.setMimeMappings(mappings);
        // When running in an IDE or with ./mvnw spring-boot:run, set location
        // of the static web assets.
        setLocationForStaticAssets(container);

        /*
         * Enable HTTP/2 for Undertow - https://twitter.com/ankinson/status/829256167700492288
         * HTTP/2 requires HTTPS, so HTTP requests will fallback to HTTP/1.1.
         * See the AlbedoProperties class and your application-*.yml configuration files
         * for more information.
         */
        if (albedoProperties.getHttp().getVersion().equals(AlbedoProperties.Http.Version.V_2_0) &&
                container instanceof UndertowEmbeddedServletContainerFactory) {

            ((UndertowEmbeddedServletContainerFactory) container)
                    .addBuilderCustomizers(builder ->
                            builder.setServerOption(UndertowOptions.ENABLE_HTTP2, true));
        }

    }

    private void setLocationForStaticAssets(ConfigurableEmbeddedServletContainer container) {
        File root;
        String prefixPath = env.getProperty(DefaultProfileUtil.SPRING_WEB_ROOT_PREFIX);
        if (PublicUtil.isEmpty(prefixPath)) {
            prefixPath = DefaultProfileUtil.resolvePathPrefix(this.getClass());
        }
//        if (env.acceptsProfiles(Globals.SPRING_PROFILE_PRODUCTION)) {
//            root = new File(prefixPath + "target/www/");
//        } else {
            root = new File(prefixPath + "src/main/webapp/");
//        }
        if (root.exists() && root.isDirectory()) {
            log.info("root {}", root.getAbsolutePath());
            container.setDocumentRoot(root);
        }
    }


    /**
     * Initializes the caching HTTP Headers Filter.
     */
    private void initCachingHttpHeadersFilter(ServletContext servletContext, EnumSet<DispatcherType> disps) {
        log.debug("Registering Caching HTTP Headers Filter");
        FilterRegistration.Dynamic cachingHttpHeadersFilter = servletContext.addFilter("cachingHttpHeadersFilter",
                new CachingHttpHeadersFilter(albedoProperties));

        cachingHttpHeadersFilter.addMappingForUrlPatterns(disps, true, "/statics/*", "/WEB-INF/views/*", "classpath:/statics/*", "classpath:/WEB-INF/views/*");
        cachingHttpHeadersFilter.setAsyncSupported(true);

    }
    /**
     * Initializes the Page Init Params Filter.
     */
    private void initPageInitParamFilter(ServletContext servletContext, EnumSet<DispatcherType> disps) {
        log.debug("Registering PageInitParamFilter");
        FilterRegistration.Dynamic pageInitParamFilter = servletContext.addFilter(
                "pageInitParamFilter",
                new PageInitParamFilter());
        pageInitParamFilter.addMappingForUrlPatterns(disps, true,
                albedoProperties.getAdminPath("/*"));
        pageInitParamFilter.setAsyncSupported(true);
    }

    /**
     * Initializes Metrics.
     */
    private void initMetrics(ServletContext servletContext, EnumSet<DispatcherType> disps) {
        log.debug("Initializing Metrics registries");
        servletContext.setAttribute(InstrumentedFilter.REGISTRY_ATTRIBUTE, metricRegistry);
        servletContext.setAttribute(MetricsServlet.METRICS_REGISTRY, metricRegistry);

        log.debug("Registering Metrics Filter");
        log.info("servletContext {}", servletContext);
        FilterRegistration.Dynamic metricsFilter = servletContext.addFilter("webappMetricsFilter",
                new InstrumentedFilter());

        metricsFilter.addMappingForUrlPatterns(disps, true, "/*");
        metricsFilter.setAsyncSupported(true);

        log.debug("Registering Metrics Servlet");
        ServletRegistration.Dynamic metricsAdminServlet = servletContext.addServlet("metricsServlet",
                new MetricsServlet());

        metricsAdminServlet.addMapping(albedoProperties.getAdminPath("/management/metrics/*"));
        metricsAdminServlet.setAsyncSupported(true);
        metricsAdminServlet.setLoadOnStartup(2);

    }

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = albedoProperties.getCors();
        if (config.getAllowedOrigins() != null && !config.getAllowedOrigins().isEmpty()) {
            log.debug("Registering CORS filter");
            source.registerCorsConfiguration(albedoProperties.getAdminPath("/**"), config);
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
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new OperateInterceptor(albedoProperties)).addPathPatterns(albedoProperties.getAdminPath("/**"), "/management/**", "/api/**");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName(PublicUtil.isEmpty(albedoProperties.getDefaultView()) ? PublicUtil.toAppendStr("redirect:", albedoProperties.getAdminPath("/login")) : albedoProperties.getDefaultView());
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        super.addViewControllers(registry);
    }
    @Bean
    public ContextInitListener contextInitListener() {
        return new ContextInitListener();
    }

}
